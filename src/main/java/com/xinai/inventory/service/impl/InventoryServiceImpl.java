package com.xinai.inventory.service.impl;

import com.xinai.inventory.dao.InventoryDao;
import com.xinai.inventory.entity.*;
import com.xinai.inventory.service.InventoryService;
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
public class InventoryServiceImpl implements InventoryService {

    @Autowired
    private InventoryDao inventoryDao;

    @Override
    public Result getMaterialList(Map<String, Object> params) {
        int page = params.get("page") != null ? Integer.parseInt(params.get("page").toString()) : 1;
        int limit = params.get("limit") != null ? Integer.parseInt(params.get("limit").toString()) : 10;
        params.put("offset", (page - 1) * limit);
        params.put("limit", limit);
        List<Material> list = inventoryDao.getMaterialList(params);
        int total = inventoryDao.getMaterialCount(params);
        return Result.page(list, total);
    }

    @Override
    public Material getMaterialById(String materialId) {
        return inventoryDao.getMaterialById(materialId);
    }

    @Override
    @Transactional
    public Result addMaterial(Material material) {
        Integer maxSeq = inventoryDao.getMaxMaterialSeq(material.getCategoryCode(), material.getSpecCode());
        int seq = (maxSeq != null ? maxSeq : 0) + 1;
        String materialId = CodeGenerator.generateMaterialCode(material.getCategoryCode(), material.getSpecCode(), seq);
        material.setMaterialId(materialId);
        material.setMaterialSeq(String.format("%04d", seq));
        material.setStatus("0");
        inventoryDao.insertMaterial(material);

        // 同步创建库存台账记录
        Inventory inv = new Inventory();
        inv.setMaterialId(materialId);
        inv.setMaterialName(material.getMaterialName());
        inv.setSpecModel(material.getSpecModel());
        inv.setCurrentQty(0);
        inv.setUnit(material.getUnit());
        inv.setRefPrice(material.getRefPrice());
        inventoryDao.insertInventory(inv);

        return Result.success("材料新增成功，编号: " + materialId, material);
    }

    @Override
    @Transactional
    public Result updateMaterial(Material material) {
        inventoryDao.updateMaterial(material);
        return Result.success("修改成功");
    }

    @Override
    @Transactional
    public Result updateMaterialStatus(String materialId, String status) {
        inventoryDao.updateMaterialStatus(materialId, status);
        return Result.success("状态更新成功");
    }

    @Override
    public List<Material> getAllActiveMaterials() {
        return inventoryDao.getAllActiveMaterials();
    }

    @Override
    public Result getInventoryList(Map<String, Object> params) {
        int page = params.get("page") != null ? Integer.parseInt(params.get("page").toString()) : 1;
        int limit = params.get("limit") != null ? Integer.parseInt(params.get("limit").toString()) : 10;
        params.put("offset", (page - 1) * limit);
        params.put("limit", limit);
        List<Inventory> list = inventoryDao.getInventoryList(params);
        int total = inventoryDao.getInventoryCount(params);
        return Result.page(list, total);
    }

    @Override
    public Inventory getInventoryByMaterialId(String materialId) {
        return inventoryDao.getInventoryByMaterialId(materialId);
    }

    @Override
    public Result getCheckList(Map<String, Object> params) {
        int page = params.get("page") != null ? Integer.parseInt(params.get("page").toString()) : 1;
        int limit = params.get("limit") != null ? Integer.parseInt(params.get("limit").toString()) : 10;
        params.put("offset", (page - 1) * limit);
        params.put("limit", limit);
        List<InventoryCheck> list = inventoryDao.getCheckList(params);
        int total = inventoryDao.getCheckCount(params);
        return Result.page(list, total);
    }

    @Override
    public InventoryCheck getCheckById(String checkId) {
        return inventoryDao.getCheckById(checkId);
    }

    @Override
    @Transactional
    public Result addCheck(InventoryCheck check, String userId) {
        String now = new SimpleDateFormat("yyyyMMdd").format(new Date());
        String year = now.substring(0, 4);
        String month = now.substring(4, 6);

        String maxSeq = inventoryDao.getMaxCheckSeq(year, month);
        int seq = (maxSeq != null ? Integer.parseInt(maxSeq) : 0) + 1;

        check.setCheckId(CodeGenerator.generateCheckCode(year, month, seq));
        check.setCheckYear(year);
        check.setCheckMonth(month);
        check.setCheckSeq(String.format("%04d", seq));
        check.setChecker(userId);
        check.setApprovalStatus("0");

        // 自动计算差异
        check.setDiffQty(check.getActualQty() - check.getBookQty());

        inventoryDao.insertCheck(check);
        return Result.success("盘点单新增成功", check);
    }

    @Override
    @Transactional
    public Result updateCheck(InventoryCheck check) {
        check.setDiffQty(check.getActualQty() - check.getBookQty());
        inventoryDao.updateCheck(check);
        return Result.success("修改成功");
    }

    @Override
    @Transactional
    public Result approveCheck(String checkId, String approver) {
        InventoryCheck check = inventoryDao.getCheckById(checkId);
        if (check == null) return Result.error("盘点单不存在");
        inventoryDao.approveCheck(checkId, approver);
        inventoryDao.updateInventoryQtyDirect(check.getMaterialId(), check.getActualQty());
        return Result.success("盘点审批通过，库存已更新");
    }

    @Override
    public Result getWarningList(Map<String, Object> params) {
        int page = params.get("page") != null ? Integer.parseInt(params.get("page").toString()) : 1;
        int limit = params.get("limit") != null ? Integer.parseInt(params.get("limit").toString()) : 10;
        params.put("offset", (page - 1) * limit);
        params.put("limit", limit);
        List<InventoryWarning> list = inventoryDao.getWarningList(params);
        int total = inventoryDao.getWarningCount(params);
        return Result.page(list, total);
    }

    @Override
    public InventoryWarning getWarningById(Integer warningId) {
        return inventoryDao.getWarningById(warningId);
    }

    @Override
    @Transactional
    public Result handleWarning(Integer warningId, String handler) {
        inventoryDao.handleWarning(warningId, handler);
        return Result.success("预警已处理");
    }

    @Override
    public List<InventoryWarning> getUnhandledWarnings() {
        return inventoryDao.getUnhandledWarnings();
    }

    @Override
    public List<InventoryWarning> getRecentWarnings(Integer limit) {
        return inventoryDao.getRecentWarnings(limit);
    }

    @Override
    public List<Map<String, Object>> getLedgerReport(Map<String, Object> params) {
        return inventoryDao.getLedgerReport(params);
    }

    @Override
    public List<Map<String, Object>> getInOutSummary(Map<String, Object> params) {
        return inventoryDao.getInOutSummary(params);
    }

    @Override
    public List<Map<String, Object>> getCheckSummary(Map<String, Object> params) {
        return inventoryDao.getCheckSummary(params);
    }

    @Override
    @Transactional
    public void checkInventoryWarning(String materialId) {
        try {
            Inventory inv = inventoryDao.getInventoryByMaterialId(materialId);
            if (inv == null) return;

            Material mat = inventoryDao.getMaterialById(materialId);
            if (mat == null) return;

            if (mat.getSafetyLower() != null && mat.getSafetyLower() > 0 && inv.getCurrentQty() < mat.getSafetyLower()) {
                InventoryWarning warning = new InventoryWarning();
                warning.setMaterialId(materialId);
                warning.setMaterialName(inv.getMaterialName());
                warning.setCurrentQty(inv.getCurrentQty());
                warning.setSafetyLower(mat.getSafetyLower());
                warning.setSafetyUpper(mat.getSafetyUpper());
                warning.setWarningType("0");
                inventoryDao.insertWarning(warning);
            } else if (mat.getSafetyUpper() != null && mat.getSafetyUpper() > 0 && inv.getCurrentQty() > mat.getSafetyUpper()) {
                InventoryWarning warning = new InventoryWarning();
                warning.setMaterialId(materialId);
                warning.setMaterialName(inv.getMaterialName());
                warning.setCurrentQty(inv.getCurrentQty());
                warning.setSafetyLower(mat.getSafetyLower());
                warning.setSafetyUpper(mat.getSafetyUpper());
                warning.setWarningType("1");
                inventoryDao.insertWarning(warning);
            }
        } catch (Exception e) {
            // 预警检查失败不应影响主流程
        }
    }
}
