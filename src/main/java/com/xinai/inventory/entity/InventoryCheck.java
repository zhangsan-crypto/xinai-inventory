package com.xinai.inventory.entity;

import java.util.Date;

public class InventoryCheck {
    private String checkId;
    private String checkYear;
    private String checkMonth;
    private String checkSeq;
    private String materialId;
    private String materialName;
    private Integer bookQty;
    private Integer actualQty;
    private Integer diffQty;
    private String diffReason;
    private Date checkDate;
    private String checker;
    private String approvalStatus;
    private String approver;
    private String remark;
    private Date createTime;

    public String getCheckId() { return checkId; }
    public void setCheckId(String checkId) { this.checkId = checkId; }
    public String getCheckYear() { return checkYear; }
    public void setCheckYear(String checkYear) { this.checkYear = checkYear; }
    public String getCheckMonth() { return checkMonth; }
    public void setCheckMonth(String checkMonth) { this.checkMonth = checkMonth; }
    public String getCheckSeq() { return checkSeq; }
    public void setCheckSeq(String checkSeq) { this.checkSeq = checkSeq; }
    public String getMaterialId() { return materialId; }
    public void setMaterialId(String materialId) { this.materialId = materialId; }
    public String getMaterialName() { return materialName; }
    public void setMaterialName(String materialName) { this.materialName = materialName; }
    public Integer getBookQty() { return bookQty; }
    public void setBookQty(Integer bookQty) { this.bookQty = bookQty; }
    public Integer getActualQty() { return actualQty; }
    public void setActualQty(Integer actualQty) { this.actualQty = actualQty; }
    public Integer getDiffQty() { return diffQty; }
    public void setDiffQty(Integer diffQty) { this.diffQty = diffQty; }
    public String getDiffReason() { return diffReason; }
    public void setDiffReason(String diffReason) { this.diffReason = diffReason; }
    public Date getCheckDate() { return checkDate; }
    public void setCheckDate(Date checkDate) { this.checkDate = checkDate; }
    public String getChecker() { return checker; }
    public void setChecker(String checker) { this.checker = checker; }
    public String getApprovalStatus() { return approvalStatus; }
    public void setApprovalStatus(String approvalStatus) { this.approvalStatus = approvalStatus; }
    public String getApprover() { return approver; }
    public void setApprover(String approver) { this.approver = approver; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
}
