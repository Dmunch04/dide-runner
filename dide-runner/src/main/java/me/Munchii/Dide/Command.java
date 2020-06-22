package me.Munchii.Dide;

import me.Munchii.Dide.Models.ResultModel;

import java.io.*;
import java.util.List;

public class Command {

    public static ResultModel run(String workDir, List<String> args) {
        StringBuilder stdoutBuilder = new StringBuilder();
        StringBuilder stderrBuilder = new StringBuilder();
        Exception error = null;

        String values = String.join(" ", args.subList(1, args.size()));
        String command = String.join(" ", args.get(0), values);

        try {
            Runtime runtime = Runtime.getRuntime();
            Process process = runtime.exec(command, null, new File(workDir));

            BufferedReader inputReader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            BufferedReader errorReader = new BufferedReader(new InputStreamReader(process.getErrorStream()));

            String inputLine;
            while ((inputLine = inputReader.readLine()) != null) {
                stdoutBuilder.append(inputLine).append("\n");
            }
            if (stdoutBuilder.length() > 1)
                stdoutBuilder.deleteCharAt(stdoutBuilder.length() - 1);

            String errorLine;
            while ((errorLine = errorReader.readLine()) != null) {
                stderrBuilder.append(errorLine).append("\n");
            }
            if (stderrBuilder.length() > 1)
                stderrBuilder.deleteCharAt(stderrBuilder.length() - 1);
        } catch (Exception e) {
            error = e;
        }

        return new ResultModel(stdoutBuilder.toString(), stderrBuilder.toString(), error);
    }

}
