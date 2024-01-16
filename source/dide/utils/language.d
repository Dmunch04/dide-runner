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
        default: return null;
    }
}