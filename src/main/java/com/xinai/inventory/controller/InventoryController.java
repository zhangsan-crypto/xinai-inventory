package com.xinai.inventory.controller;

import com.xinai.inventory.entity.*;
import com.xinai.inventory.service.InventoryService;
import com.xinai.inventory.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/inventory")
public class InventoryController {

    @Autowired
    private InventoryService inventoryService;

    // ===== 物料 =====
    @GetMapping("/material/list")
    @ResponseBody
    public Result materialList(@RequestParam Map<String, Object> params) {
        return inventoryService.getMaterialList(params);
    }

    @GetMapping("/material/{materialId}")
    @ResponseBody
    public Result getMaterial(@PathVariable String materialId) {
        Material material = inventoryService.getMaterialById(materialId);
        return material != null ? Result.success(material) : Result.error("材料不存在");
    }

    @PostMapping("/material/add")
    @ResponseBody
    public Result addMaterial(@RequestBody Material material) {
        return inventoryService.addMaterial(material);
    }

    @PutMapping("/material/update")
    @ResponseBody
    public Result updateMaterial(@RequestBody Material material) {
        return inventoryService.updateMaterial(material);
    }

    @PutMapping("/material/status/{id}")
    @ResponseBody
    public Result updateMaterialStatus(@PathVariable String id, @RequestParam String status) {
        return inventoryService.updateMaterialStatus(id, status);
    }

    @GetMapping("/material/all")
    @ResponseBody
    public Result allMaterials() {
        List<Material> list = inventoryService.getAllActiveMaterials();
        return Result.success(list);
    }

    // ===== 库存台账 =====
    @GetMapping("/inventory/list")
    @ResponseBody
    public Result inventoryList(@RequestParam Map<String, Object> params) {
        return inventoryService.getInventoryList(params);
    }

    @GetMapping("/inventory/{materialId}")
    @ResponseBody
    public Result getInventory(@PathVariable String materialId) {
        Inventory inv = inventoryService.getInventoryByMaterialId(materialId);
        return inv != null ? Result.success(inv) : Result.error("库存记录不存在");
    }

    // ===== 盘点 =====
    @GetMapping("/check/list")
    @ResponseBody
    public Result checkList(@RequestParam Map<String, Object> params) {
        return inventoryService.getCheckList(params);
    }

    @GetMapping("/check/{checkId}")
    @ResponseBody
    public Result getCheck(@PathVariable String checkId) {
        InventoryCheck check = inventoryService.getCheckById(checkId);
        return check != null ? Result.success(check) : Result.error("盘点单不存在");
    }

    @PostMapping("/check/add")
    @ResponseBody
    public Result addCheck(@RequestBody InventoryCheck check, HttpSession session) {
        SysUser user = (SysUser) session.getAttribute("user");
        return inventoryService.addCheck(check, user.getUserId());
    }

    @PutMapping("/check/update")
    @ResponseBody
    public Result updateCheck(@RequestBody InventoryCheck check) {
        return inventoryService.updateCheck(check);
    }

    @PutMapping("/check/approve/{id}")
    @ResponseBody
    public Result approveCheck(@PathVariable String id, HttpSession session) {
        SysUser user = (SysUser) session.getAttribute("user");
        return inventoryService.approveCheck(id, user.getUserId());
    }

    // ===== 预警 =====
    @GetMapping("/warning/list")
    @ResponseBody
    public Result warningList(@RequestParam Map<String, Object> params) {
        return inventoryService.getWarningList(params);
    }

    @GetMapping("/warning/{id}")
    @ResponseBody
    public Result getWarning(@PathVariable Integer id) {
        InventoryWarning warning = inventoryService.getWarningById(id);
        return warning != null ? Result.success(warning) : Result.error("预警不存在");
    }

    @PutMapping("/warning/handle/{id}")
    @ResponseBody
    public Result handleWarning(@PathVariable Integer id, HttpSession session) {
        SysUser user = (SysUser) session.getAttribute("user");
        return inventoryService.handleWarning(id, user.getUserId());
    }

    @GetMapping("/warning/realtime")
    @ResponseBody
    public Result realtimeWarnings() {
        List<InventoryWarning> list = inventoryService.getRecentWarnings(10);
        return Result.success(list);
    }

    // ===== 报表 =====
    @GetMapping("/report/ledger")
    @ResponseBody
    public Result ledgerReport(@RequestParam Map<String, Object> params) {
        List<Map<String, Object>> data = inventoryService.getLedgerReport(params);
        return Result.success(data);
    }

    @GetMapping("/report/inoutSummary")
    @ResponseBody
    public Result inoutSummary(@RequestParam Map<String, Object> params) {
        List<Map<String, Object>> data = inventoryService.getInOutSummary(params);
        return Result.success(data);
    }

    @GetMapping("/report/checkSummary")
    @ResponseBody
    public Result checkSummary(@RequestParam Map<String, Object> params) {
        List<Map<String, Object>> data = inventoryService.getCheckSummary(params);
        return Result.success(data);
    }
}
