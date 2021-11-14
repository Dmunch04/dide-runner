package me.Munchii.Dide.Languages;

import me.Munchii.Dide.Command;
import me.Munchii.Dide.Models.ResultModel;
import me.Munchii.Dide.Utils.Helper;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import static java.util.Arrays.asList;

/**
 * Language extension for Python code.
 */
public class Python implements Language {

    @Override
    public ResultModel run(Path projectPath, List<String> options) {
        Path workDir = Paths.get(projectPath.toString()).toAbsolutePath().getParent();

        List<String> args = new ArrayList<>(asList("poetry", "run", "start"));
        if (!options.isEmpty())
            args.addAll(options);

        return Command.run(workDir.toString(), args);
    }

    @Override
    public void createEnvironment(Path basePath, String entry, Map<String, String> dependencies) {
        StringBuilder builder = new StringBuilder();

        builder.append("[tool.poetry]").append("\n");
        //builder.append("name = \"project\"").append("\n");
        builder.append("name = \"source\"").append("\n");
        builder.append("version = \"0.1.0\"").append("\n");
        builder.append("description = \"\"").append("\n");
        builder.append("authors = [\"Munchii\", \"anonymous?\"]").append("\n");

        builder.append("\n").append("[tool.poetry.dependencies]").append("\n");
        // TODO: is this a good enough solution?
        //builder.append("python = \"^3.8\"").append("\n");
        builder.append("python = \"^3.7\"").append("\n");
        dependencies.forEach((dep, ver) -> builder.append("\"").append(dep).append("\"").append(" = ").append("\"").append(ver).append("\"").append("\n"));

        builder.append("\n").append("[tool.poetry.scripts]").append("\n");
        builder.append("start = \"source.").append(Helper.removeAnyExtension(entry)).append("\"").append("\n");
        
        builder.append("\n").append("[build-system]").append("\n");
        builder.append("requires = [\"poetry>=0.12\"]").append("\n");
        builder.append("build-backend = \"poetry.masonry.api\"");

        try {
            Path path = Paths.get(basePath.toAbsolutePath().getParent().toString(), "pyproject.toml").toAbsolutePath();
            new File(path.toAbsolutePath().getParent().toString()).mkdirs();
            Files.write(path, builder.toString().getBytes());
            Command.run(basePath.toString(), asList("poetry", "update"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
