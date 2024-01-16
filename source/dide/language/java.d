module dide.language.java;

import std.stdio : File;
import std.path : buildPath, stripExtension;
import std.format : format;
import std.array : join;

import dide.language : Language;
import dide.command : runCommand;
import dide.models : ResultModel, Payload;
import dide.utils : writeFiles;

enum GRADLE_TEMPLATE = "plugins {
    id 'application'
}
repositories {
    mavenCentral()
}
dependencies {
%s
}
application {
    mainClass = 'dide.%s'
}
";

public class Java : Language
{
    public ResultModel run(string projectPath, Payload payload)
    {
        string[] args = ["gradle"];
        if (payload.options.length > 0)
        {
            args ~= payload.options;
        }
        args ~= ":run";

        return runCommand(projectPath, args);
    }

    public void createEnv(string projectPath, Payload payload)
    {
        writeFiles(projectPath.buildPath("src/main/java/dide"), payload.files);

        string[] dependencies;
        foreach (dependency; payload.dependencies.byKeyValue)
        {
            if (dependency.value == "" || dependency.value == "*")
            {
                dependencies ~= "\timplementation '" ~ dependency.key ~ "'";
            }
            else
            {
                dependencies ~= "\timplementation '" ~ dependency.key ~ ":" ~ dependency.value ~ "'";
            }
        }

        File gradle = File(projectPath.buildPath("build.gradle"), "w");
        gradle.write(GRADLE_TEMPLATE.format(dependencies.join("\n"), stripExtension(payload.entry)));
        gradle.close();
    }
}