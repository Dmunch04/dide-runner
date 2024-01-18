module dide.language.golang;

import std.stdio : File;
import std.path : buildPath;
import std.format : format;
import std.array : join;

import dide.language : Language;
import dide.command : runCommand;
import dide.models : ResultModel, Payload;
import dide.utils : writeFiles;

enum MOD_TEMPLATE = `module dide/app
go 1.21.6
require (
%s
)
`;

public class Golang : Language
{
    public ResultModel run(string projectPath, Payload payload)
    {
        string[] args = ["go", "run"];
        if (payload.options.length > 0)
        {
            foreach (arg; payload.options)
            {
                // TODO: no quiet flag for go
                if (arg == "-q" || arg == "--quiet")
                {
                    continue;
                }

                args ~= arg;
            }
        }
        args ~= ".";

        return runCommand(projectPath, args);
    }

    public void createEnv(string projectPath, Payload payload)
    {
        writeFiles(projectPath, payload.files);

        string[] dependencies;
        foreach (dependency; payload.dependencies.byKeyValue)
        {
            dependencies ~= "\t" ~ dependency.key ~ " " ~ dependency.value;
        }

        File modFile = File(projectPath.buildPath("go.mod"), "w");
        modFile.write(MOD_TEMPLATE.format(dependencies.join("\n")));
        modFile.close();

        runCommand(projectPath, ["go", "install"]);
    }
}