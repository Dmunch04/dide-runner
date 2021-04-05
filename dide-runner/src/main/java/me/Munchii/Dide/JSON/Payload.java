package me.Munchii.Dide.JSON;

import java.util.List;
import java.util.Map;

/**
 * Class containing the information of the project, parsed from the JSON given from the CLI
 */
public class Payload {

    /**
     * The language of the project and the given files.
     * May only be a supported language, else abort.
     */
    public String language;

    /**
     * The list of memory files that the project contains
     * @see me.Munchii.Dide.JSON.MemoryFile
     */
    public List<MemoryFile> files;

    /**
     * The name of the entry file.
     * Must be the exact name of one of the given memory files,
     * else abort.
     * @see me.Munchii.Dide.JSON.Payload#files
     */
    public String entry;

    /**
     * List of command options to be added to the run command.
     * Can be empty if none.
     */
    public List<String> options;

    /**
     * A map of dependencies and their version,
     * to be added to the project.
     */
    public Map<String, String> dependencies;

}
