<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card">
    <div class="card-header"><h3>采购入库管理</h3><button class="btn btn-primary btn-sm" onclick="loadPage('${pageContext.request.contextPath}/purchase/inboundAdd')">＋ 新增入库</button></div>
    <div class="card-body">
        <table class="data-table">
            <thead><tr><th>入库单号</th><th>关联计划</th><th>材料名称</th><th>入库数量</th><th>入库日期</th><th>供应商</th><th>状态</th><th>操作</th></tr></thead>
            <tbody id="inboundTableBody"></tbody>
        </table>
        <div id="inboundPagination"></div>
    </div>
</div>
<script>
    var cp = 1;
    function loadList() {
        XINAI.ajax.get('${pageContext.request.contextPath}/purchase/inbound/list', {page: cp, limit: 10}, function(res) {
            if (res && res.code === 0) {
                var html = '';
                res.data.forEach(function(r) {
                    html += '<tr><td>' + r.inboundId + '</td><td><code class="user-id dept-01">' + (r.planId||'-') + '</code></td><td><strong>' + r.materialName + '</strong></td><td>' + r.inboundQty + '</td><td>' + XINAI.util.formatDate(r.inboundDate) + '</td><td>' + (r.supplierId||'-') + '</td><td>' + XINAI.util.getStatusTag(r.status, 'inbound') + '</td><td>' +
                        (r.status === '0' ? '<button class="btn btn-success btn-sm" onclick="confirmInbound(' + r.inboundId + ')">✅ 确认入库</button>' : '<span class="tag tag-gray">已确认</span>') +
                        '</td></tr>';
                });
                if (res.data.length === 0) html = '<tr><td colspan="8"><div class="empty-state"><div class="empty-icon">📭</div><p>暂无数据</p></div></td></tr>';
                document.getElementById('inboundTableBody').innerHTML = html;
                XINAI.pagination.render('inboundPagination', res.count, cp, 10, function(p) { cp = p; loadList(); });
            }
        });
    }
    function confirmInbound(id) { XINAI.util.confirm('确认该批材料已验收入库？', function() { XINAI.ajax.put('${pageContext.request.contextPath}/purchase/inbound/confirm/' + id, {}, function(res) { if(res&&res.code===0){alert('入库确认成功，库存已更新');loadList();}else alert(res.msg); }); }); }
    loadList();
</script>
