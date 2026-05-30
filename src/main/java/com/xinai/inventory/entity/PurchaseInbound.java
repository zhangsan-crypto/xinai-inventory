package com.xinai.inventory.entity;

import java.util.Date;

public class PurchaseInbound {
    private Integer inboundId;
    private String planId;
    private String materialId;
    private String materialName;
    private String specModel;
    private Integer inboundQty;
    private Date inboundDate;
    private Integer supplierId;
    private String operator;
    private String warehouseKeeper;
    private String status;
    private String remark;
    private Date createTime;

    public Integer getInboundId() { return inboundId; }
    public void setInboundId(Integer inboundId) { this.inboundId = inboundId; }
    public String getPlanId() { return planId; }
    public void setPlanId(String planId) { this.planId = planId; }
    public String getMaterialId() { return materialId; }
    public void setMaterialId(String materialId) { this.materialId = materialId; }
    public String getMaterialName() { return materialName; }
    public void setMaterialName(String materialName) { this.materialName = materialName; }
    public String getSpecModel() { return specModel; }
    public void setSpecModel(String specModel) { this.specModel = specModel; }
    public Integer getInboundQty() { return inboundQty; }
    public void setInboundQty(Integer inboundQty) { this.inboundQty = inboundQty; }
    public Date getInboundDate() { return inboundDate; }
    public void setInboundDate(Date inboundDate) { this.inboundDate = inboundDate; }
    public Integer getSupplierId() { return supplierId; }
    public void setSupplierId(Integer supplierId) { this.supplierId = supplierId; }
    public String getOperator() { return operator; }
    public void setOperator(String operator) { this.operator = operator; }
    public String getWarehouseKeeper() { return warehouseKeeper; }
    public void setWarehouseKeeper(String warehouseKeeper) { this.warehouseKeeper = warehouseKeeper; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
}
