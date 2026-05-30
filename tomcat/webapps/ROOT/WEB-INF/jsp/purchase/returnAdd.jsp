<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card"><div class="card-header"><h3>新增采购退货</h3></div>
<div class="card-body">
    <div class="form-group"><label>关联入库单</label><select class="form-control" id="inboundId" onchange="onInboundChange()"><option value="">请选择</option></select></div>
    <div class="form-row">
        <div class="form-group"><label>材料名称</label><input type="text" class="form-control" id="matName" readonly></div>
        <div class="form-group"><label>可退数量</label><input type="text" class="form-control" id="maxQty" readonly></div>
    </div>
    <div class="form-group"><label>退货数量 <span style="color:red;">*</span></label><input type="number" class="form-control" id="returnQty" min="0"></div>
    <div class="form-group"><label>退货原因</label><textarea class="form-control" id="returnReason"></textarea></div>
    <div class="form-group"><label>退货日期</label><input type="date" class="form-control" id="returnDate"></div>
    <div class="form-actions">
        <button class="btn btn-primary" onclick="submitForm()">提交</button>
        <button class="btn btn-outline" onclick="history.back()">取消</button>
    </div>
</div></div>
<script>
    document.getElementById('returnDate').value = new Date().toISOString().slice(0,10);
    XINAI.ajax.get('${pageContext.request.contextPath}/purchase/inbound/list', {page:1, limit:100}, function(res) {
        if (res && res.code === 0) {
            var sel = document.getElementById('inboundId');
            res.data.forEach(function(r) { sel.innerHTML += '<option value="' + r.inboundId + '" data-mid="' + (r.materialId||'') + '" data-mname="' + r.materialName + '" data-qty="' + r.inboundQty + '" data-sid="' + (r.supplierId||0) + '">#' + r.inboundId + ' - ' + r.materialName + ' (入库' + r.inboundQty + ')</option>'; });
        }
    });
    function onInboundChange() {
        var opt = document.getElementById('inboundId').options[document.getElementById('inboundId').selectedIndex];
        if (opt && opt.value) { document.getElementById('matName').value = opt.dataset.mname; document.getElementById('maxQty').value = opt.dataset.qty; }
    }
    function submitForm() {
        var sel = document.getElementById('inboundId');
        var opt = sel.options[sel.selectedIndex];
        if (!opt.value) { alert('请选择入库单'); return; }
        var qty = parseInt(document.getElementById('returnQty').value);
        if (!qty || qty <= 0) { alert('请输入退货数量'); return; }
        var maxQ = parseInt(opt.dataset.qty);
        if (qty > maxQ) { alert('退货数量不能超过入库数量 ' + maxQ); return; }
        XINAI.ajax.post('${pageContext.request.contextPath}/purchase/return/add', {
            inboundId: parseInt(opt.value), materialId: opt.dataset.mid, materialName: opt.dataset.mname,
            returnQty: qty, returnReason: document.getElementById('returnReason').value,
            returnDate: document.getElementById('returnDate').value, supplierId: parseInt(opt.dataset.sid || 0)
        }, function(res) { if (res && res.code === 0) { alert('退货单已提交'); loadPage('${pageContext.request.contextPath}/purchase/returnList'); } else alert(res.msg); });
    }
</script>
