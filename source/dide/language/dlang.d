module dide.language.dlang;

import std.json;
import std.stdio : File;
import std.path : buildPath;

import dide.language : Language;
import dide.command : runCommand;
import dide.models : ResultModel, Payload, ProgramOptions;
import dide.utils : writeFiles;

public class Dlang : Language
{
    public ResultModel run(string projectPath, Payload payload, ProgramOptions pOptions)
    {
        string[] args = ["dub", "run"];
        if (payload.options.length > 0)
        {
            args ~= payload.options;
        }

        if (pOptions.outputSetup)
        {
            return runCommands(projectPath, ["dub", "upgrade"], args);
        }
        else
        {
            runCommand(projectPath, ["dub", "upgrade"]);
            return runCommand(projectPath, args);
        }
    }

    public void createEnv(string projectPath, Payload payload)
    {
        writeFiles(projectPath.buildPath("source"), payload.files);

        JSONValue config;

        config["name"] = "dide-project";
        config["sourcePaths"] = ["source"];
        config["targetType"] = "executable";
        config["mainSourceFile"] = "source/" ~ payload.entry;
        config["dependencies"] = payload.dependencies;

        File dub = File(projectPath.buildPath("dub.json"), "w");
        dub.write(toJSON(config));
        dub.close();
    }
}