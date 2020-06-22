package me.Munchii.Dide;

import com.fasterxml.jackson.databind.ObjectMapper;

import me.Munchii.Dide.JSON.Payload;
import me.Munchii.Dide.JSON.Result;
import me.Munchii.Dide.Models.ResultModel;
import me.Munchii.Dide.Utils.Helper;

import java.io.IOException;
import java.nio.file.Path;
import java.util.List;

public class Runner {

    public static void main(String[] args) {
        ResultModel result;
        if (args.length >= 1) {
            result = run(args[0]);
        } else {
            String json = "{ \"language\": \"d\", \"files\": [{ \"name\": \"app.d\", \"content\": \"import std.stdio;void main() { writeln('a'); }\" }], \"command\": \"\", \"dependencies\": { \"vibe-d\": \"*\" } }";
            result = run(json);
        }

        if (result == null) {
            System.err.println("Something went wrong while compiling!");
        } else {
            printResult(result);
        }
    }

    public static ResultModel run(String json) {
        try {
            ObjectMapper mapper = new ObjectMapper();
            Payload payload = mapper.readValue(json, Payload.class);

            if (payload.files.size() == 0) {
                Helper.crash("No files given!");
            }

            List<Path> paths = Helper.writeFiles(payload.files);

            ResultModel result;
            if (payload.command.equals("")) {
                result = Helper.runLanguage(payload.language, paths.get(0).toAbsolutePath().getParent(), payload.dependencies);
                return result;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }

    public static void printResult(ResultModel result) {
        result.stdout = result.stdout.replaceAll("\"", "\\\\\"").replaceAll("\n", "?@N!");
        result.stderr = result.stderr.replaceAll("\"", "\\\\\"").replaceAll("\n", "?@N!");
        String error = result.getFixedErrorMessage().replaceAll("\"", "\\\\\"").replaceAll("\n", "?@N!");

        StringBuilder builder = new StringBuilder();
        builder.append("{").append("\n");
        builder.append("\t").append("\"stdout\"").append(":").append(" ").append("\"").append(result.stdout).append("\"").append(",").append("\n");
        builder.append("\t").append("\"stderr\"").append(":").append(" ").append("\"").append(result.stderr).append("\"").append(",").append("\n");
        builder.append("\t").append("\"error\"").append(":").append(" ").append("\"").append(error).append("\"").append("\n");
        builder.append("}");

        try {
            ObjectMapper mapper = new ObjectMapper();
            Result payload = mapper.readValue(builder.toString(), Result.class);
        } catch (IOException e) {
            e.printStackTrace();
        }

        System.out.println(builder.toString());
    }

}
