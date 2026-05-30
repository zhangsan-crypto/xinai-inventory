package com.xinai.inventory.entity;

import java.util.Date;

public class SalesReturn {
    private Integer returnId;
    private String orderId;
    private Integer customerId;
    private String materialId;
    private String materialName;
    private Integer returnQty;
    private String returnReason;
    private Date returnDate;
    private String approvalStatus;
    private String operator;
    private String status;
    private String remark;
    private Date createTime;

    public Integer getReturnId() { return returnId; }
    public void setReturnId(Integer returnId) { this.returnId = returnId; }
    public String getOrderId() { return orderId; }
    public void setOrderId(String orderId) { this.orderId = orderId; }
    public Integer getCustomerId() { return customerId; }
    public void setCustomerId(Integer customerId) { this.customerId = customerId; }
    public String getMaterialId() { return materialId; }
    public void setMaterialId(String materialId) { this.materialId = materialId; }
    public String getMaterialName() { return materialName; }
    public void setMaterialName(String materialName) { this.materialName = materialName; }
    public Integer getReturnQty() { return returnQty; }
    public void setReturnQty(Integer returnQty) { this.returnQty = returnQty; }
    public String getReturnReason() { return returnReason; }
    public void setReturnReason(String returnReason) { this.returnReason = returnReason; }
    public Date getReturnDate() { return returnDate; }
    public void setReturnDate(Date returnDate) { this.returnDate = returnDate; }
    public String getApprovalStatus() { return approvalStatus; }
    public void setApprovalStatus(String approvalStatus) { this.approvalStatus = approvalStatus; }
    public String getOperator() { return operator; }
    public void setOperator(String operator) { this.operator = operator; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
}
