<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card">
    <div class="card-header"><h3>销售订单管理</h3><button class="btn btn-primary btn-sm" onclick="loadPage('${pageContext.request.contextPath}/sales/orderAdd')">＋ 新增订单</button></div>
    <div class="card-body">
        <div class="filter-bar">
            <input type="date" class="form-control" id="startDate"><input type="date" class="form-control" id="endDate">
            <select class="form-control" id="filterStatus" onchange="loadOrders()"><option value="">全部状态</option><option value="0">待审批</option><option value="1">已审批</option><option value="2">已驳回</option></select>
            <button class="btn btn-primary btn-sm" onclick="loadOrders()">🔍 搜索</button>
        </div>
        <table class="data-table"><thead><tr><th>订单编号</th><th>客户名称</th><th>材料</th><th>数量</th><th>单价</th><th>总金额</th><th>订单日期</th><th>审批状态</th><th>操作</th></tr></thead><tbody id="orderTableBody"></tbody></table>
        <div id="orderPagination"></div>
    </div>
</div>
<script>
    var cp = 1;
    function loadOrders() {
        XINAI.ajax.get('${pageContext.request.contextPath}/sales/order/list', {page:cp, limit:10, startDate:document.getElementById('startDate').value, endDate:document.getElementById('endDate').value, approvalStatus:document.getElementById('filterStatus').value}, function(res) {
            if (res && res.code === 0) {
                var html = '';
                res.data.forEach(function(o) { html += '<tr><td><code class="user-id dept-02">' + o.orderId + '</code></td><td><strong>' + o.customerName + '</strong></td><td>' + o.materialName + '</td><td>' + o.salesQty + '</td><td>¥' + (o.unitPrice||0).toFixed(2) + '</td><td><strong>¥' + (o.totalAmount||0).toFixed(2) + '</strong></td><td>' + XINAI.util.formatDate(o.orderDate) + '</td><td>' + XINAI.util.getStatusTag(o.approvalStatus) + '</td><td class="operation">' + (o.approvalStatus === '0' ? '<button class="btn btn-success btn-sm" onclick="approve(\'' + o.orderId + '\')">✅ 审批</button><button class="btn btn-danger btn-sm" onclick="reject(\'' + o.orderId + '\')">❌ 驳回</button><button class="btn btn-danger btn-sm" onclick="del(\'' + o.orderId + '\')">🗑️ 删除</button>' : '<span class="tag tag-gray">已处理</span>') + '</td></tr>'; });
                if (res.data.length === 0) html = '<tr><td colspan="9"><div class="empty-state"><div class="empty-icon">📭</div><p>暂无数据</p></div></td></tr>';
                document.getElementById('orderTableBody').innerHTML = html;
                XINAI.pagination.render('orderPagination', res.count, cp, 10, function(p) { cp = p; loadOrders(); });
            }
        });
    }
    function approve(id) { XINAI.util.confirm('审批通过该订单？', function() { XINAI.ajax.put('${pageContext.request.contextPath}/sales/order/approve/' + id, {}, function(res) { if(res&&res.code===0){alert('已审批通过');loadOrders();} }); }); }
    function reject(id) { XINAI.util.confirm('驳回该订单？', function() { XINAI.ajax.put('${pageContext.request.contextPath}/sales/order/reject/' + id, {}, function(res) { if(res&&res.code===0){alert('已驳回');loadOrders();} }); }); }
    function del(id) { XINAI.util.confirm('确定删除？', function() { XINAI.ajax.del('${pageContext.request.contextPath}/sales/order/delete/' + id, function(res) { if(res&&res.code===0){alert('已删除');loadOrders();} }); }); }
    loadOrders();
</script>
