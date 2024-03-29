module dide.language.csharp;

import std.stdio : File;
import std.path : buildPath, stripExtension;
import std.format : format;
import std.array : join;

import dide.language : Language;
import dide.command : runCommand, runCommands;
import dide.models : ResultModel, Payload, ProgramOptions;
import dide.utils : writeFiles;

enum CSPROJ_TEMPLATE = `<Project Sdk="Microsoft.NET.Sdk">
    <PropertyGroup>
        <OutputType>Exe</OutputType>
        <TargetFramework>net8.0</TargetFramework>
        <ImplicitUsings>enable</ImplicitUsings>
        <Nullable>enable</Nullable>
    </PropertyGroup>

    <ItemGroup>
%s
    </ItemGroup>
</Project>
`;

public class CSharp : Language
{
    public ResultModel run(string projectPath, Payload payload, ProgramOptions pOptions)
    {
        string[] args = ["dotnet", "run"];
        if (payload.options.length > 0)
        {
            args ~= payload.options;
        }

        if (pOptions.outputSetup)
        {
            return runCommands(projectPath, ["dotnet", "restore"], args);
        }
        else
        {
            runCommand(projectPath, ["dotnet", "restore"]);
            return runCommand(projectPath, args);
        }

    }

    public void createEnv(string projectPath, Payload payload)
    {
        writeFiles(projectPath, payload.files);

        string[] dependencies;
        foreach (dependency; payload.dependencies.byKeyValue)
        {
            dependencies ~= "<PackageReference Include=\"" ~ dependency.key ~ "\" Version=\"" ~ dependency.value ~ "\" />";
        }

        File csproj = File(projectPath.buildPath("dide.csproj"), "w");
        csproj.write(CSPROJ_TEMPLATE.format(dependencies.join("\n")));
        csproj.close();
    }
}