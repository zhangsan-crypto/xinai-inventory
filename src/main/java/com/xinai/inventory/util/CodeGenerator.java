package com.xinai.inventory.util;

import java.text.DecimalFormat;
import java.util.regex.Pattern;

/**
 * 编码生成工具类 - 严格遵循论文5.2节代码设计
 * 编码规则：
 * - 用户账号：YH + 部门编码(2位) + 岗位编码(2位) + 用户序号(2位) = 7位
 * - 材料编号：CL + 材料大类编码(2位) + 材料规格编码(2位) + 材料序号(4位) = 9位
 * - 采购计划编号：CG + 年份(4位) + 月份(2位) + 采购计划序号(4位) = 11位
 * - 销售订单编号：XS + 年份(4位) + 月份(2位) + 销售订单序号(4位) = 11位
 * - 库存盘点单号：PD + 年份(4位) + 月份(2位) + 库存盘点序号(4位) = 11位
 */
public class CodeGenerator {

    private static final Pattern USER_CODE_PATTERN = Pattern.compile("^YH\\d{6}$");
    private static final Pattern MATERIAL_CODE_PATTERN = Pattern.compile("^CL\\d{8}$");
    private static final Pattern PLAN_CODE_PATTERN = Pattern.compile("^CG\\d{10}$");
    private static final Pattern ORDER_CODE_PATTERN = Pattern.compile("^XS\\d{10}$");
    private static final Pattern CHECK_CODE_PATTERN = Pattern.compile("^PD\\d{10}$");

    /**
     * 生成用户账号：YH + 部门编码(2位) + 岗位编码(2位) + 序号(2位)
     */
    public static String generateUserCode(String deptCode, String postCode, int seq) {
        String code = "YH" + deptCode + postCode + formatSeq(seq, 2);
        if (!USER_CODE_PATTERN.matcher(code).matches()) {
            throw new IllegalArgumentException("生成的用户账号格式不正确: " + code);
        }
        return code;
    }

    /**
     * 生成材料编号：CL + 大类编码(2位) + 规格编码(2位) + 序号(4位)
     */
    public static String generateMaterialCode(String categoryCode, String specCode, int seq) {
        String code = "CL" + categoryCode + specCode + formatSeq(seq, 4);
        if (!MATERIAL_CODE_PATTERN.matcher(code).matches()) {
            throw new IllegalArgumentException("生成的材料编号格式不正确: " + code);
        }
        return code;
    }

    /**
     * 生成采购计划编号：CG + 年份(4位) + 月份(2位) + 序号(4位)
     */
    public static String generatePlanCode(String year, String month, int seq) {
        String code = "CG" + year + month + formatSeq(seq, 4);
        if (!PLAN_CODE_PATTERN.matcher(code).matches()) {
            throw new IllegalArgumentException("生成的采购计划编号格式不正确: " + code);
        }
        return code;
    }

    /**
     * 生成销售订单编号：XS + 年份(4位) + 月份(2位) + 序号(4位)
     */
    public static String generateOrderCode(String year, String month, int seq) {
        String code = "XS" + year + month + formatSeq(seq, 4);
        if (!ORDER_CODE_PATTERN.matcher(code).matches()) {
            throw new IllegalArgumentException("生成的销售订单编号格式不正确: " + code);
        }
        return code;
    }

    /**
     * 生成库存盘点单号：PD + 年份(4位) + 月份(2位) + 序号(4位)
     */
    public static String generateCheckCode(String year, String month, int seq) {
        String code = "PD" + year + month + formatSeq(seq, 4);
        if (!CHECK_CODE_PATTERN.matcher(code).matches()) {
            throw new IllegalArgumentException("生成的库存盘点单号格式不正确: " + code);
        }
        return code;
    }

    /**
     * 序号补零对齐
     */
    private static String formatSeq(int seq, int length) {
        StringBuilder fmt = new StringBuilder();
        for (int i = 0; i < length; i++) {
            fmt.append("0");
        }
        DecimalFormat df = new DecimalFormat(fmt.toString());
        return df.format(seq);
    }

    // 编码格式校验
    public static boolean isValidUserCode(String code) { return USER_CODE_PATTERN.matcher(code).matches(); }
    public static boolean isValidMaterialCode(String code) { return MATERIAL_CODE_PATTERN.matcher(code).matches(); }
    public static boolean isValidPlanCode(String code) { return PLAN_CODE_PATTERN.matcher(code).matches(); }
    public static boolean isValidOrderCode(String code) { return ORDER_CODE_PATTERN.matcher(code).matches(); }
    public static boolean isValidCheckCode(String code) { return CHECK_CODE_PATTERN.matcher(code).matches(); }
}
