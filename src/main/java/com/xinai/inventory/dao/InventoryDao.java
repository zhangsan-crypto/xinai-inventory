package com.xinai.inventory.dao;

import com.xinai.inventory.entity.*;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

public interface InventoryDao {
    // 材料
    List<Material> getMaterialList(Map<String, Object> params);
    int getMaterialCount(Map<String, Object> params);
    Material getMaterialById(@Param("materialId") String materialId);
    int insertMaterial(Material material);
    int updateMaterial(Material material);
    int updateMaterialStatus(@Param("materialId") String materialId, @Param("status") String status);
    Integer getMaxMaterialSeq(@Param("categoryCode") String categoryCode, @Param("specCode") String specCode);
    List<Material> getAllActiveMaterials();

    // 库存台账
    List<Inventory> getInventoryList(Map<String, Object> params);
    int getInventoryCount(Map<String, Object> params);
    Inventory getInventoryByMaterialId(@Param("materialId") String materialId);
    int insertInventory(Inventory inventory);
    int updateInventoryQty(@Param("materialId") String materialId, @Param("qty") Integer qty);
    int updateInventoryQtyAdd(@Param("materialId") String materialId, @Param("qty") Integer qty);
    int updateInventoryQtySubtract(@Param("materialId") String materialId, @Param("qty") Integer qty);
    int updateInventoryQtyDirect(@Param("materialId") String materialId, @Param("qty") Integer qty);
    List<Inventory> getAllInventory();

    // 盘点
    List<InventoryCheck> getCheckList(Map<String, Object> params);
    int getCheckCount(Map<String, Object> params);
    InventoryCheck getCheckById(@Param("checkId") String checkId);
    int insertCheck(InventoryCheck check);
    int updateCheck(InventoryCheck check);
    int approveCheck(@Param("checkId") String checkId, @Param("approver") String approver);
    String getMaxCheckSeq(@Param("year") String year, @Param("month") String month);

    // 预警
    List<InventoryWarning> getWarningList(Map<String, Object> params);
    int getWarningCount(Map<String, Object> params);
    InventoryWarning getWarningById(@Param("warningId") Integer warningId);
    int insertWarning(InventoryWarning warning);
    int handleWarning(@Param("warningId") Integer warningId, @Param("handler") String handler);
    List<InventoryWarning> getUnhandledWarnings();
    List<InventoryWarning> getRecentWarnings(@Param("limit") Integer limit);

    // 报表
    List<Map<String, Object>> getLedgerReport(Map<String, Object> params);
    List<Map<String, Object>> getInOutSummary(Map<String, Object> params);
    List<Map<String, Object>> getCheckSummary(Map<String, Object> params);
}
