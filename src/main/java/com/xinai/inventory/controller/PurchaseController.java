package com.xinai.inventory.controller;

import com.xinai.inventory.entity.*;
import com.xinai.inventory.service.PurchaseService;
import com.xinai.inventory.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/purchase")
public class PurchaseController {

    @Autowired
    private PurchaseService purchaseService;

    // ===== 采购计划 =====
    @GetMapping("/plan/list")
    @ResponseBody
    public Result planList(@RequestParam Map<String, Object> params) {
        return purchaseService.getPlanList(params);
    }

    @GetMapping("/plan/{planId}")
    @ResponseBody
    public Result getPlan(@PathVariable String planId) {
        PurchasePlan plan = purchaseService.getPlanById(planId);
        return plan != null ? Result.success(plan) : Result.error("计划不存在");
    }

    @PostMapping("/plan/add")
    @ResponseBody
    public Result addPlan(@RequestBody PurchasePlan plan, HttpSession session) {
        SysUser user = (SysUser) session.getAttribute("user");
        return purchaseService.addPlan(plan, user.getUserId());
    }

    @PutMapping("/plan/update")
    @ResponseBody
    public Result updatePlan(@RequestBody PurchasePlan plan) {
        return purchaseService.updatePlan(plan);
    }

    @PutMapping("/plan/submit/{planId}")
    @ResponseBody
    public Result submitPlan(@PathVariable String planId) {
        return purchaseService.submitPlan(planId);
    }

    @PutMapping("/plan/approve/{planId}")
    @ResponseBody
    public Result approvePlan(@PathVariable String planId, HttpSession session) {
        SysUser user = (SysUser) session.getAttribute("user");
        return purchaseService.approvePlan(planId, user.getUserId());
    }

    @PutMapping("/plan/reject/{planId}")
    @ResponseBody
    public Result rejectPlan(@PathVariable String planId, HttpSession session) {
        SysUser user = (SysUser) session.getAttribute("user");
        return purchaseService.rejectPlan(planId, user.getUserId());
    }

    @DeleteMapping("/plan/delete/{planId}")
    @ResponseBody
    public Result deletePlan(@PathVariable String planId) {
        return purchaseService.deletePlan(planId);
    }

    // ===== 采购入库 =====
    @GetMapping("/inbound/list")
    @ResponseBody
    public Result inboundList(@RequestParam Map<String, Object> params) {
        return purchaseService.getInboundList(params);
    }

    @GetMapping("/inbound/{id}")
    @ResponseBody
    public Result getInbound(@PathVariable Integer id) {
        PurchaseInbound inbound = purchaseService.getInboundById(id);
        return inbound != null ? Result.success(inbound) : Result.error("入库单不存在");
    }

    @PostMapping("/inbound/add")
    @ResponseBody
    public Result addInbound(@RequestBody PurchaseInbound inbound, HttpSession session) {
        SysUser user = (SysUser) session.getAttribute("user");
        return purchaseService.addInbound(inbound, user.getUserId());
    }

    @PutMapping("/inbound/confirm/{id}")
    @ResponseBody
    public Result confirmInbound(@PathVariable Integer id, HttpSession session) {
        SysUser user = (SysUser) session.getAttribute("user");
        return purchaseService.confirmInbound(id, user.getUserId());
    }

    // ===== 供应商 =====
    @GetMapping("/supplier/list")
    @ResponseBody
    public Result supplierList(@RequestParam Map<String, Object> params) {
        return purchaseService.getSupplierList(params);
    }

    @GetMapping("/supplier/{id}")
    @ResponseBody
    public Result getSupplier(@PathVariable Integer id) {
        Supplier supplier = purchaseService.getSupplierById(id);
        return supplier != null ? Result.success(supplier) : Result.error("供应商不存在");
    }

    @PostMapping("/supplier/add")
    @ResponseBody
    public Result addSupplier(@RequestBody Supplier supplier) {
        return purchaseService.addSupplier(supplier);
    }

    @PutMapping("/supplier/update")
    @ResponseBody
    public Result updateSupplier(@RequestBody Supplier supplier) {
        return purchaseService.updateSupplier(supplier);
    }

    @GetMapping("/supplier/all")
    @ResponseBody
    public Result allSuppliers() {
        List<Supplier> list = purchaseService.getAllActiveSuppliers();
        return Result.success(list);
    }

    // ===== 采购退货 =====
    @GetMapping("/return/list")
    @ResponseBody
    public Result returnList(@RequestParam Map<String, Object> params) {
        return purchaseService.getReturnList(params);
    }

    @GetMapping("/return/{id}")
    @ResponseBody
    public Result getReturn(@PathVariable Integer id) {
        PurchaseReturn pr = purchaseService.getReturnById(id);
        return pr != null ? Result.success(pr) : Result.error("退货单不存在");
    }

    @PostMapping("/return/add")
    @ResponseBody
    public Result addReturn(@RequestBody PurchaseReturn purchaseReturn, HttpSession session) {
        SysUser user = (SysUser) session.getAttribute("user");
        return purchaseService.addReturn(purchaseReturn, user.getUserId());
    }

    @PutMapping("/return/confirm/{id}")
    @ResponseBody
    public Result confirmReturn(@PathVariable Integer id) {
        return purchaseService.confirmReturn(id);
    }
}
