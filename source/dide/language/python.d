module dide.language.python;

import std.stdio : File;
import std.path : buildPath;

import dide.language : Language;
import dide.command : runCommand, runCommands;
import dide.models : ResultModel, Payload, ProgramOptions;
import dide.utils : writeFiles;

public class Python : Language
{
    public ResultModel run(string projectPath, Payload payload, ProgramOptions pOptions)
    {
        string[] args = ["python3", "source/" ~ payload.entry];
        if (payload.options.length > 0)
        {
            args ~= payload.options;
        }

        if (pOptions.outputSetup)
        {
            return runCommands(projectPath, ["pip3", "install", "-r", "requirements.txt"], args);
        }
        else
        {
            runCommand(projectPath, ["pip3", "install", "-r", "requirements.txt"]);
            return runCommand(projectPath, args);
        }
    }

    public void createEnv(string projectPath, Payload payload)
    {
        writeFiles(projectPath.buildPath("source"), payload.files);

        File reqs = File(projectPath.buildPath("requirements.txt"), "w");
        foreach (dependency; payload.dependencies.byKeyValue)
        {
            if (dependency.value == "" || dependency.value == "*")
            {
                reqs.writeln(dependency.key);
            }
            else
            {
                reqs.writeln(dependency.key ~ "==" ~ dependency.value);
            }
        }
        reqs.close();
    }
}