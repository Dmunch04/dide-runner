module dide.command;

import std.array : split;
import std.path : buildPath;
import std.stdio : File, stdin;
import std.process : spawnProcess, wait, Config;

import dide.models;

public ResultModel runCommand(string projectPath, string cmd)
{
    return runCommand(projectPath, cmd.split(" "));
}

public ResultModel runCommand(string projectPath, string[] args)
{
    auto outFile = File(projectPath.buildPath(".out"), "w");
    auto errFile = File(projectPath.buildPath(".err"), "w");
    auto pid = spawnProcess(args, stdin, outFile, errFile, null, Config(Config.Flags.none), projectPath);
    wait(pid);

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