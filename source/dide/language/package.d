module dide.language;

public import dide.language.dlang;
public import dide.language.python;
public import dide.language.java;
public import dide.language.kotlin;
public import dide.language.csharp;
public import dide.language.javascript;
public import dide.language.typescript;
public import dide.language.golang;
public import dide.language.rust;

import dide.models : ResultModel, Payload;

/++
 + interface base for project language
 +/
public interface Language
{
    /++
     + run the project and returns the result
     +/
    public ResultModel run(string projectPath, Payload payload);

    /++
     + create the necessary environment for the specific language
     +/
    public void createEnv(string projectPath, Payload payload);
}