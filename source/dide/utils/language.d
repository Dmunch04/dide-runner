module dide.utils.language;

import dide.language;

public Language getLanguage(string lang)
{
    switch (lang)
    {
        case "d": return new Dlang();
        case "python": return new Python();
        default: return null;
    }
}