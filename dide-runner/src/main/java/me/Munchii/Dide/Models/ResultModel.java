package me.Munchii.Dide.Models;

import java.util.Arrays;

public class ResultModel {

    public String stdout;
    public String stderr;
    public Exception error;

    public ResultModel(String stdout, String stderr, Exception error) {
        this.stdout = stdout;
        this.stderr = stderr;
        this.error = error;
    }

    public boolean hasError() {
        return !stderr.equals("") || error != null;
    }

    public String getFixedErrorMessage() {
        if (error != null) {
            String[] values = error.getCause().getLocalizedMessage().split(", ");
            return String.join(", ", Arrays.copyOfRange(values, 1, values.length));
        } else {
            return "";
        }
    }
}
