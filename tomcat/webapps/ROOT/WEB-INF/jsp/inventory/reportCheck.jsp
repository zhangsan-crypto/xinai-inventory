<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card"><div class="card-header"><h3>库存盘点报表</h3><button class="btn btn-primary btn-sm" onclick="exportExcel()">📥 导出Excel</button></div>
<div class="card-body">
    <div class="filter-bar"><input type="date" class="form-control" id="startDate"><input type="date" class="form-control" id="endDate"><button class="btn btn-primary btn-sm" onclick="load()">🔍 查询</button></div>
    <table class="data-table"><thead><tr><th>盘点单号</th><th>材料名称</th><th>账面数量</th><th>实际数量</th><th>差异</th><th>差异原因</th><th>盘点日期</th><th>状态</th></tr></thead><tbody id="tb"></tbody></table>
</div></div>
<script>
    function load(){XINAI.ajax.get('${pageContext.request.contextPath}/inventory/report/checkSummary',{startDate:document.getElementById('startDate').value,endDate:document.getElementById('endDate').value},function(res){
        if(res&&res.code===0){var h='';res.data.forEach(function(r){h+='<tr><td><code class="user-id dept-03">'+(r.check_id||'')+'</code></td><td><strong>'+(r.material_name||'')+'</strong></td><td>'+(r.book_qty||0)+'</td><td>'+(r.actual_qty||0)+'</td><td>'+XINAI.util.getDiffTag((r.diff_qty||0))+'</td><td>'+(r.diff_reason||'-')+'</td><td>'+XINAI.util.formatDate(r.check_date)+'</td><td>'+XINAI.util.getStatusTag(r.approval_status)+'</td></tr>';});
            if(res.data.length===0)h='<tr><td colspan="8"><div class="empty-state"><div class="empty-icon">📭</div><p>暂无数据</p></div></td></tr>';document.getElementById('tb').innerHTML=h;}
    });}
    function exportExcel(){var html='<html><meta charset="utf-8"><body><table border="1"><thead><tr><th>盘点单号</th><th>材料</th><th>账面</th><th>实际</th><th>差异</th><th>原因</th><th>日期</th><th>状态</th></tr></thead>';var rows=document.getElementById('tb').querySelectorAll('tr');rows.forEach(function(r){if(!r.querySelector('.empty-state')){html+='<tr>';r.querySelectorAll('td').forEach(function(td){html+='<td>'+td.textContent.trim()+'</td>';});html+='</tr>';}});html+='</table></body></html>';
        var blob=new Blob([html],{type:'application/vnd.ms-excel'});var a=document.createElement('a');a.href=URL.createObjectURL(blob);a.download='盘点报表.xls';a.click();}
    load();
</script>
