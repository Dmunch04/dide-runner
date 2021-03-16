package me.Munchii.Dide.Models;

import java.util.Arrays;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonAlias;

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

    public String getError() {
        if (error != null) {
            if (error.getCause() != null) {
                String[] values = error.getCause().getLocalizedMessage().split(", ");
                return String.join(", ", Arrays.copyOfRange(values, 1, values.length));
            } else {
                return error.getMessage();
            }
        } else {
            return "";
        }

    }
}
