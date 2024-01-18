module dide.language.typescript;

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

enum TS_TEMPLATE = `{
    "extends": "@tsconfig/node18/tsconfig.json",
    "include": ["src/**/*"],
    "outDir": "./build",
    "exclude": ["node_modules", "build"],
    "compilerOptions": {
        "allowJs": true,
        "types": ["node"]
    }
}
`;

public class Typescript : Language
{
    public ResultModel run(string projectPath, Payload payload)
    {
        string[] args = ["node", "src/" ~ stripExtension(payload.entry) ~ ".js"];
        if (payload.options.length > 0)
        {
            args ~= payload.options;
        }

        return runCommand(projectPath, args);
    }

    public void createEnv(string projectPath, Payload payload)
    {
        writeFiles(projectPath.buildPath("src"), payload.files);

        string[string] _;
        JSONValue dependencies = JSONValue(_);
        dependencies["typescript"] = JSONValue("^5.3.3");
        dependencies["@tsconfig/node18"] = JSONValue("^18.2.2");
        dependencies["@types/node"] = JSONValue("20.11.5");
        foreach (dependency; payload.dependencies.byKeyValue)
        {
            dependencies[dependency.key] = JSONValue(dependency.value);
        }

        File packageJson = File(projectPath.buildPath("package.json"), "w");
        packageJson.write(PACKAGE_TEMPLATE.format(dependencies.toString));
        packageJson.close();

        File typescriptConfig = File(projectPath.buildPath("tsconfig.json"), "w");
        typescriptConfig.write(TS_TEMPLATE);
        typescriptConfig.close();

        runCommand(projectPath, ["npm", "install"]);
        runCommand(projectPath, ["npx", "--yes", "tsc"]);
    }
}