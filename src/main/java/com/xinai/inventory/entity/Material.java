package com.xinai.inventory.entity;

import java.util.Date;

public class Material {
    private String materialId;
    private String materialName;
    private String categoryCode;
    private String specCode;
    private String materialSeq;
    private String specModel;
    private String unit;
    private Double refPrice;
    private Integer safetyLower;
    private Integer safetyUpper;
    private String status;
    private Date createTime;
    private Date updateTime;

    public String getMaterialId() { return materialId; }
    public void setMaterialId(String materialId) { this.materialId = materialId; }
    public String getMaterialName() { return materialName; }
    public void setMaterialName(String materialName) { this.materialName = materialName; }
    public String getCategoryCode() { return categoryCode; }
    public void setCategoryCode(String categoryCode) { this.categoryCode = categoryCode; }
    public String getSpecCode() { return specCode; }
    public void setSpecCode(String specCode) { this.specCode = specCode; }
    public String getMaterialSeq() { return materialSeq; }
    public void setMaterialSeq(String materialSeq) { this.materialSeq = materialSeq; }
    public String getSpecModel() { return specModel; }
    public void setSpecModel(String specModel) { this.specModel = specModel; }
    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }
    public Double getRefPrice() { return refPrice; }
    public void setRefPrice(Double refPrice) { this.refPrice = refPrice; }
    public Integer getSafetyLower() { return safetyLower; }
    public void setSafetyLower(Integer safetyLower) { this.safetyLower = safetyLower; }
    public Integer getSafetyUpper() { return safetyUpper; }
    public void setSafetyUpper(Integer safetyUpper) { this.safetyUpper = safetyUpper; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public Date getUpdateTime() { return updateTime; }
    public void setUpdateTime(Date updateTime) { this.updateTime = updateTime; }

    public String getCategoryName() {
        if ("01".equals(categoryCode)) return "钢筋";
        if ("02".equals(categoryCode)) return "水泥";
        if ("03".equals(categoryCode)) return "砂石";
        if ("04".equals(categoryCode)) return "砖";
        if ("05".equals(categoryCode)) return "木材";
        if ("06".equals(categoryCode)) return "防水材料";
        return "其他";
    }
}
