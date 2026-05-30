package com.xinai.inventory.exception;

import com.xinai.inventory.util.Result;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@ControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @ExceptionHandler(Exception.class)
    @ResponseBody
    public Result handleException(Exception e) {
        logger.error("系统异常", e);
        return Result.error("操作失败: " + e.getMessage());
    }

    @ExceptionHandler(IllegalArgumentException.class)
    @ResponseBody
    public Result handleIllegalArgument(IllegalArgumentException e) {
        logger.warn("参数错误", e);
        return Result.error("参数错误: " + e.getMessage());
    }

    @ExceptionHandler(NumberFormatException.class)
    @ResponseBody
    public Result handleNumberFormat(NumberFormatException e) {
        logger.warn("数字格式错误", e);
        return Result.error("数据格式错误");
    }
}
