package com.xinai.inventory.entity;

import java.util.Date;

public class PurchaseReturn {
    private Integer returnId;
    private Integer inboundId;
    private String materialId;
    private String materialName;
    private Integer returnQty;
    private String returnReason;
    private Date returnDate;
    private Integer supplierId;
    private String operator;
    private String status;
    private String remark;
    private Date createTime;

    public Integer getReturnId() { return returnId; }
    public void setReturnId(Integer returnId) { this.returnId = returnId; }
    public Integer getInboundId() { return inboundId; }
    public void setInboundId(Integer inboundId) { this.inboundId = inboundId; }
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
    public Integer getSupplierId() { return supplierId; }
    public void setSupplierId(Integer supplierId) { this.supplierId = supplierId; }
    public String getOperator() { return operator; }
    public void setOperator(String operator) { this.operator = operator; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
}
