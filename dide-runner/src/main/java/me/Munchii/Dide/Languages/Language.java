package me.Munchii.Dide.Languages;

import me.Munchii.Dide.Models.ResultModel;

import java.nio.file.Path;
import java.util.List;
import java.util.Map;

public interface Language {

    ResultModel run(Path projectPath, List<String> options);

    void createEnvironment(Path basePath, Map<String, String> dependencies);

}
