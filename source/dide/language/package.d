module dide.language;

public import dide.language.dlang;
public import dide.language.python;

import dide.models : ResultModel, Payload;

public interface Language
{
    public ResultModel run(string projectPath, Payload payload);

    public void createEnv(string projectPath, Payload payload);
}