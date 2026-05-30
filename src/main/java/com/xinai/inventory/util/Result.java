package com.xinai.inventory.util;

import java.util.HashMap;
import java.util.Map;

public class Result {
    private int code;
    private String msg;
    private Object data;
    private long count;

    public Result() {}

    public Result(int code, String msg, Object data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    public static Result success() {
        return new Result(0, "操作成功", null);
    }

    public static Result success(String msg) {
        return new Result(0, msg, null);
    }

    public static Result success(Object data) {
        return new Result(0, "操作成功", data);
    }

    public static Result success(String msg, Object data) {
        return new Result(0, msg, data);
    }

    public static Result page(Object data, long count) {
        Result r = new Result(0, "查询成功", data);
        r.setCount(count);
        return r;
    }

    public static Result error(String msg) {
        return new Result(1, msg, null);
    }

    public static Result error(int code, String msg) {
        return new Result(code, msg, null);
    }

    public int getCode() { return code; }
    public void setCode(int code) { this.code = code; }
    public String getMsg() { return msg; }
    public void setMsg(String msg) { this.msg = msg; }
    public Object getData() { return data; }
    public void setData(Object data) { this.data = data; }
    public long getCount() { return count; }
    public void setCount(long count) { this.count = count; }
}
