package com.xinai.inventory.entity;

import java.util.Date;

public class SalesOutbound {
    private Integer outboundId;
    private String orderId;
    private String materialId;
    private String materialName;
    private Integer outboundQty;
    private Date outboundDate;
    private String operator;
    private String warehouseKeeper;
    private String status;
    private String remark;
    private Date createTime;

    public Integer getOutboundId() { return outboundId; }
    public void setOutboundId(Integer outboundId) { this.outboundId = outboundId; }
    public String getOrderId() { return orderId; }
    public void setOrderId(String orderId) { this.orderId = orderId; }
    public String getMaterialId() { return materialId; }
    public void setMaterialId(String materialId) { this.materialId = materialId; }
    public String getMaterialName() { return materialName; }
    public void setMaterialName(String materialName) { this.materialName = materialName; }
    public Integer getOutboundQty() { return outboundQty; }
    public void setOutboundQty(Integer outboundQty) { this.outboundQty = outboundQty; }
    public Date getOutboundDate() { return outboundDate; }
    public void setOutboundDate(Date outboundDate) { this.outboundDate = outboundDate; }
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
