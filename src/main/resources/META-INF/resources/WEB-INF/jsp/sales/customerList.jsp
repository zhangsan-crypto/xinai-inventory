<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card"><div class="card-header"><h3>客户信息管理</h3><button class="btn btn-primary btn-sm" onclick="loadPage('${pageContext.request.contextPath}/sales/customerAdd')">＋ 新增客户</button></div>
<div class="card-body">
    <div class="filter-bar"><input type="text" class="form-control" id="keyword" placeholder="搜索客户名称"><select class="form-control" id="status"><option value="">全部</option><option value="0">合作中</option><option value="1">已停止</option></select><button class="btn btn-primary btn-sm" onclick="load()">🔍 搜索</button></div>
    <table class="data-table"><thead><tr><th>编号</th><th>客户名称</th><th>对接人</th><th>联系电话</th><th>合作状态</th><th>操作</th></tr></thead><tbody id="tb"></tbody></table>
    <div id="pg"></div>
</div></div>
<script>
    var cp=1; function load() { XINAI.ajax.get('${pageContext.request.contextPath}/sales/customer/list', {page:cp,limit:10,customerName:document.getElementById('keyword').value,cooperationStatus:document.getElementById('status').value}, function(res) {
        if(res&&res.code===0){var h='';res.data.forEach(function(r){h+='<tr><td>'+r.customerId+'</td><td><strong>'+r.customerName+'</strong></td><td>'+(r.contactPerson||'-')+'</td><td>'+(r.contactPhone||'-')+'</td><td>'+XINAI.util.getStatusTag(r.cooperationStatus,'cooperation')+'</td><td><button class="btn btn-outline btn-sm" onclick="loadPage(\'${pageContext.request.contextPath}/sales/customerEdit?customerId='+r.customerId+'\')">✏️ 编辑</button></td></tr>';});if(res.data.length===0)h='<tr><td colspan="6"><div class="empty-state"><div class="empty-icon">📭</div><p>暂无数据</p></div></td></tr>';document.getElementById('tb').innerHTML=h;XINAI.pagination.render('pg',res.count,cp,10,function(p){cp=p;load();});}
    });} load();
</script>
