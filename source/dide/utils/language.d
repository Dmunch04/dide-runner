module dide.utils.language;

import dide.language;

/++
 + returns the correct language according to the given string, if none found returns `null`
 +/
public Language getLanguage(string lang)
{
    switch (lang)
    {
        case "d", "dlang": return new Dlang();
        case "py", "python": return new Python();
        case "java": return new Java();
        case "kt", "kotlin": return new Kotlin();
        case "cs", "csharp": return new CSharp();
        case "js", "javascript": return new Javascript();
        case "ts", "typescript": return new Typescript();
        case "go", "golang": return new Golang();
        case "rs", "rust": return new Rust();
        default: return null;
    }
}