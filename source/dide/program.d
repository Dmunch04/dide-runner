module dide.program;

import std.stdio : writeln;
import std.array : join;
import std.json;
import std.file : rmdirRecurse;
import std.array : appender;
import std.base64 : Base64;

import dide.models : ResultModel, Payload, MemoryFile;
import dide.utils : createTempFolder, getLanguage;
import dide.command : runCommand;
import dide.language : Language;

/++
 + main class of the program which handles the input arguments and prints the result to console
 +/
public class Program
{
    public this(string[] args)
    {
        if (args.length < 1)
        {
            throw new Exception("You must provide the base64 encoded json data");
        }

        handleArgs(args);
    }

    private void handleArgs(string[] args)
    {
        if (args[0] == "-v" || args[0] == "--version")
        {
            writeln("Dide Runner v0.1.0b1");
        }
        else if (args[0] == "-h" || args[0] == "--help")
        {
            writeln("Run with base64 encoded json data");
        }
        else
        {
            ResultModel res = run(args[0]);
            JSONValue model;
            model["stdout"] = res.stdout;
            model["stderr"] = res.stderr;

            writeln(toJSON(model));
        }
    }

    private ResultModel run(string encodedJson)
    {
        auto builder = appender!string();
        Base64.decode(encodedJson, builder);
        string rawJson = builder.data();
        JSONValue jsonData = parseJSON(rawJson);
        
        MemoryFile[] files;
        foreach (file; jsonData["files"].array())
        {
            files ~= MemoryFile(file["name"].str(), file["content"].str());
        }

        string[] options;
        foreach (option; jsonData["options"].array())
        {
            options ~= option.str();
        }

        string[string] dependencies;
        foreach (dependency; jsonData["dependencies"].object().byKeyValue())
        {
            dependencies[dependency.key] = dependency.value.str();
        }

        Payload payload = Payload(
            jsonData["language"].str(),
            files,
            jsonData["entry"].str(),
            options,
            dependencies
        );

        if (payload.files.length < 1)
        {
            throw new Exception("No files provided");
        }

        string projectPath = createTempFolder();
        scope(exit) rmdirRecurse(projectPath);

        Language lang = getLanguage(payload.language);
        if (lang is null)
        {
            throw new Exception("unknown/unsupported project language");
        }

        lang.createEnv(projectPath, payload);
        return lang.run(projectPath, payload);
    }
}
