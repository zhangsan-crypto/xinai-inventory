package com.xinai.inventory.controller;

import com.xinai.inventory.entity.*;
import com.xinai.inventory.service.SalesService;
import com.xinai.inventory.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/sales")
public class SalesController {

    @Autowired
    private SalesService salesService;

    // ===== 销售订单 =====
    @GetMapping("/order/list")
    @ResponseBody
    public Result orderList(@RequestParam Map<String, Object> params) {
        return salesService.getOrderList(params);
    }

    @GetMapping("/order/{orderId}")
    @ResponseBody
    public Result getOrder(@PathVariable String orderId) {
        SalesOrder order = salesService.getOrderById(orderId);
        return order != null ? Result.success(order) : Result.error("订单不存在");
    }

    @PostMapping("/order/add")
    @ResponseBody
    public Result addOrder(@RequestBody SalesOrder order, HttpSession session) {
        SysUser user = (SysUser) session.getAttribute("user");
        return salesService.addOrder(order, user.getUserId());
    }

    @PutMapping("/order/update")
    @ResponseBody
    public Result updateOrder(@RequestBody SalesOrder order) {
        return salesService.updateOrder(order);
    }

    @PutMapping("/order/submit/{orderId}")
    @ResponseBody
    public Result submitOrder(@PathVariable String orderId) {
        return salesService.submitOrder(orderId);
    }

    @PutMapping("/order/approve/{orderId}")
    @ResponseBody
    public Result approveOrder(@PathVariable String orderId, HttpSession session) {
        SysUser user = (SysUser) session.getAttribute("user");
        return salesService.approveOrder(orderId, user.getUserId());
    }

    @PutMapping("/order/reject/{orderId}")
    @ResponseBody
    public Result rejectOrder(@PathVariable String orderId, HttpSession session) {
        SysUser user = (SysUser) session.getAttribute("user");
        return salesService.rejectOrder(orderId, user.getUserId());
    }

    @DeleteMapping("/order/delete/{orderId}")
    @ResponseBody
    public Result deleteOrder(@PathVariable String orderId) {
        return salesService.deleteOrder(orderId);
    }

    // ===== 销售出库 =====
    @GetMapping("/outbound/list")
    @ResponseBody
    public Result outboundList(@RequestParam Map<String, Object> params) {
        return salesService.getOutboundList(params);
    }

    @GetMapping("/outbound/{id}")
    @ResponseBody
    public Result getOutbound(@PathVariable Integer id) {
        SalesOutbound ob = salesService.getOutboundById(id);
        return ob != null ? Result.success(ob) : Result.error("出库单不存在");
    }

    @PostMapping("/outbound/add")
    @ResponseBody
    public Result addOutbound(@RequestBody SalesOutbound outbound, HttpSession session) {
        SysUser user = (SysUser) session.getAttribute("user");
        return salesService.addOutbound(outbound, user.getUserId());
    }

    @PutMapping("/outbound/confirm/{id}")
    @ResponseBody
    public Result confirmOutbound(@PathVariable Integer id, HttpSession session) {
        SysUser user = (SysUser) session.getAttribute("user");
        return salesService.confirmOutbound(id, user.getUserId());
    }

    // ===== 客户 =====
    @GetMapping("/customer/list")
    @ResponseBody
    public Result customerList(@RequestParam Map<String, Object> params) {
        return salesService.getCustomerList(params);
    }

    @GetMapping("/customer/{id}")
    @ResponseBody
    public Result getCustomer(@PathVariable Integer id) {
        Customer customer = salesService.getCustomerById(id);
        return customer != null ? Result.success(customer) : Result.error("客户不存在");
    }

    @PostMapping("/customer/add")
    @ResponseBody
    public Result addCustomer(@RequestBody Customer customer) {
        return salesService.addCustomer(customer);
    }

    @PutMapping("/customer/update")
    @ResponseBody
    public Result updateCustomer(@RequestBody Customer customer) {
        return salesService.updateCustomer(customer);
    }

    @GetMapping("/customer/all")
    @ResponseBody
    public Result allCustomers() {
        List<Customer> list = salesService.getAllActiveCustomers();
        return Result.success(list);
    }

    // ===== 销售退货 =====
    @GetMapping("/return/list")
    @ResponseBody
    public Result returnList(@RequestParam Map<String, Object> params) {
        return salesService.getSalesReturnList(params);
    }

    @GetMapping("/return/{id}")
    @ResponseBody
    public Result getReturn(@PathVariable Integer id) {
        SalesReturn sr = salesService.getSalesReturnById(id);
        return sr != null ? Result.success(sr) : Result.error("退货单不存在");
    }

    @PostMapping("/return/add")
    @ResponseBody
    public Result addReturn(@RequestBody SalesReturn salesReturn, HttpSession session) {
        SysUser user = (SysUser) session.getAttribute("user");
        return salesService.addSalesReturn(salesReturn, user.getUserId());
    }

    @PutMapping("/return/approve/{id}")
    @ResponseBody
    public Result approveReturn(@PathVariable Integer id) {
        return salesService.approveSalesReturn(id);
    }

    @PutMapping("/return/confirm/{id}")
    @ResponseBody
    public Result confirmReturn(@PathVariable Integer id) {
        return salesService.confirmSalesReturn(id);
    }
}
