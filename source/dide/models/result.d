module dide.models.result;

/++
 + struct representing the result of a project after being run
 +/
public struct ResultModel
{
    /++
     + the result output to stdout
     +/
    string stdout;

    /++
     + the result output to stderr
     +/
    string stderr;
}