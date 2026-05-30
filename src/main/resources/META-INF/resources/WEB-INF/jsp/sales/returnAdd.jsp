<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card"><div class="card-header"><h3>新增销售退货申请</h3></div>
<div class="card-body">
    <div class="form-group"><label>关联销售订单</label><select class="form-control" id="orderId" onchange="onChange()"><option value="">请选择已审批订单</option></select></div>
    <div class="form-row"><div class="form-group"><label>客户编号</label><input type="text" class="form-control" id="customerId" readonly></div><div class="form-group"><label>材料名称</label><input type="text" class="form-control" id="matName" readonly></div></div>
    <div class="form-group"><label>退货数量 <span style="color:red;">*</span></label><input type="number" class="form-control" id="returnQty" min="1"></div>
    <div class="form-group"><label>退货原因</label><textarea class="form-control" id="returnReason"></textarea></div>
    <div class="form-group"><label>退货日期</label><input type="date" class="form-control" id="returnDate"></div>
    <div class="form-actions"><button class="btn btn-primary" onclick="submitForm()">提交申请</button><button class="btn btn-outline" onclick="history.back()">取消</button></div>
</div></div>
<script>
    document.getElementById('returnDate').value=new Date().toISOString().slice(0,10);
    XINAI.ajax.get('${pageContext.request.contextPath}/sales/order/list',{page:1,limit:100,approvalStatus:'1'},function(res){
        if(res&&res.code===0){var sel=document.getElementById('orderId');res.data.forEach(function(o){sel.innerHTML+='<option value="'+o.orderId+'" data-cid="'+o.customerId+'" data-cname="'+o.customerName+'" data-mid="'+o.materialId+'" data-mname="'+o.materialName+'">'+o.orderId+' - '+o.customerName+' - '+o.materialName+'</option>';});}
    });
    function onChange(){var opt=document.getElementById('orderId').options[document.getElementById('orderId').selectedIndex];if(opt.value){document.getElementById('customerId').value=opt.dataset.cid;document.getElementById('matName').value=opt.dataset.mname;}}
    function submitForm(){var sel=document.getElementById('orderId');var opt=sel.options[sel.selectedIndex];var qty=parseInt(document.getElementById('returnQty').value);if(!opt.value){alert('请选择订单');return;}if(!qty||qty<=0){alert('请输入退货数量');return;}
        XINAI.ajax.post('${pageContext.request.contextPath}/sales/return/add',{orderId:opt.value,customerId:parseInt(opt.dataset.cid),materialId:opt.dataset.mid,materialName:opt.dataset.mname,returnQty:qty,returnReason:document.getElementById('returnReason').value,returnDate:document.getElementById('returnDate').value},function(res){if(res&&res.code===0){alert('退货申请已提交');loadPage('${pageContext.request.contextPath}/sales/returnList');} else alert(res.msg);});}
</script>
