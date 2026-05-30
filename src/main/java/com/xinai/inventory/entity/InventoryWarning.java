package com.xinai.inventory.entity;

import java.util.Date;

public class InventoryWarning {
    private Integer warningId;
    private String materialId;
    private String materialName;
    private Integer currentQty;
    private Integer safetyLower;
    private Integer safetyUpper;
    private String warningType;
    private Date warningDate;
    private String status;
    private String handler;
    private Date handleTime;
    private String remark;
    private Date createTime;

    public Integer getWarningId() { return warningId; }
    public void setWarningId(Integer warningId) { this.warningId = warningId; }
    public String getMaterialId() { return materialId; }
    public void setMaterialId(String materialId) { this.materialId = materialId; }
    public String getMaterialName() { return materialName; }
    public void setMaterialName(String materialName) { this.materialName = materialName; }
    public Integer getCurrentQty() { return currentQty; }
    public void setCurrentQty(Integer currentQty) { this.currentQty = currentQty; }
    public Integer getSafetyLower() { return safetyLower; }
    public void setSafetyLower(Integer safetyLower) { this.safetyLower = safetyLower; }
    public Integer getSafetyUpper() { return safetyUpper; }
    public void setSafetyUpper(Integer safetyUpper) { this.safetyUpper = safetyUpper; }
    public String getWarningType() { return warningType; }
    public void setWarningType(String warningType) { this.warningType = warningType; }
    public Date getWarningDate() { return warningDate; }
    public void setWarningDate(Date warningDate) { this.warningDate = warningDate; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getHandler() { return handler; }
    public void setHandler(String handler) { this.handler = handler; }
    public Date getHandleTime() { return handleTime; }
    public void setHandleTime(Date handleTime) { this.handleTime = handleTime; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
}
