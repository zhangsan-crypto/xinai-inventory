<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card">
    <div class="card-header"><h3>采购计划管理</h3><button class="btn btn-primary btn-sm" onclick="loadPage('${pageContext.request.contextPath}/purchase/planAdd')">＋ 新增计划</button></div>
    <div class="card-body">
        <div class="filter-bar">
            <input type="date" class="form-control" id="startDate">
            <input type="date" class="form-control" id="endDate">
            <select class="form-control" id="filterApproval" onchange="loadPlans()">
                <option value="">全部状态</option>
                <option value="0">待审批</option>
                <option value="1">已审批</option>
                <option value="2">已驳回</option>
            </select>
            <button class="btn btn-primary btn-sm" onclick="loadPlans()">🔍 搜索</button>
        </div>
        <table class="data-table">
            <thead><tr><th>计划编号</th><th>材料名称</th><th>规格型号</th><th>需求数量</th><th>计划日期</th><th>采购人员</th><th>审批状态</th><th>操作</th></tr></thead>
            <tbody id="planTableBody"></tbody>
        </table>
        <div id="planPagination"></div>
    </div>
</div>
<script>
    var currentPage = 1;
    function loadPlans() {
        XINAI.ajax.get('${pageContext.request.contextPath}/purchase/plan/list', {
            page: currentPage, limit: 10,
            startDate: document.getElementById('startDate').value,
            endDate: document.getElementById('endDate').value,
            approvalStatus: document.getElementById('filterApproval').value
        }, function(res) {
            if (res && res.code === 0) {
                var html = '';
                res.data.forEach(function(p) {
                    html += '<tr><td><code class="user-id dept-01">' + p.planId + '</code></td>' +
                        '<td><strong>' + p.materialName + '</strong></td>' +
                        '<td>' + (p.specModel||'-') + '</td>' +
                        '<td>' + p.demandQty + '</td>' +
                        '<td>' + XINAI.util.formatDate(p.planDate) + '</td>' +
                        '<td>' + p.applicant + '</td>' +
                        '<td>' + XINAI.util.getStatusTag(p.approvalStatus) + '</td>' +
                        '<td class="operation">' +
                        (p.approvalStatus === '0' ? '<button class="btn btn-success btn-sm" onclick="approvePlan(\'' + p.planId + '\')">✅ 审批通过</button><button class="btn btn-danger btn-sm" onclick="rejectPlan(\'' + p.planId + '\')">❌ 驳回</button><button class="btn btn-outline btn-sm" onclick="loadPage(\'${pageContext.request.contextPath}/purchase/planEdit?planId=' + p.planId + '\')">✏️ 编辑</button><button class="btn btn-danger btn-sm" onclick="deletePlan(\'' + p.planId + '\')">🗑️ 删除</button>' : '<span class="tag tag-gray">已处理</span>') +
                        '</td></tr>';
                });
                if (res.data.length === 0) html = '<tr><td colspan="8"><div class="empty-state"><div class="empty-icon">📭</div><p>暂无数据</p></div></td></tr>';
                document.getElementById('planTableBody').innerHTML = html;
                XINAI.pagination.render('planPagination', res.count, currentPage, 10, function(p) { currentPage = p; loadPlans(); });
            }
        });
    }
    function approvePlan(id) { XINAI.util.confirm('确定审批通过该计划？', function() { XINAI.ajax.put('${pageContext.request.contextPath}/purchase/plan/approve/' + id, {}, function(res) { if(res&&res.code===0){alert('已审批通过');loadPlans();}else alert(res.msg); }); }); }
    function rejectPlan(id) { XINAI.util.confirm('确定驳回该计划？', function() { XINAI.ajax.put('${pageContext.request.contextPath}/purchase/plan/reject/' + id, {}, function(res) { if(res&&res.code===0){alert('已驳回');loadPlans();}else alert(res.msg); }); }); }
    function deletePlan(id) { XINAI.util.confirm('确定删除？', function() { XINAI.ajax.del('${pageContext.request.contextPath}/purchase/plan/delete/' + id, function(res) { if(res&&res.code===0){alert('已删除');loadPlans();}else alert(res.msg); }); }); }
    loadPlans();
</script>
