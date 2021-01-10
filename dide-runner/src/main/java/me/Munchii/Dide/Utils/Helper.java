package me.Munchii.Dide.Utils;

import me.Munchii.Dide.JSON.MemoryFile;
import me.Munchii.Dide.Languages.D;
import me.Munchii.Dide.Languages.Language;
import me.Munchii.Dide.Languages.Zig;
import me.Munchii.Dide.Models.ResultModel;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;
import java.nio.file.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

public class Helper {

    public static Language getLanguage(String language) {
        switch (language) {
            case "d": return new D();
            case "zig": return new Zig();
            default: return null;
        }
    }

    public static ResultModel runLanguage(List<String> options, String language, Path projectPath, Map<String, String> dependencies) {
        Language lang = getLanguage(language.toLowerCase(Locale.ROOT));
        if (lang != null) {
            lang.createEnvironment(projectPath, dependencies);
            ResultModel result = lang.run(projectPath, options);
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

    public static void deleteDir(Path path) {
        try {
            FileUtils.deleteDirectory(new File(path.toAbsolutePath().toString()));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
