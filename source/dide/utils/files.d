module dide.utils.files;

import std.ascii : letters;
import std.conv : to;
import std.path : buildPath;
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
    //string path = projectPath.buildPath("src");
    string path = projectPath;
    if (!path.exists)
    {
        mkdirRecurse(path);
    }

    foreach (file; files)
    {
        writeFile(path, file);
    }
}

/++
 + writes a `MemoryFile` to disk at the specified path
 +/
public void writeFile(string projectPath, MemoryFile file)
{
    auto f = File(projectPath.buildPath(file.name), "w");
    f.write(file.content);
    f.close();
}