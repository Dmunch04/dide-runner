module dide.language.javascript;

import std.json;
import std.stdio : File;
import std.path : buildPath, stripExtension;
import std.format : format;

import dide.language : Language;
import dide.command : runCommand;
import dide.models : ResultModel, Payload;
import dide.utils : writeFiles;

enum PACKAGE_TEMPLATE = `{
    "name": "dide",
    "version": "0.0.1",
    "dependencies": %s
}
`;

public class Javascript : Language
{
    public ResultModel run(string projectPath, Payload payload)
    {
        string[] args = ["node", payload.entry];
        if (payload.options.length > 0)
        {
            args ~= payload.options;
        }

        return runCommand(projectPath, args);
    }

    public void createEnv(string projectPath, Payload payload)
    {
        writeFiles(projectPath, payload.files);

        string[string] _;
        JSONValue dependencies = JSONValue(_);
        foreach (dependency; payload.dependencies.byKeyValue)
        {
            dependencies[dependency.key] = JSONValue(dependency.value);
        }

        File packageJson = File(projectPath.buildPath("package.json"), "w");
        packageJson.write(PACKAGE_TEMPLATE.format(dependencies.toString));
        packageJson.close();

        runCommand(projectPath, ["npm", "install"]);
    }
}