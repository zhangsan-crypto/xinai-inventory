package com.xinai.inventory.controller;

import com.xinai.inventory.entity.InventoryWarning;
import com.xinai.inventory.entity.SysUser;
import com.xinai.inventory.service.InventoryService;
import com.xinai.inventory.service.PurchaseService;
import com.xinai.inventory.service.SalesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ViewController {

    @Autowired
    private InventoryService inventoryService;

    @Autowired
    private PurchaseService purchaseService;

    @Autowired
    private SalesService salesService;

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping({"/main", "/"})
    public String main(HttpSession session, Model model) {
        SysUser user = (SysUser) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        List<InventoryWarning> warnings = inventoryService.getRecentWarnings(5);
        model.addAttribute("warnings", warnings);
        model.addAttribute("user", user);

        // 根据角色加载Dashboard数据
        String role = user.getRole();
        Map<String, Object> emptyParams = new HashMap<>();

        if ("admin".equals(role)) {
            model.addAttribute("warningCount", inventoryService.getUnhandledWarnings().size());
        } else if ("purchase".equals(role)) {
            Map<String, Object> p = new HashMap<>();
            p.put("approvalStatus", "0");
            model.addAttribute("pendingPlans", purchaseService.getPlanList(p).getCount());
        } else if ("sale".equals(role)) {
            Map<String, Object> p = new HashMap<>();
            p.put("approvalStatus", "0");
            model.addAttribute("pendingOrders", salesService.getOrderList(p).getCount());
        } else if ("warehouse".equals(role)) {
            model.addAttribute("warningCount", inventoryService.getUnhandledWarnings().size());
        }

        return "main";
    }

    // 系统管理页面
    @GetMapping("/system/userList")
    public String userList() { return "system/userList"; }

    @GetMapping("/system/userAdd")
    public String userAdd() { return "system/userAdd"; }

    @GetMapping("/system/userEdit")
    public String userEdit(String userId, Model model) {
        model.addAttribute("userId", userId);
        return "system/userEdit";
    }

    @GetMapping("/system/changePassword")
    public String changePassword() { return "system/changePassword"; }

    @GetMapping("/system/permissionList")
    public String permissionList() { return "system/permissionList"; }

    // 采购管理页面
    @GetMapping("/purchase/planList")
    public String planList() { return "purchase/planList"; }

    @GetMapping("/purchase/planAdd")
    public String planAdd() { return "purchase/planAdd"; }

    @GetMapping("/purchase/planEdit")
    public String planEdit(String planId, Model model) {
        model.addAttribute("planId", planId);
        return "purchase/planEdit";
    }

    @GetMapping("/purchase/inboundList")
    public String inboundList() { return "purchase/inboundList"; }

    @GetMapping("/purchase/inboundAdd")
    public String inboundAdd() { return "purchase/inboundAdd"; }

    @GetMapping("/purchase/supplierList")
    public String supplierList() { return "purchase/supplierList"; }

    @GetMapping("/purchase/supplierAdd")
    public String supplierAdd() { return "purchase/supplierAdd"; }

    @GetMapping("/purchase/supplierEdit")
    public String supplierEdit(Integer supplierId, Model model) {
        model.addAttribute("supplierId", supplierId);
        return "purchase/supplierEdit";
    }

    @GetMapping("/purchase/returnList")
    public String returnList() { return "purchase/returnList"; }

    @GetMapping("/purchase/returnAdd")
    public String returnAdd() { return "purchase/returnAdd"; }

    // 销售管理页面
    @GetMapping("/sales/orderList")
    public String orderList() { return "sales/orderList"; }

    @GetMapping("/sales/orderAdd")
    public String orderAdd() { return "sales/orderAdd"; }

    @GetMapping("/sales/orderEdit")
    public String orderEdit(String orderId, Model model) {
        model.addAttribute("orderId", orderId);
        return "sales/orderEdit";
    }

    @GetMapping("/sales/outboundList")
    public String outboundList() { return "sales/outboundList"; }

    @GetMapping("/sales/outboundAdd")
    public String outboundAdd() { return "sales/outboundAdd"; }

    @GetMapping("/sales/customerList")
    public String customerList() { return "sales/customerList"; }

    @GetMapping("/sales/customerAdd")
    public String customerAdd() { return "sales/customerAdd"; }

    @GetMapping("/sales/customerEdit")
    public String customerEdit(Integer customerId, Model model) {
        model.addAttribute("customerId", customerId);
        return "sales/customerEdit";
    }

    @GetMapping("/sales/returnList")
    public String salesReturnList() { return "sales/returnList"; }

    @GetMapping("/sales/returnAdd")
    public String salesReturnAdd() { return "sales/returnAdd"; }

    // 库存管理页面
    @GetMapping("/inventory/materialList")
    public String materialList() { return "inventory/materialList"; }

    @GetMapping("/inventory/materialAdd")
    public String materialAdd() { return "inventory/materialAdd"; }

    @GetMapping("/inventory/materialEdit")
    public String materialEdit(String materialId, Model model) {
        model.addAttribute("materialId", materialId);
        return "inventory/materialEdit";
    }

    @GetMapping("/inventory/checkList")
    public String checkList() { return "inventory/checkList"; }

    @GetMapping("/inventory/checkAdd")
    public String checkAdd() { return "inventory/checkAdd"; }

    @GetMapping("/inventory/reportLedger")
    public String reportLedger() { return "inventory/reportLedger"; }

    @GetMapping("/inventory/reportInOut")
    public String reportInOut() { return "inventory/reportInOut"; }

    @GetMapping("/inventory/reportCheck")
    public String reportCheck() { return "inventory/reportCheck"; }

    @GetMapping("/inventory/warningList")
    public String warningList() { return "inventory/warningList"; }
}
