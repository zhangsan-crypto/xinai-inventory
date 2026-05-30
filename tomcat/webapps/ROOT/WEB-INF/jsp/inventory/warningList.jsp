<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card">
    <div class="card-header"><h3>库存预警管理</h3><button class="btn btn-outline btn-sm" onclick="load()">🔄 刷新</button></div>
    <div class="card-body">
        <div class="filter-bar">
            <select class="form-control" id="filterType" onchange="load()"><option value="">全部类型</option><option value="0">库存不足</option><option value="1">库存积压</option></select>
            <select class="form-control" id="filterStatus" onchange="load()"><option value="">全部状态</option><option value="0">未处理</option><option value="1">已处理</option></select>
            <button class="btn btn-primary btn-sm" onclick="load()">🔍 查询</button>
        </div>
        <table class="data-table"><thead><tr><th>预警ID</th><th>材料名称</th><th>当前库存</th><th>安全下限</th><th>安全上限</th><th>预警类型</th><th>预警日期</th><th>处理状态</th><th>操作</th></tr></thead><tbody id="tb"></tbody></table>
        <div id="pg"></div>
    </div>
</div>
<script>
    var cp=1;
    function load(){XINAI.ajax.get('${pageContext.request.contextPath}/inventory/warning/list',{page:cp,limit:10,warningType:document.getElementById('filterType').value,status:document.getElementById('filterStatus').value},function(res){
        if(res&&res.code===0){var h='';res.data.forEach(function(r){h+='<tr><td>'+r.warningId+'</td><td><strong>'+r.materialName+'</strong></td><td><strong>'+(r.currentQty||0)+'</strong></td><td>'+(r.safetyLower||0)+'</td><td>'+(r.safetyUpper||0)+'</td><td>'+XINAI.util.getStatusTag(r.warningType,'warningType')+'</td><td>'+XINAI.util.formatDate(r.warningDate)+'</td><td>'+XINAI.util.getStatusTag(r.status,'warning')+'</td><td>'+(r.status==='0'?'<button class="btn btn-success btn-sm" onclick="handle('+r.warningId+')">✅ 处理</button>':'<span class="tag tag-gray">已处理</span>')+'</td></tr>';});
            if(res.data.length===0)h='<tr><td colspan="9"><div class="empty-state"><div class="empty-icon">📭</div><p>暂无预警</p></div></td></tr>';document.getElementById('tb').innerHTML=h;XINAI.pagination.render('pg',res.count,cp,10,function(p){cp=p;load();});}
    });}
    function handle(id){XINAI.util.confirm('标记该预警为已处理？',function(){XINAI.ajax.put('${pageContext.request.contextPath}/inventory/warning/handle/'+id,{},function(res){if(res&&res.code===0){alert('已处理');load();} else alert(res.msg);});});}
    load();
</script>
