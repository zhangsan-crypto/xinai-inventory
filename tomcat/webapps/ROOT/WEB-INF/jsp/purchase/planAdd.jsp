<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card">
    <div class="card-header"><h3>新增采购计划</h3></div>
    <div class="card-body">
        <div class="form-group">
            <label>计划编号</label>
            <div class="code-preview">系统自动生成：CG + 年份(4位) + 月份(2位) + 序号(4位)</div>
        </div>
        <div class="form-row">
            <div class="form-group">
                <label>选择材料 <span style="color:red;">*</span></label>
                <select class="form-control" id="materialId" onchange="onMaterialChange()">
                    <option value="">请选择材料</option>
                </select>
            </div>
            <div class="form-group">
                <label>需求数量 <span style="color:red;">*</span></label>
                <input type="number" class="form-control" id="demandQty" min="1" placeholder="请输入需求数量">
            </div>
        </div>
        <div class="form-row">
            <div class="form-group">
                <label>计划日期</label>
                <input type="date" class="form-control" id="planDate">
            </div>
            <div class="form-group">
                <label>材料规格</label>
                <input type="text" class="form-control" id="specModel" readonly placeholder="选择材料后自动显示">
            </div>
        </div>
        <div class="form-group">
            <label>备注</label>
            <textarea class="form-control" id="remark" placeholder="可选填写备注信息"></textarea>
        </div>
        <div class="form-actions">
            <button class="btn btn-primary" onclick="submitPlan()">保存</button>
            <button class="btn btn-outline" onclick="loadPage('${pageContext.request.contextPath}/purchase/planList')">取消</button>
        </div>
    </div>
</div>
<script>
    // 加载材料列表
    XINAI.ajax.get('${pageContext.request.contextPath}/inventory/material/all', {}, function(res) {
        if (res && res.code === 0) {
            var sel = document.getElementById('materialId');
            res.data.forEach(function(m) { sel.innerHTML += '<option value="' + m.materialId + '" data-name="' + m.materialName + '" data-spec="' + (m.specModel||'') + '">' + m.materialId + ' - ' + m.materialName + '</option>'; });
        }
    });
    // 设置默认日期
    document.getElementById('planDate').value = new Date().toISOString().slice(0,10);

    function onMaterialChange() {
        var sel = document.getElementById('materialId');
        var opt = sel.options[sel.selectedIndex];
        if (opt && opt.value) {
            document.getElementById('specModel').value = opt.dataset.spec || '';
        }
    }

    function submitPlan() {
        var sel = document.getElementById('materialId');
        var opt = sel.options[sel.selectedIndex];
        if (!opt || !opt.value) { alert('请选择材料'); return; }
        var demandQty = document.getElementById('demandQty').value;
        if (!demandQty || demandQty <= 0) { alert('请输入有效的需求数量'); return; }
        var data = {
            materialId: opt.value,
            materialName: opt.dataset.name,
            specModel: document.getElementById('specModel').value,
            demandQty: parseInt(demandQty),
            planDate: document.getElementById('planDate').value,
            remark: document.getElementById('remark').value
        };
        XINAI.ajax.post('${pageContext.request.contextPath}/purchase/plan/add', data, function(res) {
            if (res && res.code === 0) { alert('采购计划新增成功！编号: ' + (res.data?res.data.planId:'')); loadPage('${pageContext.request.contextPath}/purchase/planList'); }
            else { alert(res ? res.msg : '新增失败'); }
        });
    }
</script>
