package com.xinai.inventory.entity;

import java.util.Date;

public class SalesOrder {
    private String orderId;
    private String orderYear;
    private String orderMonth;
    private String orderSeq;
    private Integer customerId;
    private String customerName;
    private String materialId;
    private String materialName;
    private String specModel;
    private Integer salesQty;
    private Double unitPrice;
    private Double totalAmount;
    private String deliveryRequirement;
    private Date orderDate;
    private String applicant;
    private String approvalStatus;
    private String approver;
    private Date approvalTime;
    private String remark;
    private Date createTime;
    private Date updateTime;

    public String getOrderId() { return orderId; }
    public void setOrderId(String orderId) { this.orderId = orderId; }
    public String getOrderYear() { return orderYear; }
    public void setOrderYear(String orderYear) { this.orderYear = orderYear; }
    public String getOrderMonth() { return orderMonth; }
    public void setOrderMonth(String orderMonth) { this.orderMonth = orderMonth; }
    public String getOrderSeq() { return orderSeq; }
    public void setOrderSeq(String orderSeq) { this.orderSeq = orderSeq; }
    public Integer getCustomerId() { return customerId; }
    public void setCustomerId(Integer customerId) { this.customerId = customerId; }
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    public String getMaterialId() { return materialId; }
    public void setMaterialId(String materialId) { this.materialId = materialId; }
    public String getMaterialName() { return materialName; }
    public void setMaterialName(String materialName) { this.materialName = materialName; }
    public String getSpecModel() { return specModel; }
    public void setSpecModel(String specModel) { this.specModel = specModel; }
    public Integer getSalesQty() { return salesQty; }
    public void setSalesQty(Integer salesQty) { this.salesQty = salesQty; }
    public Double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(Double unitPrice) { this.unitPrice = unitPrice; }
    public Double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(Double totalAmount) { this.totalAmount = totalAmount; }
    public String getDeliveryRequirement() { return deliveryRequirement; }
    public void setDeliveryRequirement(String deliveryRequirement) { this.deliveryRequirement = deliveryRequirement; }
    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }
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
