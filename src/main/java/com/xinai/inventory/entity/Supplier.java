package com.xinai.inventory.entity;

import java.util.Date;

public class Supplier {
    private Integer supplierId;
    private String supplierName;
    private String contactPerson;
    private String contactPhone;
    private String mainMaterial;
    private String cooperationStatus;
    private String address;
    private String remark;
    private Date createTime;
    private Date updateTime;

    public Integer getSupplierId() { return supplierId; }
    public void setSupplierId(Integer supplierId) { this.supplierId = supplierId; }
    public String getSupplierName() { return supplierName; }
    public void setSupplierName(String supplierName) { this.supplierName = supplierName; }
    public String getContactPerson() { return contactPerson; }
    public void setContactPerson(String contactPerson) { this.contactPerson = contactPerson; }
    public String getContactPhone() { return contactPhone; }
    public void setContactPhone(String contactPhone) { this.contactPhone = contactPhone; }
    public String getMainMaterial() { return mainMaterial; }
    public void setMainMaterial(String mainMaterial) { this.mainMaterial = mainMaterial; }
    public String getCooperationStatus() { return cooperationStatus; }
    public void setCooperationStatus(String cooperationStatus) { this.cooperationStatus = cooperationStatus; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public Date getUpdateTime() { return updateTime; }
    public void setUpdateTime(Date updateTime) { this.updateTime = updateTime; }
}
