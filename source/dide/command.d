module dide.command;

import std.array : split;
import std.path : buildPath;
import std.stdio : File, stdin;
import std.process : spawnProcess, wait, Config;

import dide.models;

/++
 + runs a command at the specified path and returns the console result of the command
 +/
public ResultModel runCommand(string projectPath, string cmd)
{
    return runCommand(projectPath, cmd.split(" "));
}

/++
 + runs a command at the specified path and returns the console result of the command
 +/
public ResultModel runCommand(string projectPath, string[] args)
{
    auto outFile = File(projectPath.buildPath(".out"), "w");
    auto errFile = File(projectPath.buildPath(".err"), "w");
    auto pid = spawnProcess(args, stdin, outFile, errFile, null, Config(Config.Flags.none), projectPath);

    if (wait(pid) != 0)
    {
        throw new Exception("could not compile project");
    }

    outFile.open(projectPath.buildPath(".out"), "r");
    errFile.open(projectPath.buildPath(".err"), "r");

    string line;
    string stdout;
    while ((line = outFile.readln()) !is null)
        stdout ~= line;

    string stderr;
    while ((line = errFile.readln()) !is null)
        stderr ~= line;

    return ResultModel(stdout, stderr);
}

public ResultModel runCommands(A...)(string projectPath, A cmds)
{
    import std.array : join;
    import std.format : format;

    auto outFile = File(projectPath.buildPath(".out"), "w");
    auto errFile = File(projectPath.buildPath(".err"), "w");
    foreach (cmd; cmds)
    {
        outFile.open(projectPath.buildPath(".out"), "a");
        errFile.open(projectPath.buildPath(".err"), "a");
        auto pid = spawnProcess(cmd, stdin, outFile, errFile, null, Config(Config.Flags.none), projectPath);

        if (wait(pid) != 0)
        {
            throw new Exception("execution of command '%s' failed".format(cmd.join(" ")));
        }
    }

    outFile.open(projectPath.buildPath(".out"), "r");
    errFile.open(projectPath.buildPath(".err"), "r");

    string line;
    string stdout;
    while ((line = outFile.readln()) !is null)
        stdout ~= line;

    string stderr;
    while ((line = errFile.readln()) !is null)
        stderr ~= line;

    return ResultModel(stdout, stderr);
}