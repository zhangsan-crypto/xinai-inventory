package com.xinai.inventory.service.impl;

import com.xinai.inventory.dao.InventoryDao;
import com.xinai.inventory.dao.SalesDao;
import com.xinai.inventory.entity.*;
import com.xinai.inventory.service.InventoryService;
import com.xinai.inventory.service.SalesService;
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
public class SalesServiceImpl implements SalesService {

    @Autowired
    private SalesDao salesDao;

    @Autowired
    private InventoryDao inventoryDao;

    @Autowired
    private InventoryService inventoryService;

    @Override
    public Result getOrderList(Map<String, Object> params) {
        int page = params.get("page") != null ? Integer.parseInt(params.get("page").toString()) : 1;
        int limit = params.get("limit") != null ? Integer.parseInt(params.get("limit").toString()) : 10;
        params.put("offset", (page - 1) * limit);
        params.put("limit", limit);
        List<SalesOrder> list = salesDao.getOrderList(params);
        int total = salesDao.getOrderCount(params);
        return Result.page(list, total);
    }

    @Override
    public SalesOrder getOrderById(String orderId) {
        return salesDao.getOrderById(orderId);
    }

    @Override
    @Transactional
    public Result addOrder(SalesOrder order, String userId) {
        String now = new SimpleDateFormat("yyyyMMdd").format(new Date());
        String year = now.substring(0, 4);
        String month = now.substring(4, 6);

        String maxSeq = salesDao.getMaxOrderSeq(year, month);
        int seq = (maxSeq != null ? Integer.parseInt(maxSeq) : 0) + 1;

        order.setOrderId(CodeGenerator.generateOrderCode(year, month, seq));
        order.setOrderYear(year);
        order.setOrderMonth(month);
        order.setOrderSeq(String.format("%04d", seq));
        order.setApplicant(userId);
        order.setApprovalStatus("0");

        // 计算总金额
        if (order.getUnitPrice() != null && order.getSalesQty() != null) {
            order.setTotalAmount(order.getUnitPrice() * order.getSalesQty());
        }

        salesDao.insertOrder(order);
        return Result.success("销售订单新增成功", order);
    }

    @Override
    @Transactional
    public Result updateOrder(SalesOrder order) {
        if (order.getUnitPrice() != null && order.getSalesQty() != null) {
            order.setTotalAmount(order.getUnitPrice() * order.getSalesQty());
        }
        salesDao.updateOrder(order);
        return Result.success("修改成功");
    }

    @Override
    @Transactional
    public Result deleteOrder(String orderId) {
        SalesOrder order = salesDao.getOrderById(orderId);
        if (order == null) return Result.error("订单不存在");
        if (!"0".equals(order.getApprovalStatus())) return Result.error("仅待审批状态可删除");
        salesDao.deleteOrder(orderId);
        return Result.success("删除成功");
    }

    @Override
    @Transactional
    public Result submitOrder(String orderId) {
        salesDao.updateOrderApproval(orderId, "0", null);
        return Result.success("已提交审批");
    }

    @Override
    @Transactional
    public Result approveOrder(String orderId, String approver) {
        salesDao.updateOrderApproval(orderId, "1", approver);
        return Result.success("审批通过");
    }

    @Override
    @Transactional
    public Result rejectOrder(String orderId, String approver) {
        salesDao.updateOrderApproval(orderId, "2", approver);
        return Result.success("已驳回");
    }

    @Override
    public Result getOutboundList(Map<String, Object> params) {
        int page = params.get("page") != null ? Integer.parseInt(params.get("page").toString()) : 1;
        int limit = params.get("limit") != null ? Integer.parseInt(params.get("limit").toString()) : 10;
        params.put("offset", (page - 1) * limit);
        params.put("limit", limit);
        List<SalesOutbound> list = salesDao.getOutboundList(params);
        int total = salesDao.getOutboundCount(params);
        return Result.page(list, total);
    }

    @Override
    public SalesOutbound getOutboundById(Integer outboundId) {
        return salesDao.getOutboundById(outboundId);
    }

    @Override
    @Transactional
    public Result addOutbound(SalesOutbound outbound, String userId) {
        outbound.setOperator(userId);
        outbound.setStatus("0");
        salesDao.insertOutbound(outbound);
        return Result.success("出库单新增成功", outbound);
    }

    @Override
    @Transactional
    public Result confirmOutbound(Integer outboundId, String keeper) {
        SalesOutbound outbound = salesDao.getOutboundById(outboundId);
        if (outbound == null) return Result.error("出库单不存在");
        if ("1".equals(outbound.getStatus())) return Result.error("该出库单已确认");

        // 检查库存是否充足
        Inventory inv = inventoryDao.getInventoryByMaterialId(outbound.getMaterialId());
        if (inv == null || inv.getCurrentQty() < outbound.getOutboundQty()) {
            return Result.error("库存不足，无法出库");
        }

        salesDao.confirmOutbound(outboundId, keeper);
        inventoryDao.updateInventoryQtySubtract(outbound.getMaterialId(), outbound.getOutboundQty());
        inventoryService.checkInventoryWarning(outbound.getMaterialId());
        return Result.success("出库确认成功");
    }

    @Override
    public Result getCustomerList(Map<String, Object> params) {
        int page = params.get("page") != null ? Integer.parseInt(params.get("page").toString()) : 1;
        int limit = params.get("limit") != null ? Integer.parseInt(params.get("limit").toString()) : 10;
        params.put("offset", (page - 1) * limit);
        params.put("limit", limit);
        List<Customer> list = salesDao.getCustomerList(params);
        int total = salesDao.getCustomerCount(params);
        return Result.page(list, total);
    }

    @Override
    public Customer getCustomerById(Integer customerId) {
        return salesDao.getCustomerById(customerId);
    }

    @Override
    @Transactional
    public Result addCustomer(Customer customer) {
        salesDao.insertCustomer(customer);
        return Result.success("客户新增成功", customer);
    }

    @Override
    @Transactional
    public Result updateCustomer(Customer customer) {
        salesDao.updateCustomer(customer);
        return Result.success("修改成功");
    }

    @Override
    public List<Customer> getAllActiveCustomers() {
        return salesDao.getAllActiveCustomers();
    }

    @Override
    public Result getSalesReturnList(Map<String, Object> params) {
        int page = params.get("page") != null ? Integer.parseInt(params.get("page").toString()) : 1;
        int limit = params.get("limit") != null ? Integer.parseInt(params.get("limit").toString()) : 10;
        params.put("offset", (page - 1) * limit);
        params.put("limit", limit);
        List<SalesReturn> list = salesDao.getSalesReturnList(params);
        int total = salesDao.getSalesReturnCount(params);
        return Result.page(list, total);
    }

    @Override
    public SalesReturn getSalesReturnById(Integer returnId) {
        return salesDao.getSalesReturnById(returnId);
    }

    @Override
    @Transactional
    public Result addSalesReturn(SalesReturn salesReturn, String userId) {
        salesReturn.setOperator(userId);
        salesReturn.setStatus("0");
        salesReturn.setApprovalStatus("0");
        salesDao.insertSalesReturn(salesReturn);
        return Result.success("退货申请提交成功", salesReturn);
    }

    @Override
    @Transactional
    public Result approveSalesReturn(Integer returnId) {
        salesDao.approveSalesReturn(returnId);
        return Result.success("退货审批通过");
    }

    @Override
    @Transactional
    public Result confirmSalesReturn(Integer returnId) {
        SalesReturn sr = salesDao.getSalesReturnById(returnId);
        if (sr == null) return Result.error("退货单不存在");
        salesDao.confirmSalesReturn(returnId);
        inventoryDao.updateInventoryQtyAdd(sr.getMaterialId(), sr.getReturnQty());
        inventoryService.checkInventoryWarning(sr.getMaterialId());
        return Result.success("退货入库成功");
    }
}
