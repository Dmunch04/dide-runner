package me.Munchii.Dide.Languages;

import me.Munchii.Dide.Models.ResultModel;

import java.nio.file.Path;

public interface Language {

    ResultModel run(Path projectPath);

}
