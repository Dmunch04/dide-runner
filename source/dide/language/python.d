module dide.language.python;

import std.stdio : File;
import std.path : buildPath;

import dide.language : Language;
import dide.command : runCommand;
import dide.models : ResultModel, Payload;

public class Python : Language
{
    public ResultModel run(string projectPath, Payload payload)
    {
        string[] args = ["python", "source/" ~ payload.entry];
        if (payload.options.length > 1)
        {
            args ~= payload.options;
        }

        return runCommand(projectPath, args);
    }

    public void createEnv(string projectPath, Payload payload)
    {
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

        runCommand(projectPath, ["pip", "install", "-r", "requirements.txt"]);
    }
}