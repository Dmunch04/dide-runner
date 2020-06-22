package me.Munchii.Dide.Utils;

import me.Munchii.Dide.JSON.MemoryFile;
import me.Munchii.Dide.Languages.D;
import me.Munchii.Dide.Languages.Language;
import me.Munchii.Dide.Models.ResultModel;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;
import java.nio.file.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class Helper {

    public static List<String> filterByExtension(List<String> files, String extension) {
        List<String> newFiles = new ArrayList<String>();
        String suffix = "." + extension;
        PathMatcher matcher = FileSystems.getDefault().getPathMatcher("glob:*" + suffix);

        for (String file : files) {
            if (matcher.matches(Paths.get(file))) {
                newFiles.add(file);
            }
        }

        return newFiles;
    }

    public static Language getLanguage(String language) {
        switch (language) {
            case "d": return new D();
            default: return null;
        }
    }

    public static ResultModel runLanguage(String language, Path projectPath, Map<String, String> dependencies) {
        Language lang = getLanguage(language);
        if (lang != null) {
            createDubFile(projectPath, dependencies);
            ResultModel result = lang.run(projectPath);
            deleteDir(projectPath.toAbsolutePath().getParent());
            return result;
        } else {
            crash("Invalid language: " + language);
            return null;
        }
    }

    public static List<Path> writeFiles(List<MemoryFile> files) {
        List<Path> paths = new ArrayList<>();

        try {
            Path tempPath = Files.createTempDirectory("dide.runner-");
            for (MemoryFile file : files) {
                paths.add(writeFile(tempPath, file));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return paths;
    }

    public static Path writeFile(Path basePath, MemoryFile file) {
        Path path = Paths.get("");

        try {
            path = Paths.get(basePath.toAbsolutePath().toString(), "source", file.name).toAbsolutePath();
            new File(path.toAbsolutePath().getParent().toString()).mkdirs();
            Files.write(path, file.content.getBytes());
        } catch (IOException e) {
            e.printStackTrace();
        }

        return path;
    }

    public static void crash(String msg) {
        System.err.println(msg);
        System.exit(1);
    }

    public static void createDubFile(Path basePath, Map<String, String> dependencies) {
        StringBuilder builder = new StringBuilder();
        builder.append("{").append("\n");

        builder.append("\t").append("\"name\": \"project\",").append("\n");
        builder.append("\t").append("\"sourcePaths\": [\"source\"],").append("\n");

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

    public static void deleteDir(Path path) {
        try {
            FileUtils.deleteDirectory(new File(path.toAbsolutePath().toString()));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
