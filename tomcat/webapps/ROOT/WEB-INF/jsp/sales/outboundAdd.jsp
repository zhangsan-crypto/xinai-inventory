<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card"><div class="card-header"><h3>新增销售出库单</h3></div>
<div class="card-body">
    <div class="form-group"><label>关联已审批订单 <span style="color:red;">*</span></label><select class="form-control" id="orderId" onchange="onOrderChange()"><option value="">请选择</option></select></div>
    <div class="form-row"><div class="form-group"><label>材料名称</label><input type="text" class="form-control" id="matName" readonly></div><div class="form-group"><label>订单数量</label><input type="text" class="form-control" id="orderQty" readonly></div></div>
    <div class="form-group"><label>出库数量 <span style="color:red;">*</span></label><input type="number" class="form-control" id="outboundQty" min="1"></div>
    <div class="form-group"><label>出库日期</label><input type="date" class="form-control" id="outboundDate"></div>
    <div class="form-actions"><button class="btn btn-primary" onclick="submitForm()">提交出库</button><button class="btn btn-outline" onclick="history.back()">取消</button></div>
</div></div>
<script>
    document.getElementById('outboundDate').value = new Date().toISOString().slice(0,10);
    XINAI.ajax.get('${pageContext.request.contextPath}/sales/order/list', {page:1, limit:100, approvalStatus:'1'}, function(res) {
        if (res && res.code === 0) { var sel = document.getElementById('orderId');
            res.data.forEach(function(o) { sel.innerHTML += '<option value="' + o.orderId + '" data-mid="' + (o.materialId||'') + '" data-mname="' + o.materialName + '" data-qty="' + o.salesQty + '">' + o.orderId + ' - ' + o.materialName + ' (数量' + o.salesQty + ')</option>'; }); }
    });
    function onOrderChange() { var opt = document.getElementById('orderId').options[document.getElementById('orderId').selectedIndex]; if(opt.value){document.getElementById('matName').value=opt.dataset.mname;document.getElementById('orderQty').value=opt.dataset.qty;} }
    function submitForm() { var sel=document.getElementById('orderId'); var opt=sel.options[sel.selectedIndex]; var qty=parseInt(document.getElementById('outboundQty').value); if(!opt.value){alert('请选择订单');return;} if(!qty||qty<=0){alert('请输入出库数量');return;}
        XINAI.ajax.post('${pageContext.request.contextPath}/sales/outbound/add', {orderId:opt.value, materialId:opt.dataset.mid, materialName:opt.dataset.mname, outboundQty:qty, outboundDate:document.getElementById('outboundDate').value}, function(res) { if(res&&res.code===0){alert('出库单已提交');loadPage('${pageContext.request.contextPath}/sales/outboundList');} else alert(res.msg); }); }
</script>
