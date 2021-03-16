package me.Munchii.Dide;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import me.Munchii.Dide.JSON.Payload;
import me.Munchii.Dide.Models.ResultModel;
import me.Munchii.Dide.Utils.Helper;

import java.io.IOException;
import java.nio.file.Path;
import java.util.List;

public class Runner {

    // TODO: Zig command cannot be run?

    public static void main(String[] args) {
        ResultModel result;

        if (args.length >= 1) {
            if (args[0].equals("-v") || args[0].equals("--version"))
            {
                System.out.println("v1.0.2");
                System.exit(0);
            }

            result = run(String.join(" ", args));
        } else {
            // D test data
            //String json = "{ \"language\": \"d\", \"files\": [{ \"name\": \"app.d\", \"content\": \"import std.stdio;void main() { writeln(\\\"Hello, World!\\\"); }\" }], \"options\": [\"-q\"], \"dependencies\": { \"vibe-d\": \"*\" } }";
            String json = "{ \"language\": \"d\", \"files\": [{ \"name\": \"app.d\", \"content\": \"import viva.io;void main() { println(\\\"Hello, World!\\\"); }\" }], \"options\": [\"-q\"], \"dependencies\": { \"viva\": \"*\" } }";
            //String json = "{\"dependencies\":{\"viva\":\"*\"},\"language\":\"d\",\"options\":[],\"files\":[{\"content\":\"import hello;\\r\\n\\r\\nvoid main()\\r\\n{\\r\\n    sayHello(\\\"Daniel\\\");\\r\\n}\",\"name\":\"app.d\"},{\"content\":\"import viva.io;\\r\\n\\r\\npublic void sayHello(string name)\\r\\n{\\r\\n    println(\\\"Hello, \\\" ~ name ~ \\\"!\\\");\\r\\n}\",\"name\":\"hello.d\"}]}";

            // Zig test data
            /*
            String json = """
                {
                    "language": "zig",
                    "options": [],
                    "dependencies": {},
                    "files": [
                        {
                            "name": "main.zig",
                            "content": "const std=@import(\\"std\\");\\npub fn main() !void {\\nconst stdout=std.io.getStdOut().writer();try stdout.print(\\"Hello, {s}!\\\\n\\", .{\\"World\\"});\\n}"
                        }
                    ]
                }
            """;
            */

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

            System.out.println(payload.files);
            List<Path> paths = Helper.writeFiles(payload.files);

            ResultModel result;
            result = Helper.runLanguage(payload.options, payload.language, paths.get(0).toAbsolutePath().getParent(), payload.dependencies);
            return result;
        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }

    public static void printResult(ResultModel result) {
        ObjectMapper mapper = new ObjectMapper();

        try {
            String jsonResult = mapper.writeValueAsString(result);
            System.out.println(jsonResult);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
    }

}
