<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card">
    <div class="card-header"><h3>销售出库管理</h3><button class="btn btn-primary btn-sm" onclick="loadPage('${pageContext.request.contextPath}/sales/outboundAdd')">＋ 新增出库</button></div>
    <div class="card-body">
        <table class="data-table"><thead><tr><th>出库单号</th><th>关联订单</th><th>材料名称</th><th>出库数量</th><th>出库日期</th><th>状态</th><th>操作</th></tr></thead><tbody id="tb"></tbody></table>
        <div id="pg"></div>
    </div>
</div>
<script>
    var cp = 1;
    function load() { XINAI.ajax.get('${pageContext.request.contextPath}/sales/outbound/list', {page:cp, limit:10}, function(res) {
        if (res && res.code === 0) {
            var h = '';
            res.data.forEach(function(r) { h += '<tr><td>' + r.outboundId + '</td><td><code class="user-id dept-02">' + (r.orderId||'-') + '</code></td><td><strong>' + r.materialName + '</strong></td><td>' + r.outboundQty + '</td><td>' + XINAI.util.formatDate(r.outboundDate) + '</td><td>' + XINAI.util.getStatusTag(r.status, 'outbound') + '</td><td>' + (r.status === '0' ? '<button class="btn btn-success btn-sm" onclick="confirmIt(' + r.outboundId + ')">✅ 确认出库</button>' : '<span class="tag tag-gray">已确认</span>') + '</td></tr>'; });
            if (res.data.length === 0) h = '<tr><td colspan="7"><div class="empty-state"><div class="empty-icon">📭</div><p>暂无数据</p></div></td></tr>';
            document.getElementById('tb').innerHTML = h;
            XINAI.pagination.render('pg', res.count, cp, 10, function(p) { cp = p; load(); });
        }
    });}
    function confirmIt(id) { XINAI.util.confirm('确认出库？将扣减库存。', function() { XINAI.ajax.put('${pageContext.request.contextPath}/sales/outbound/confirm/' + id, {}, function(res) { if(res&&res.code===0){alert('出库确认成功');load();} else alert(res.msg); }); }); }
    load();
</script>
