package com.xinai.inventory.service;

import com.xinai.inventory.entity.*;
import com.xinai.inventory.util.Result;
import java.util.List;
import java.util.Map;

public interface InventoryService {
    // 材料
    Result getMaterialList(Map<String, Object> params);
    Material getMaterialById(String materialId);
    Result addMaterial(Material material);
    Result updateMaterial(Material material);
    Result updateMaterialStatus(String materialId, String status);
    List<Material> getAllActiveMaterials();

    // 库存台账
    Result getInventoryList(Map<String, Object> params);
    Inventory getInventoryByMaterialId(String materialId);

    // 盘点
    Result getCheckList(Map<String, Object> params);
    InventoryCheck getCheckById(String checkId);
    Result addCheck(InventoryCheck check, String userId);
    Result updateCheck(InventoryCheck check);
    Result approveCheck(String checkId, String approver);

    // 预警
    Result getWarningList(Map<String, Object> params);
    InventoryWarning getWarningById(Integer warningId);
    Result handleWarning(Integer warningId, String handler);
    List<InventoryWarning> getUnhandledWarnings();
    List<InventoryWarning> getRecentWarnings(Integer limit);

    // 报表
    List<Map<String, Object>> getLedgerReport(Map<String, Object> params);
    List<Map<String, Object>> getInOutSummary(Map<String, Object> params);
    List<Map<String, Object>> getCheckSummary(Map<String, Object> params);

    // 主动触发预警检查
    void checkInventoryWarning(String materialId);
}
