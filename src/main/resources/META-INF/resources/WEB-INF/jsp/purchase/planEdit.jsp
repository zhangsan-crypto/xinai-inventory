<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card">
    <div class="card-header"><h3>编辑采购计划</h3></div>
    <div class="card-body">
        <input type="hidden" id="planId" value="${planId}">
        <div class="form-group"><label>计划编号</label><input type="text" class="form-control" id="showPlanId" readonly></div>
        <div class="form-row">
            <div class="form-group"><label>材料名称</label><input type="text" class="form-control" id="matName" readonly></div>
            <div class="form-group"><label>需求数量</label><input type="number" class="form-control" id="editDemandQty"></div>
        </div>
        <div class="form-group"><label>备注</label><textarea class="form-control" id="editRemark"></textarea></div>
        <div class="form-actions">
            <button class="btn btn-primary" onclick="updatePlan()">保存修改</button>
            <button class="btn btn-outline" onclick="history.back()">取消</button>
        </div>
    </div>
</div>
<script>
    var planId = document.getElementById('planId').value;
    XINAI.ajax.get('${pageContext.request.contextPath}/purchase/plan/' + planId, {}, function(res) {
        if (res && res.code === 0 && res.data) {
            var p = res.data;
            document.getElementById('showPlanId').value = p.planId;
            document.getElementById('matName').value = p.materialName;
            document.getElementById('editDemandQty').value = p.demandQty;
            document.getElementById('editRemark').value = p.remark||'';
        }
    });
    function updatePlan() {
        var qty = document.getElementById('editDemandQty').value;
        if (!qty || qty <= 0) { alert('请输入有效数量'); return; }
        XINAI.ajax.put('${pageContext.request.contextPath}/purchase/plan/update', {planId: planId, demandQty: parseInt(qty), remark: document.getElementById('editRemark').value}, function(res) {
            if (res && res.code === 0) { alert('修改成功'); loadPage('${pageContext.request.contextPath}/purchase/planList'); }
            else { alert(res ? res.msg : '修改失败'); }
        });
    }
</script>
