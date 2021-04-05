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

public class Zig implements Language {

    @Override
    public ResultModel run(Path projectPath, List<String> options) {
        Path workDir = Paths.get(projectPath.toString()).toAbsolutePath().getParent();
        System.out.println(workDir);

        List<String> args = new ArrayList<>(Arrays.asList("zig", "build", "run"));
        if (!options.isEmpty())
            args.addAll(options);

        return Command.run(workDir.toString(), args);
    }

    @Override
    public void createEnvironment(Path basePath, String entry, Map<String, String> dependencies) {
        StringBuilder builder = new StringBuilder();
        builder.append("const Builder = @import(\"std\").build.Builder;").append("\n");
        builder.append("pub fn build(b: *Builder) void { ").append("\n");
        builder.append("const mode = b.standardReleaseOptions();").append("\n");
        builder.append("const exe = b.addExecutable(\"project\", \"source/main.zig\");").append("\n");
        builder.append("exe.setBuildMode(mode);").append("\n");
        builder.append("const run_cmd = exe.run();");
        builder.append("const run_step = b.step(\"run\", \"run the app\");").append("\n");
        builder.append("run_step.dependOn(&run_cmd.step);").append("\n");
        builder.append("b.default_step.dependOn(&exe.step);").append("\n");
        builder.append("b.installArtifact(exe);").append("\n");
        builder.append(" }");
        // TODO: integrate the entry point

        try {
            Path path = Paths.get(basePath.toAbsolutePath().getParent().toString(), "build.zig").toAbsolutePath();
            new File(path.toAbsolutePath().getParent().toString()).mkdirs();
            Files.write(path, builder.toString().getBytes());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
