<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card">
    <div class="card-header"><h3>供应商信息管理</h3><button class="btn btn-primary btn-sm" onclick="loadPage('${pageContext.request.contextPath}/purchase/supplierAdd')">＋ 新增供应商</button></div>
    <div class="card-body">
        <div class="filter-bar">
            <input type="text" class="form-control" id="keyword" placeholder="搜索供应商名称">
            <select class="form-control" id="coopStatus" onchange="loadList()"><option value="">全部状态</option><option value="0">合作中</option><option value="1">已停止</option></select>
            <button class="btn btn-primary btn-sm" onclick="loadList()">🔍 搜索</button>
        </div>
        <table class="data-table">
            <thead><tr><th>编号</th><th>供应商名称</th><th>联系人</th><th>联系电话</th><th>主营材料</th><th>合作状态</th><th>操作</th></tr></thead>
            <tbody id="tableBody"></tbody>
        </table>
        <div id="pagination"></div>
    </div>
</div>
<script>
    var cp = 1;
    function loadList() {
        XINAI.ajax.get('${pageContext.request.contextPath}/purchase/supplier/list', {page:cp, limit:10, supplierName:document.getElementById('keyword').value, cooperationStatus:document.getElementById('coopStatus').value}, function(res) {
            if (res && res.code === 0) {
                var html = '';
                res.data.forEach(function(r) { html += '<tr><td>' + r.supplierId + '</td><td><strong>' + r.supplierName + '</strong></td><td>' + (r.contactPerson||'-') + '</td><td>' + (r.contactPhone||'-') + '</td><td>' + (r.mainMaterial||'-') + '</td><td>' + XINAI.util.getStatusTag(r.cooperationStatus, 'cooperation') + '</td><td><button class="btn btn-outline btn-sm" onclick="loadPage(\'${pageContext.request.contextPath}/purchase/supplierEdit?supplierId=' + r.supplierId + '\')">✏️ 编辑</button></td></tr>'; });
                if (res.data.length === 0) html = '<tr><td colspan="7"><div class="empty-state"><div class="empty-icon">📭</div><p>暂无数据</p></div></td></tr>';
                document.getElementById('tableBody').innerHTML = html;
                XINAI.pagination.render('pagination', res.count, cp, 10, function(p) { cp = p; loadList(); });
            }
        });
    }
    loadList();
</script>
