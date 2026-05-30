package com.xinai.inventory.service;

import com.xinai.inventory.entity.*;
import com.xinai.inventory.util.Result;
import java.util.List;
import java.util.Map;

public interface SalesService {
    // 销售订单
    Result getOrderList(Map<String, Object> params);
    SalesOrder getOrderById(String orderId);
    Result addOrder(SalesOrder order, String userId);
    Result updateOrder(SalesOrder order);
    Result deleteOrder(String orderId);
    Result submitOrder(String orderId);
    Result approveOrder(String orderId, String approver);
    Result rejectOrder(String orderId, String approver);

    // 销售出库
    Result getOutboundList(Map<String, Object> params);
    SalesOutbound getOutboundById(Integer outboundId);
    Result addOutbound(SalesOutbound outbound, String userId);
    Result confirmOutbound(Integer outboundId, String keeper);

    // 客户
    Result getCustomerList(Map<String, Object> params);
    Customer getCustomerById(Integer customerId);
    Result addCustomer(Customer customer);
    Result updateCustomer(Customer customer);
    List<Customer> getAllActiveCustomers();

    // 销售退货
    Result getSalesReturnList(Map<String, Object> params);
    SalesReturn getSalesReturnById(Integer returnId);
    Result addSalesReturn(SalesReturn salesReturn, String userId);
    Result approveSalesReturn(Integer returnId);
    Result confirmSalesReturn(Integer returnId);
}
