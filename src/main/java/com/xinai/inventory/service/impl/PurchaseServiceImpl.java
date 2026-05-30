package com.xinai.inventory.service.impl;

import com.xinai.inventory.dao.InventoryDao;
import com.xinai.inventory.dao.PurchaseDao;
import com.xinai.inventory.entity.*;
import com.xinai.inventory.service.InventoryService;
import com.xinai.inventory.service.PurchaseService;
import com.xinai.inventory.util.CodeGenerator;
import com.xinai.inventory.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class PurchaseServiceImpl implements PurchaseService {

    @Autowired
    private PurchaseDao purchaseDao;

    @Autowired
    private InventoryDao inventoryDao;

    @Autowired
    private InventoryService inventoryService;

    private SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

    @Override
    public Result getPlanList(Map<String, Object> params) {
        int page = params.get("page") != null ? Integer.parseInt(params.get("page").toString()) : 1;
        int limit = params.get("limit") != null ? Integer.parseInt(params.get("limit").toString()) : 10;
        params.put("offset", (page - 1) * limit);
        params.put("limit", limit);
        List<PurchasePlan> list = purchaseDao.getPlanList(params);
        int total = purchaseDao.getPlanCount(params);
        return Result.page(list, total);
    }

    @Override
    public PurchasePlan getPlanById(String planId) {
        return purchaseDao.getPlanById(planId);
    }

    @Override
    @Transactional
    public Result addPlan(PurchasePlan plan, String userId) {
        try {
            if (plan.getMaterialId() == null || plan.getMaterialId().trim().isEmpty()) {
                return Result.error("请选择材料");
            }
            if (plan.getDemandQty() == null || plan.getDemandQty() <= 0) {
                return Result.error("请输入有效的需求数量");
            }

            String now = new SimpleDateFormat("yyyyMMdd").format(new Date());
            String year = now.substring(0, 4);
            String month = now.substring(4, 6);

            String maxSeq = purchaseDao.getMaxPlanSeq(year, month);
            int seq = (maxSeq != null ? Integer.parseInt(maxSeq) : 0) + 1;

            plan.setPlanId(CodeGenerator.generatePlanCode(year, month, seq));
            plan.setPlanYear(year);
            plan.setPlanMonth(month);
            plan.setPlanSeq(String.format("%04d", seq));
            plan.setApplicant(userId);
            plan.setApprovalStatus("0");

            purchaseDao.insertPlan(plan);
            return Result.success("采购计划新增成功", plan);
        } catch (Exception e) {
            throw new RuntimeException("新增采购计划失败: " + e.getMessage(), e);
        }
    }

    @Override
    @Transactional
    public Result updatePlan(PurchasePlan plan) {
        purchaseDao.updatePlan(plan);
        return Result.success("修改成功");
    }

    @Override
    @Transactional
    public Result deletePlan(String planId) {
        PurchasePlan plan = purchaseDao.getPlanById(planId);
        if (plan == null) return Result.error("计划不存在");
        if (!"0".equals(plan.getApprovalStatus())) return Result.error("仅待审批状态可删除");
        purchaseDao.deletePlan(planId);
        return Result.success("删除成功");
    }

    @Override
    @Transactional
    public Result submitPlan(String planId) {
        PurchasePlan plan = purchaseDao.getPlanById(planId);
        if (plan == null) return Result.error("计划不存在");
        purchaseDao.updatePlanApproval(planId, "0", null);
        return Result.success("已提交审批");
    }

    @Override
    @Transactional
    public Result approvePlan(String planId, String approver) {
        purchaseDao.updatePlanApproval(planId, "1", approver);
        return Result.success("审批通过");
    }

    @Override
    @Transactional
    public Result rejectPlan(String planId, String approver) {
        purchaseDao.updatePlanApproval(planId, "2", approver);
        return Result.success("已驳回");
    }

    @Override
    public Result getInboundList(Map<String, Object> params) {
        int page = params.get("page") != null ? Integer.parseInt(params.get("page").toString()) : 1;
        int limit = params.get("limit") != null ? Integer.parseInt(params.get("limit").toString()) : 10;
        params.put("offset", (page - 1) * limit);
        params.put("limit", limit);
        List<PurchaseInbound> list = purchaseDao.getInboundList(params);
        int total = purchaseDao.getInboundCount(params);
        return Result.page(list, total);
    }

    @Override
    public PurchaseInbound getInboundById(Integer inboundId) {
        return purchaseDao.getInboundById(inboundId);
    }

    @Override
    @Transactional
    public Result addInbound(PurchaseInbound inbound, String userId) {
        inbound.setOperator(userId);
        inbound.setStatus("0");
        purchaseDao.insertInbound(inbound);
        return Result.success("入库单新增成功", inbound);
    }

    @Override
    @Transactional
    public Result confirmInbound(Integer inboundId, String keeper) {
        PurchaseInbound inbound = purchaseDao.getInboundById(inboundId);
        if (inbound == null) return Result.error("入库单不存在");
        if ("1".equals(inbound.getStatus())) return Result.error("该入库单已确认");

        purchaseDao.confirmInbound(inboundId, keeper);
        inventoryDao.updateInventoryQtyAdd(inbound.getMaterialId(), inbound.getInboundQty());
        inventoryService.checkInventoryWarning(inbound.getMaterialId());
        return Result.success("入库确认成功");
    }

    @Override
    public Result getSupplierList(Map<String, Object> params) {
        int page = params.get("page") != null ? Integer.parseInt(params.get("page").toString()) : 1;
        int limit = params.get("limit") != null ? Integer.parseInt(params.get("limit").toString()) : 10;
        params.put("offset", (page - 1) * limit);
        params.put("limit", limit);
        List<Supplier> list = purchaseDao.getSupplierList(params);
        int total = purchaseDao.getSupplierCount(params);
        return Result.page(list, total);
    }

    @Override
    public Supplier getSupplierById(Integer supplierId) {
        return purchaseDao.getSupplierById(supplierId);
    }

    @Override
    @Transactional
    public Result addSupplier(Supplier supplier) {
        purchaseDao.insertSupplier(supplier);
        return Result.success("供应商新增成功", supplier);
    }

    @Override
    @Transactional
    public Result updateSupplier(Supplier supplier) {
        purchaseDao.updateSupplier(supplier);
        return Result.success("修改成功");
    }

    @Override
    public List<Supplier> getAllActiveSuppliers() {
        return purchaseDao.getAllActiveSuppliers();
    }

    @Override
    public Result getReturnList(Map<String, Object> params) {
        int page = params.get("page") != null ? Integer.parseInt(params.get("page").toString()) : 1;
        int limit = params.get("limit") != null ? Integer.parseInt(params.get("limit").toString()) : 10;
        params.put("offset", (page - 1) * limit);
        params.put("limit", limit);
        List<PurchaseReturn> list = purchaseDao.getReturnList(params);
        int total = purchaseDao.getReturnCount(params);
        return Result.page(list, total);
    }

    @Override
    public PurchaseReturn getReturnById(Integer returnId) {
        return purchaseDao.getReturnById(returnId);
    }

    @Override
    @Transactional
    public Result addReturn(PurchaseReturn purchaseReturn, String userId) {
        purchaseReturn.setOperator(userId);
        purchaseReturn.setStatus("0");
        purchaseDao.insertReturn(purchaseReturn);
        return Result.success("退货单新增成功", purchaseReturn);
    }

    @Override
    @Transactional
    public Result confirmReturn(Integer returnId) {
        PurchaseReturn pr = purchaseDao.getReturnById(returnId);
        if (pr == null) return Result.error("退货单不存在");
        if ("1".equals(pr.getStatus())) return Result.error("该退货单已处理");

        purchaseDao.confirmReturn(returnId);
        inventoryDao.updateInventoryQtySubtract(pr.getMaterialId(), pr.getReturnQty());
        inventoryService.checkInventoryWarning(pr.getMaterialId());
        return Result.success("退货确认成功");
    }
}
