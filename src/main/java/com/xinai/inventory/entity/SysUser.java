package com.xinai.inventory.entity;

import java.util.Date;

public class SysUser {
    private String userId;
    private String username;
    private String password;
    private String deptCode;
    private String postCode;
    private String userSeq;
    private String role;
    private String status;
    private Date createTime;
    private Date updateTime;

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getDeptCode() { return deptCode; }
    public void setDeptCode(String deptCode) { this.deptCode = deptCode; }
    public String getPostCode() { return postCode; }
    public void setPostCode(String postCode) { this.postCode = postCode; }
    public String getUserSeq() { return userSeq; }
    public void setUserSeq(String userSeq) { this.userSeq = userSeq; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public Date getUpdateTime() { return updateTime; }
    public void setUpdateTime(Date updateTime) { this.updateTime = updateTime; }

    public String getDeptName() {
        if ("01".equals(deptCode)) return "采购部";
        if ("02".equals(deptCode)) return "销售部";
        if ("03".equals(deptCode)) return "仓储部";
        if ("04".equals(deptCode)) return "行政部";
        if ("05".equals(deptCode)) return "财务部";
        return "未知";
    }

    public String getPostName() {
        if ("01".equals(postCode)) return "采购人员";
        if ("02".equals(postCode)) return "销售人员";
        if ("03".equals(postCode)) return "仓库人员";
        if ("04".equals(postCode)) return "管理员";
        if ("05".equals(postCode)) return "财务人员";
        return "未知";
    }

    public String getRoleName() {
        if ("admin".equals(role)) return "系统管理员";
        if ("purchase".equals(role)) return "采购人员";
        if ("sale".equals(role)) return "销售人员";
        if ("warehouse".equals(role)) return "仓库人员";
        return "未知";
    }

    public String getStatusName() {
        return "0".equals(status) ? "启用" : "禁用";
    }
}
