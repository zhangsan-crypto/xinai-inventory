package com.xinai.inventory.dao;

import com.xinai.inventory.entity.*;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

public interface PurchaseDao {
    // 采购计划
    List<PurchasePlan> getPlanList(Map<String, Object> params);
    int getPlanCount(Map<String, Object> params);
    PurchasePlan getPlanById(@Param("planId") String planId);
    int insertPlan(PurchasePlan plan);
    int updatePlan(PurchasePlan plan);
    int deletePlan(@Param("planId") String planId);
    int updatePlanApproval(@Param("planId") String planId, @Param("status") String status, @Param("approver") String approver);
    String getMaxPlanSeq(@Param("year") String year, @Param("month") String month);
    List<PurchasePlan> getPlansByStatus(@Param("status") String status);

    // 采购入库
    List<PurchaseInbound> getInboundList(Map<String, Object> params);
    int getInboundCount(Map<String, Object> params);
    PurchaseInbound getInboundById(@Param("inboundId") Integer inboundId);
    int insertInbound(PurchaseInbound inbound);
    int updateInbound(PurchaseInbound inbound);
    int confirmInbound(@Param("inboundId") Integer inboundId, @Param("warehouseKeeper") String warehouseKeeper);
    List<PurchaseInbound> getPendingInbounds();

    // 供应商
    List<Supplier> getSupplierList(Map<String, Object> params);
    int getSupplierCount(Map<String, Object> params);
    Supplier getSupplierById(@Param("supplierId") Integer supplierId);
    int insertSupplier(Supplier supplier);
    int updateSupplier(Supplier supplier);
    List<Supplier> getAllActiveSuppliers();

    // 采购退货
    List<PurchaseReturn> getReturnList(Map<String, Object> params);
    int getReturnCount(Map<String, Object> params);
    PurchaseReturn getReturnById(@Param("returnId") Integer returnId);
    int insertReturn(PurchaseReturn purchaseReturn);
    int confirmReturn(@Param("returnId") Integer returnId);
}
