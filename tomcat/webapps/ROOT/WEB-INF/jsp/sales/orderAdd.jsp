<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card"><div class="card-header"><h3>新增销售订单</h3></div>
<div class="card-body">
    <div class="form-group"><label>订单编号</label><div class="code-preview">系统自动生成：XS + 年份(4位) + 月份(2位) + 序号(4位)</div></div>
    <div class="form-row">
        <div class="form-group"><label>客户 <span style="color:red;">*</span></label><select class="form-control" id="customerId"><option value="">请选择客户</option></select></div>
        <div class="form-group"><label>选择材料 <span style="color:red;">*</span></label><select class="form-control" id="materialId" onchange="onMatChange()"><option value="">请选择材料</option></select></div>
    </div>
    <div class="form-row">
        <div class="form-group"><label>销售数量 <span style="color:red;">*</span></label><input type="number" class="form-control" id="salesQty" min="1" onchange="calcTotal()"></div>
        <div class="form-group"><label>单价</label><input type="number" step="0.01" class="form-control" id="unitPrice" onchange="calcTotal()"></div>
    </div>
    <div class="form-row">
        <div class="form-group"><label>总金额</label><input type="text" class="form-control" id="totalAmount" readonly></div>
        <div class="form-group"><label>库存可用</label><input type="text" class="form-control" id="availQty" readonly></div>
    </div>
    <div class="form-group"><label>交货要求</label><textarea class="form-control" id="deliveryReq"></textarea></div>
    <div class="form-group"><label>订单日期</label><input type="date" class="form-control" id="orderDate"></div>
    <div class="form-group"><label>备注</label><textarea class="form-control" id="remark"></textarea></div>
    <div class="form-actions"><button class="btn btn-primary" onclick="submitOrder()">提交订单</button><button class="btn btn-outline" onclick="history.back()">取消</button></div>
</div></div>
<script>
    document.getElementById('orderDate').value = new Date().toISOString().slice(0,10);
    XINAI.ajax.get('${pageContext.request.contextPath}/sales/customer/all', {}, function(res) {
        if (res && res.code === 0) { var sel = document.getElementById('customerId'); res.data.forEach(function(c) { sel.innerHTML += '<option value="' + c.customerId + '" data-cname="' + c.customerName + '">' + c.customerName + '</option>'; }); }
    });
    XINAI.ajax.get('${pageContext.request.contextPath}/inventory/material/all', {}, function(res) {
        if (res && res.code === 0) { var sel = document.getElementById('materialId');
            res.data.forEach(function(m) { sel.innerHTML += '<option value="' + m.materialId + '" data-mname="' + m.materialName + '" data-spec="' + (m.specModel||'') + '" data-price="' + (m.refPrice||0) + '">' + m.materialId + ' - ' + m.materialName + '</option>'; }); }
    });
    function onMatChange() {
        var opt = document.getElementById('materialId').options[document.getElementById('materialId').selectedIndex];
        if (opt && opt.value) {
            document.getElementById('unitPrice').value = opt.dataset.price;
            XINAI.ajax.get('${pageContext.request.contextPath}/inventory/inventory/' + opt.value, {}, function(res2) {
                if (res2 && res2.code === 0 && res2.data) document.getElementById('availQty').value = res2.data.currentQty;
                else document.getElementById('availQty').value = '0';
            });
            calcTotal();
        }
    }
    function calcTotal() {
        var qty = parseFloat(document.getElementById('salesQty').value) || 0;
        var price = parseFloat(document.getElementById('unitPrice').value) || 0;
        document.getElementById('totalAmount').value = '¥' + (qty * price).toFixed(2);
    }
    function submitOrder() {
        var cid = document.getElementById('customerId').value;
        var mid = document.getElementById('materialId').value;
        var qty = parseInt(document.getElementById('salesQty').value);
        var avail = parseInt(document.getElementById('availQty').value) || 0;
        if (!cid) { alert('请选择客户'); return; }
        if (!mid) { alert('请选择材料'); return; }
        if (!qty || qty <= 0) { alert('请输入销售数量'); return; }
        if (qty > avail) { alert('库存不足，当前可用库存: ' + avail); return; }
        var cOpt = document.getElementById('customerId').options[document.getElementById('customerId').selectedIndex];
        var mOpt = document.getElementById('materialId').options[document.getElementById('materialId').selectedIndex];
        var price = parseFloat(document.getElementById('unitPrice').value) || 0;
        XINAI.ajax.post('${pageContext.request.contextPath}/sales/order/add', {
            customerId: parseInt(cid), customerName: cOpt.dataset.cname,
            materialId: mid, materialName: mOpt.dataset.mname, specModel: mOpt.dataset.spec || '',
            salesQty: qty, unitPrice: price, totalAmount: qty * price,
            deliveryRequirement: document.getElementById('deliveryReq').value,
            orderDate: document.getElementById('orderDate').value, remark: document.getElementById('remark').value
        }, function(res) { if (res && res.code === 0) { alert('订单提交成功！编号: ' + (res.data?res.data.orderId:'')); loadPage('${pageContext.request.contextPath}/sales/orderList'); } else alert(res.msg); });
    }
</script>
