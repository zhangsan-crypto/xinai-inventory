package com.xinai.inventory.dao;

import com.xinai.inventory.entity.*;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

public interface SalesDao {
    // 销售订单
    List<SalesOrder> getOrderList(Map<String, Object> params);
    int getOrderCount(Map<String, Object> params);
    SalesOrder getOrderById(@Param("orderId") String orderId);
    int insertOrder(SalesOrder order);
    int updateOrder(SalesOrder order);
    int deleteOrder(@Param("orderId") String orderId);
    int updateOrderApproval(@Param("orderId") String orderId, @Param("status") String status, @Param("approver") String approver);
    String getMaxOrderSeq(@Param("year") String year, @Param("month") String month);
    List<SalesOrder> getOrdersByStatus(@Param("status") String status);

    // 销售出库
    List<SalesOutbound> getOutboundList(Map<String, Object> params);
    int getOutboundCount(Map<String, Object> params);
    SalesOutbound getOutboundById(@Param("outboundId") Integer outboundId);
    int insertOutbound(SalesOutbound outbound);
    int confirmOutbound(@Param("outboundId") Integer outboundId, @Param("warehouseKeeper") String warehouseKeeper);
    List<SalesOutbound> getPendingOutbounds();

    // 客户
    List<Customer> getCustomerList(Map<String, Object> params);
    int getCustomerCount(Map<String, Object> params);
    Customer getCustomerById(@Param("customerId") Integer customerId);
    int insertCustomer(Customer customer);
    int updateCustomer(Customer customer);
    List<Customer> getAllActiveCustomers();

    // 销售退货
    List<SalesReturn> getSalesReturnList(Map<String, Object> params);
    int getSalesReturnCount(Map<String, Object> params);
    SalesReturn getSalesReturnById(@Param("returnId") Integer returnId);
    int insertSalesReturn(SalesReturn salesReturn);
    int approveSalesReturn(@Param("returnId") Integer returnId);
    int confirmSalesReturn(@Param("returnId") Integer returnId);
}
