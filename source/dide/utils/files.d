module dide.utils.files;

import std.ascii : letters;
import std.conv : to;
import std.path : buildPath;
import std.random : randomSample;
import std.utf : byCodeUnit;
import std.file : tempDir, mkdir;
import std.stdio : File, write;

import dide.models : MemoryFile;

public string createTempFolder()
{
    auto id = letters.byCodeUnit.randomSample(8).to!string;
    string path = tempDir.buildPath("dide.runner-" ~ id);
    mkdir(path);

    return path;
}

public void writeFiles(string projectPath, MemoryFile[] files)
{
    string path = projectPath.buildPath("source");
    mkdir(path);

    foreach (file; files)
    {
        writeFile(path, file);
    }
}

public void writeFile(string projectPath, MemoryFile file)
{
    auto f = File(projectPath.buildPath(file.name), "w");
    f.write(file.content);
    f.close();
}