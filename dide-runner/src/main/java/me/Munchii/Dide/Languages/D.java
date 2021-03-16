package me.Munchii.Dide.Languages;

import me.Munchii.Dide.Command;
import me.Munchii.Dide.Models.ResultModel;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

public class D implements Language {

    @Override
    public ResultModel run(Path projectPath, List<String> options) {
        Path workDir = Paths.get(projectPath.toString()).toAbsolutePath().getParent();

        List<String> args = new ArrayList<>(Arrays.asList("dub", "run"));
        if (!options.isEmpty())
            args.addAll(options);

        return Command.run(workDir.toString(), args);
    }

    @Override
    public void createEnvironment(Path basePath, Map<String, String> dependencies) {
        StringBuilder builder = new StringBuilder();
        builder.append("{").append("\n");

        builder.append("\t").append("\"name\": \"project\",").append("\n");
        builder.append("\t").append("\"sourcePaths\": [\"source\"],").append("\n");
        builder.append("\t").append("\"targetType\": \"executable\",").append("\n");

        builder.append("\t").append("\"dependencies\": {").append("\n");
        dependencies.forEach((dep, ver) -> builder.append("\t\t").append("\"").append(dep).append("\": ").append("\"").append(ver).append("\",").append("\n"));
        if (dependencies.size() > 1)
            builder.deleteCharAt(builder.length() - 2);
        builder.append("\t").append("}").append("\n");

        builder.append("}");

        try {
            Path path = Paths.get(basePath.toAbsolutePath().getParent().toString(), "dub.json").toAbsolutePath();
            new File(path.toAbsolutePath().getParent().toString()).mkdirs();
            Files.write(path, builder.toString().getBytes());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
