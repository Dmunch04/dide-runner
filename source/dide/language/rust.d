module dide.language.rust;

import std.stdio : File;
import std.path : buildPath;
import std.format : format;
import std.array : join;

import dide.language : Language;
import dide.command : runCommand;
import dide.models : ResultModel, Payload;
import dide.utils : writeFiles;

enum CARGO_TEMPLATE = `[package]
name = "dide"
version = "0.1.0"
edition = "2021"

[dependencies]
%s
`;

public class Rust : Language
{
    public ResultModel run(string projectPath, Payload payload)
    {
        string[] args = ["cargo", "run"];
        if (payload.options.length > 0)
        {
            args ~= payload.options;
        }

        return runCommand(projectPath, args);
    }

    public void createEnv(string projectPath, Payload payload)
    {
        writeFiles(projectPath.buildPath("src"), payload.files);

        string[] dependencies;
        foreach (dependency; payload.dependencies.byKeyValue)
        {
            dependencies ~= dependency.key ~ " = \"" ~ dependency.value ~ "\"";
        }

        File modFile = File(projectPath.buildPath("Cargo.toml"), "w");
        modFile.write(CARGO_TEMPLATE.format(dependencies.join("\n")));
        modFile.close();

        runCommand(projectPath, ["cargo", "update"]);
        runCommand(projectPath, ["cargo", "build"]);
    }
}