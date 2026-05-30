<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card">
    <div class="card-header"><h3>库存盘点管理</h3><button class="btn btn-primary btn-sm" onclick="loadPage('${pageContext.request.contextPath}/inventory/checkAdd')">＋ 新增盘点</button></div>
    <div class="card-body">
        <div class="filter-bar">
            <input type="date" class="form-control" id="startDate"><input type="date" class="form-control" id="endDate">
            <select class="form-control" id="filterStatus" onchange="load()"><option value="">全部状态</option><option value="0">待审批</option><option value="1">已审批</option></select>
            <button class="btn btn-primary btn-sm" onclick="load()">🔍 搜索</button>
        </div>
        <table class="data-table"><thead><tr><th>盘点单号</th><th>材料名称</th><th>账面数量</th><th>实际数量</th><th>差异</th><th>盘点日期</th><th>审批状态</th><th>操作</th></tr></thead><tbody id="tb"></tbody></table>
        <div id="pg"></div>
    </div>
</div>
<script>
    var cp=1;
    function load(){XINAI.ajax.get('${pageContext.request.contextPath}/inventory/check/list',{page:cp,limit:10,startDate:document.getElementById('startDate').value,endDate:document.getElementById('endDate').value,approvalStatus:document.getElementById('filterStatus').value},function(res){
        if(res&&res.code===0){var h='';res.data.forEach(function(r){h+='<tr><td><code class="user-id dept-03">'+r.checkId+'</code></td><td><strong>'+r.materialName+'</strong></td><td>'+r.bookQty+'</td><td>'+r.actualQty+'</td><td>'+XINAI.util.getDiffTag(r.diffQty)+'</td><td>'+XINAI.util.formatDate(r.checkDate)+'</td><td>'+XINAI.util.getStatusTag(r.approvalStatus)+'</td><td>'+(r.approvalStatus==='0'?'<button class="btn btn-success btn-sm" onclick="approve(\''+r.checkId+'\')">✅ 审批通过</button>':'<span class="tag tag-gray">已审批</span>')+'</td></tr>';});
            if(res.data.length===0)h='<tr><td colspan="8"><div class="empty-state"><div class="empty-icon">📭</div><p>暂无数据</p></div></td></tr>';document.getElementById('tb').innerHTML=h;XINAI.pagination.render('pg',res.count,cp,10,function(p){cp=p;load();});}
    });}
    function approve(id){XINAI.util.confirm('审批通过后库存将更新为实际数量，确认？',function(){XINAI.ajax.put('${pageContext.request.contextPath}/inventory/check/approve/'+id,{},function(res){if(res&&res.code===0){alert('审批通过，库存已更新');load();} else alert(res.msg);});});}
    load();
</script>
