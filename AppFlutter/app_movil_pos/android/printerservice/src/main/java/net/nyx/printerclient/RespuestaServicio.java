package net.nyx.printerclient;

public class RespuestaServicio<T> {
    private boolean success;
    private String message;
    private T data;

    public RespuestaServicio(boolean success, String message, T data) {
        this.success = success;
        this.message = message;
        this.data = data;
    }

    public boolean isSuccess() {
        return success;
    }

    public String getMessage() {
        return message;
    }

    public T getData() {
        return data;
    }
}
