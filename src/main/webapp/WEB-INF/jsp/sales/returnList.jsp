<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card"><div class="card-header"><h3>销售退货管理</h3><button class="btn btn-primary btn-sm" onclick="loadPage('${pageContext.request.contextPath}/sales/returnAdd')">＋ 新增退货申请</button></div>
<div class="card-body">
    <table class="data-table"><thead><tr><th>退货单号</th><th>关联订单</th><th>客户</th><th>材料</th><th>退货数量</th><th>退货原因</th><th>审批状态</th><th>状态</th><th>操作</th></tr></thead><tbody id="tb"></tbody></table>
    <div id="pg"></div>
</div></div>
<script>
    var cp=1;
    function load(){XINAI.ajax.get('${pageContext.request.contextPath}/sales/return/list',{page:cp,limit:10},function(res){
        if(res&&res.code===0){var h='';res.data.forEach(function(r){h+='<tr><td>'+r.returnId+'</td><td><code class="user-id dept-02">'+(r.orderId||'-')+'</code></td><td>'+r.customerId+'</td><td><strong>'+r.materialName+'</strong></td><td>'+r.returnQty+'</td><td>'+(r.returnReason||'-')+'</td><td>'+XINAI.util.getStatusTag(r.approvalStatus)+'</td><td>'+XINAI.util.getStatusTag(r.status,'salesReturn')+'</td><td class="operation">'+(r.approvalStatus==='0'?'<button class="btn btn-success btn-sm" onclick="approve('+r.returnId+')">✅ 审批</button>':'')+(r.status==='0'&&r.approvalStatus==='1'?'<button class="btn btn-success btn-sm" onclick="confirmIt('+r.returnId+')">📦 确认入库</button>':'')+'</td></tr>';});
            if(res.data.length===0)h='<tr><td colspan="9"><div class="empty-state"><div class="empty-icon">📭</div><p>暂无数据</p></div></td></tr>';document.getElementById('tb').innerHTML=h;XINAI.pagination.render('pg',res.count,cp,10,function(p){cp=p;load();});}
    });}
    function approve(id){XINAI.util.confirm('审批通过该退货申请？',function(){XINAI.ajax.put('${pageContext.request.contextPath}/sales/return/approve/'+id,{},function(res){if(res&&res.code===0){alert('已审批通过');load();} else alert(res.msg);});});}
    function confirmIt(id){XINAI.util.confirm('确认退货入库？将增加库存。',function(){XINAI.ajax.put('${pageContext.request.contextPath}/sales/return/confirm/'+id,{},function(res){if(res&&res.code===0){alert('退货入库成功');load();} else alert(res.msg);});});}
    load();
</script>
