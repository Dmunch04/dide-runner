package me.Munchii.Dide.Languages;

import me.Munchii.Dide.Command;
import me.Munchii.Dide.Models.ResultModel;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;

public class D implements Language {

    /*
    public ResultModel run(List<String> files, String stdin) {
        Path workDir = Paths.get(files.get(0)).toAbsolutePath().getParent();
        String binName = "a.out";

        List<String> sourceFiles = Helper.filterByExtension(files, "d");
        //List<String> args = Arrays.asList("dmd", "-of" + binName, String.join(" ", sourceFiles));
        List<String> args = Arrays.asList("dub", "build");

        ResultModel result = Command.run(workDir.toString(), args);
        if (result.error != null || !result.stderr.equals("")) {
            return result;
        }

        Path binPath = Paths.get(workDir.toString(), binName);
        return Command.runStdin(workDir.toString(), stdin, binPath.toAbsolutePath().toString());
    }
    */

    public ResultModel run(Path projectPath) {
        Path workDir = Paths.get(projectPath.toString()).toAbsolutePath().getParent();
        List<String> args = Arrays.asList("dub", "run");
        ResultModel result = Command.run(workDir.toString(), args);
        return result;
    }

}
