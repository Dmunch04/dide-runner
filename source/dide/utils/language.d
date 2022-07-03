module dide.utils.language;

import dide.language;

/++
 + returns the correct language according to the given string, if none found returns `null`
 +/
public Language getLanguage(string lang)
{
    switch (lang)
    {
        case "d": return new Dlang();
        case "python": return new Python();
        default: return null;
    }
}