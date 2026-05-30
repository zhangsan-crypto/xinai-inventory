package com.xinai.inventory.entity;

import java.util.Date;
public class PurchasePlan {
    private String planId;
    private String planYear;
    private String planMonth;
    private String planSeq;
    private String materialId;
    private String materialName;
    private String specModel;
    private Integer demandQty;
    private String planDate;
    private String applicant;
    private String approvalStatus;
    private String approver;
    private Date approvalTime;
    private String remark;
    private Date createTime;
    private Date updateTime;

    public String getPlanId() { return planId; }
    public void setPlanId(String planId) { this.planId = planId; }
    public String getPlanYear() { return planYear; }
    public void setPlanYear(String planYear) { this.planYear = planYear; }
    public String getPlanMonth() { return planMonth; }
    public void setPlanMonth(String planMonth) { this.planMonth = planMonth; }
    public String getPlanSeq() { return planSeq; }
    public void setPlanSeq(String planSeq) { this.planSeq = planSeq; }
    public String getMaterialId() { return materialId; }
    public void setMaterialId(String materialId) { this.materialId = materialId; }
    public String getMaterialName() { return materialName; }
    public void setMaterialName(String materialName) { this.materialName = materialName; }
    public String getSpecModel() { return specModel; }
    public void setSpecModel(String specModel) { this.specModel = specModel; }
    public Integer getDemandQty() { return demandQty; }
    public void setDemandQty(Integer demandQty) { this.demandQty = demandQty; }
    public String getPlanDate() { return planDate; }
    public void setPlanDate(String planDate) { this.planDate = planDate; }
    public String getApplicant() { return applicant; }
    public void setApplicant(String applicant) { this.applicant = applicant; }
    public String getApprovalStatus() { return approvalStatus; }
    public void setApprovalStatus(String approvalStatus) { this.approvalStatus = approvalStatus; }
    public String getApprover() { return approver; }
    public void setApprover(String approver) { this.approver = approver; }
    public Date getApprovalTime() { return approvalTime; }
    public void setApprovalTime(Date approvalTime) { this.approvalTime = approvalTime; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public Date getUpdateTime() { return updateTime; }
    public void setUpdateTime(Date updateTime) { this.updateTime = updateTime; }
}
