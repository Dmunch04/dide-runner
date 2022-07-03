module dide.language;

public import dide.language.dlang;
public import dide.language.python;

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