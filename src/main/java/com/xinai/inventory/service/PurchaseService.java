package com.xinai.inventory.service;

import com.xinai.inventory.entity.*;
import com.xinai.inventory.util.Result;
import java.util.List;
import java.util.Map;

public interface PurchaseService {
    // 采购计划
    Result getPlanList(Map<String, Object> params);
    PurchasePlan getPlanById(String planId);
    Result addPlan(PurchasePlan plan, String userId);
    Result updatePlan(PurchasePlan plan);
    Result deletePlan(String planId);
    Result submitPlan(String planId);
    Result approvePlan(String planId, String approver);
    Result rejectPlan(String planId, String approver);

    // 采购入库
    Result getInboundList(Map<String, Object> params);
    PurchaseInbound getInboundById(Integer inboundId);
    Result addInbound(PurchaseInbound inbound, String userId);
    Result confirmInbound(Integer inboundId, String keeper);

    // 供应商
    Result getSupplierList(Map<String, Object> params);
    Supplier getSupplierById(Integer supplierId);
    Result addSupplier(Supplier supplier);
    Result updateSupplier(Supplier supplier);
    List<Supplier> getAllActiveSuppliers();

    // 采购退货
    Result getReturnList(Map<String, Object> params);
    PurchaseReturn getReturnById(Integer returnId);
    Result addReturn(PurchaseReturn purchaseReturn, String userId);
    Result confirmReturn(Integer returnId);
}
