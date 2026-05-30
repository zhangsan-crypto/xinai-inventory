package com.xinai.inventory.entity;

import java.util.Date;

public class Inventory {
    private Integer inventoryId;
    private String materialId;
    private String materialName;
    private String specModel;
    private Integer currentQty;
    private String unit;
    private Double refPrice;
    private Date lastInboundDate;
    private Date lastOutboundDate;
    private Date updateTime;

    public Integer getInventoryId() { return inventoryId; }
    public void setInventoryId(Integer inventoryId) { this.inventoryId = inventoryId; }
    public String getMaterialId() { return materialId; }
    public void setMaterialId(String materialId) { this.materialId = materialId; }
    public String getMaterialName() { return materialName; }
    public void setMaterialName(String materialName) { this.materialName = materialName; }
    public String getSpecModel() { return specModel; }
    public void setSpecModel(String specModel) { this.specModel = specModel; }
    public Integer getCurrentQty() { return currentQty; }
    public void setCurrentQty(Integer currentQty) { this.currentQty = currentQty; }
    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }
    public Double getRefPrice() { return refPrice; }
    public void setRefPrice(Double refPrice) { this.refPrice = refPrice; }
    public Date getLastInboundDate() { return lastInboundDate; }
    public void setLastInboundDate(Date lastInboundDate) { this.lastInboundDate = lastInboundDate; }
    public Date getLastOutboundDate() { return lastOutboundDate; }
    public void setLastOutboundDate(Date lastOutboundDate) { this.lastOutboundDate = lastOutboundDate; }
    public Date getUpdateTime() { return updateTime; }
    public void setUpdateTime(Date updateTime) { this.updateTime = updateTime; }

    public Double getTotalValue() {
        return refPrice != null && currentQty != null ? refPrice * currentQty : 0;
    }
}
