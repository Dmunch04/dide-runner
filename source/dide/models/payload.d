module dide.models.payload;

/++
 + struct representing the json data payload
 +/
public struct Payload
{
    /++
     + the language of the projects and the project files (`MemoryFile`)
     +/
    public string language;

    /++
     + array of all the project files
     +/
    public MemoryFile[] files;

    /++
     + the entry/main file of the project
     +/
    public string entry;

    /++
     + array of options to be given to the compiler
     +/
    public string[] options;

    /++
     + map of project dependecies (name:version)
     +/
    public string[string] dependencies;
}

/++
 + struct representing project file to be written in temp folder
 +/
public struct MemoryFile
{
    /++
     + the name of the file
     +/
    public string name;

    /++
     + the contents of the file
     +/
    public string content;
}