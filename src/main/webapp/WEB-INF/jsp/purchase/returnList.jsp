<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card">
    <div class="card-header"><h3>采购退货管理</h3><button class="btn btn-primary btn-sm" onclick="loadPage('${pageContext.request.contextPath}/purchase/returnAdd')">＋ 新增退货</button></div>
    <div class="card-body">
        <table class="data-table">
            <thead><tr><th>退货单号</th><th>关联入库单</th><th>材料名称</th><th>退货数量</th><th>退货原因</th><th>退货日期</th><th>状态</th><th>操作</th></tr></thead>
            <tbody id="tableBody"></tbody>
        </table>
        <div id="pagination"></div>
    </div>
</div>
<script>
    var cp = 1;
    function loadList() {
        XINAI.ajax.get('${pageContext.request.contextPath}/purchase/return/list', {page:cp, limit:10}, function(res) {
            if (res && res.code === 0) {
                var html = '';
                res.data.forEach(function(r) { html += '<tr><td>' + r.returnId + '</td><td>' + r.inboundId + '</td><td><strong>' + r.materialName + '</strong></td><td>' + r.returnQty + '</td><td>' + (r.returnReason||'-') + '</td><td>' + XINAI.util.formatDate(r.returnDate) + '</td><td>' + XINAI.util.getStatusTag(r.status, 'return') + '</td><td>' + (r.status === '0' ? '<button class="btn btn-success btn-sm" onclick="confirmIt(' + r.returnId + ')">✅ 确认退货</button>' : '<span class="tag tag-gray">已处理</span>') + '</td></tr>'; });
                if (res.data.length === 0) html = '<tr><td colspan="8"><div class="empty-state"><div class="empty-icon">📭</div><p>暂无数据</p></div></td></tr>';
                document.getElementById('tableBody').innerHTML = html;
                XINAI.pagination.render('pagination', res.count, cp, 10, function(p) { cp = p; loadList(); });
            }
        });
    }
    function confirmIt(id) { XINAI.util.confirm('确认退货？扣减对应库存。', function() { XINAI.ajax.put('${pageContext.request.contextPath}/purchase/return/confirm/' + id, {}, function(res) { if(res&&res.code===0){alert('退货确认成功');loadList();}else alert(res.msg); }); }); }
    loadList();
</script>
