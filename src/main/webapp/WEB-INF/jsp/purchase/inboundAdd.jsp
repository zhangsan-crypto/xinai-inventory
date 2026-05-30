<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card">
    <div class="card-header"><h3>新增采购入库单</h3></div>
    <div class="card-body">
        <div class="form-row">
            <div class="form-group">
                <label>关联采购计划 <span style="color:red;">*</span></label>
                <select class="form-control" id="planId" onchange="onPlanChange()"><option value="">请选择已审批计划</option></select>
            </div>
            <div class="form-group">
                <label>供应商 <span style="color:red;">*</span></label>
                <select class="form-control" id="supplierId"><option value="">请选择供应商</option></select>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group"><label>材料名称</label><input type="text" class="form-control" id="matName" readonly></div>
            <div class="form-group"><label>规格型号</label><input type="text" class="form-control" id="specModel" readonly></div>
        </div>
        <div class="form-row">
            <div class="form-group"><label>入库数量 <span style="color:red;">*</span></label><input type="number" class="form-control" id="inboundQty" min="1"></div>
            <div class="form-group"><label>入库日期</label><input type="date" class="form-control" id="inboundDate"></div>
        </div>
        <div class="form-group"><label>备注</label><textarea class="form-control" id="remark"></textarea></div>
        <div class="form-actions">
            <button class="btn btn-primary" onclick="submitInbound()">提交入库</button>
            <button class="btn btn-outline" onclick="history.back()">取消</button>
        </div>
    </div>
</div>
<script>
    // 加载已审批计划
    XINAI.ajax.get('${pageContext.request.contextPath}/purchase/plan/list', {page:1, limit:100, approvalStatus:'1'}, function(res) {
        if (res && res.code === 0) {
            var sel = document.getElementById('planId');
            res.data.forEach(function(p) { sel.innerHTML += '<option value="' + p.planId + '" data-mid="' + (p.materialId||'') + '" data-mname="' + p.materialName + '" data-spec="' + (p.specModel||'') + '" data-qty="' + p.demandQty + '">' + p.planId + ' - ' + p.materialName + '</option>'; });
        }
    });
    // 加载供应商
    XINAI.ajax.get('${pageContext.request.contextPath}/purchase/supplier/all', {}, function(res) {
        if (res && res.code === 0) {
            var sel = document.getElementById('supplierId');
            res.data.forEach(function(s) { sel.innerHTML += '<option value="' + s.supplierId + '">' + s.supplierName + '</option>'; });
        }
    });
    document.getElementById('inboundDate').value = new Date().toISOString().slice(0,10);

    function onPlanChange() {
        var sel = document.getElementById('planId');
        var opt = sel.options[sel.selectedIndex];
        if (opt && opt.value) {
            document.getElementById('matName').value = opt.dataset.mname || '';
            document.getElementById('specModel').value = opt.dataset.spec || '';
        }
    }

    function submitInbound() {
        var planId = document.getElementById('planId').value;
        var supplierId = document.getElementById('supplierId').value;
        var qty = document.getElementById('inboundQty').value;
        if (!planId) { alert('请选择采购计划'); return; }
        if (!supplierId) { alert('请选择供应商'); return; }
        if (!qty || qty <= 0) { alert('请输入入库数量'); return; }
        var opt = document.getElementById('planId').options[document.getElementById('planId').selectedIndex];
        XINAI.ajax.post('${pageContext.request.contextPath}/purchase/inbound/add', {
            planId: planId, supplierId: parseInt(supplierId),
            materialId: opt.dataset.mid, materialName: opt.dataset.mname, specModel: opt.dataset.spec,
            inboundQty: parseInt(qty), inboundDate: document.getElementById('inboundDate').value,
            remark: document.getElementById('remark').value
        }, function(res) {
            if (res && res.code === 0) { alert('入库单已提交，待仓库验收'); loadPage('${pageContext.request.contextPath}/purchase/inboundList'); }
            else { alert(res ? res.msg : '提交失败'); }
        });
    }
</script>
