package me.Munchii.Dide.Languages;

import me.Munchii.Dide.Models.ResultModel;

import java.nio.file.Path;
import java.util.List;
import java.util.Map;

/**
 * All language extensions must implement this.
 */
public interface Language {

    /**
     * Runs the project and returns the result.
     *
     * @param projectPath The path of the project.
     * @param options Command line options to be added to the run command if any.
     * @return The result of the project after being run.
     */
    ResultModel run(Path projectPath, List<String> options);

    /**
     * Creates the environment for the project and makes everything ready to be run.
     *
     * @param basePath The projects base path.
     * @param entry The projects entry point in form of a file name.
     * @param dependencies A map of dependencies and their version, that the project depends on.
     */
    void createEnvironment(Path basePath, String entry, Map<String, String> dependencies);

}
