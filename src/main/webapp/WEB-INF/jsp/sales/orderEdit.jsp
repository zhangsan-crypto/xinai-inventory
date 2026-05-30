<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card"><div class="card-header"><h3>编辑销售订单</h3></div>
<div class="card-body">
    <input type="hidden" id="orderId" value="${orderId}">
    <div class="form-group"><label>订单编号</label><input type="text" class="form-control" id="showId" readonly></div>
    <div class="form-row"><div class="form-group"><label>客户</label><input type="text" class="form-control" id="custName" readonly></div><div class="form-group"><label>材料</label><input type="text" class="form-control" id="matName" readonly></div></div>
    <div class="form-row"><div class="form-group"><label>销售数量</label><input type="number" class="form-control" id="editQty" onchange="calc()"></div><div class="form-group"><label>单价</label><input type="number" step="0.01" class="form-control" id="editPrice" onchange="calc()"></div></div>
    <div class="form-group"><label>总金额</label><input type="text" class="form-control" id="editTotal" readonly></div>
    <div class="form-actions"><button class="btn btn-primary" onclick="updateOrder()">保存修改</button><button class="btn btn-outline" onclick="history.back()">取消</button></div>
</div></div>
<script>
    var oid = document.getElementById('orderId').value;
    XINAI.ajax.get('${pageContext.request.contextPath}/sales/order/' + oid, {}, function(res) {
        if (res && res.code === 0 && res.data) {
            var o = res.data;
            document.getElementById('showId').value = o.orderId;
            document.getElementById('custName').value = o.customerName;
            document.getElementById('matName').value = o.materialName;
            document.getElementById('editQty').value = o.salesQty;
            document.getElementById('editPrice').value = o.unitPrice;
            calc();
        }
    });
    function calc() { var q = parseFloat(document.getElementById('editQty').value)||0; var p = parseFloat(document.getElementById('editPrice').value)||0; document.getElementById('editTotal').value = '¥' + (q*p).toFixed(2); }
    function updateOrder() {
        var qty = parseInt(document.getElementById('editQty').value);
        var price = parseFloat(document.getElementById('editPrice').value)||0;
        XINAI.ajax.put('${pageContext.request.contextPath}/sales/order/update', {orderId: oid, salesQty: qty, unitPrice: price, totalAmount: qty*price}, function(res) { if(res&&res.code===0){alert('修改成功');loadPage('${pageContext.request.contextPath}/sales/orderList');} else alert(res.msg); });
    }
</script>
