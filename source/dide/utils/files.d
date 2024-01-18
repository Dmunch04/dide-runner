module dide.utils.files;

import std.ascii : letters;
import std.conv : to;
import std.path : buildPath, dirName;
import std.random : randomSample;
import std.utf : byCodeUnit;
import std.file : tempDir, mkdir, mkdirRecurse, exists;
import std.stdio : File, write;

import dide.models : MemoryFile;

/++
 + creates a temporary folder and returns its path
 +/
public string createTempFolder()
{
    auto id = letters.byCodeUnit.randomSample(8).to!string;
    string path = tempDir.buildPath("dide.runner-" ~ id);
    mkdir(path);

    return path;
}

/++
 + writes an array of `MemoryFile` to disk at the specified path
 +/
public void writeFiles(string projectPath, MemoryFile[] files)
{
    if (!projectPath.exists)
    {
        mkdirRecurse(projectPath);
    }

    foreach (file; files)
    {
        writeFile(projectPath, file);
    }
}

/++
 + writes a `MemoryFile` to disk at the specified path
 +/
public void writeFile(string projectPath, MemoryFile file)
{
    auto path = projectPath.buildPath(file.name);
    auto dir = dirName(path);
    if (!exists(dir)) mkdirRecurse(dir);
    auto f = File(path, "w");
    f.write(file.content);
    f.close();
}