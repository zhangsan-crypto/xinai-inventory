<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card">
    <div class="card-header"><h3>物料信息管理</h3><button class="btn btn-primary btn-sm" onclick="loadPage('${pageContext.request.contextPath}/inventory/materialAdd')">＋ 新增材料</button></div>
    <div class="card-body">
        <div class="filter-bar">
            <select class="form-control" id="filterCat" onchange="load()"><option value="">全部大类</option><option value="01">钢筋</option><option value="02">水泥</option><option value="03">砂石</option><option value="04">砖</option><option value="05">木材</option><option value="06">防水材料</option></select>
            <select class="form-control" id="filterStatus" onchange="load()"><option value="">全部状态</option><option value="0">正常</option><option value="1">停用</option></select>
            <input type="text" class="form-control" id="keyword" placeholder="搜索名称/编号">
            <button class="btn btn-primary btn-sm" onclick="load()">🔍 搜索</button>
        </div>
        <table class="data-table"><thead><tr><th>材料编号</th><th>材料名称</th><th>大类</th><th>规格型号</th><th>单位</th><th>参考单价</th><th>安全库存</th><th>状态</th><th>操作</th></tr></thead><tbody id="tb"></tbody></table>
        <div id="pg"></div>
    </div>
</div>
<script>
    var cp=1;
    function load(){XINAI.ajax.get('${pageContext.request.contextPath}/inventory/material/list',{page:cp,limit:10,categoryCode:document.getElementById('filterCat').value,status:document.getElementById('filterStatus').value,keyword:document.getElementById('keyword').value},function(res){
        if(res&&res.code===0){var h='';res.data.forEach(function(r){h+='<tr><td>'+XINAI.util.getMaterialCodeHtml(r.materialId,r.categoryCode)+'</td><td><strong>'+r.materialName+'</strong></td><td>'+r.categoryName+'</td><td>'+(r.specModel||'-')+'</td><td>'+r.unit+'</td><td>¥'+(r.refPrice||0).toFixed(2)+'</td><td>'+r.safetyLower+'~'+r.safetyUpper+'</td><td>'+XINAI.util.getStatusTag(r.status,'material')+'</td><td class="operation"><button class="btn btn-outline btn-sm" onclick="loadPage(\'${pageContext.request.contextPath}/inventory/materialEdit?materialId='+r.materialId+'\')">✏️ 编辑</button><button class="btn btn-warning btn-sm" onclick="toggleStatus(\''+r.materialId+'\',\''+(r.status==='0'?'1':'0')+'\')">'+(r.status==='0'?'🚫 停用':'✅ 启用')+'</button></td></tr>';});
            if(res.data.length===0)h='<tr><td colspan="9"><div class="empty-state"><div class="empty-icon">📭</div><p>暂无数据</p></div></td></tr>';document.getElementById('tb').innerHTML=h;XINAI.pagination.render('pg',res.count,cp,10,function(p){cp=p;load();});}
    });}
    function toggleStatus(id,status){XINAI.util.confirm('确定'+(status==='0'?'启用':'停用')+'该材料？',function(){XINAI.ajax.put('${pageContext.request.contextPath}/inventory/material/status/'+id+'?status='+status,{},function(res){if(res&&res.code===0){alert('操作成功');load();} else alert(res.msg);});});}
    load();
</script>
