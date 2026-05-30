<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card"><div class="card-header"><h3>出入库汇总报表</h3><button class="btn btn-primary btn-sm" onclick="exportExcel()">📥 导出Excel</button></div>
<div class="card-body">
    <div class="filter-bar">
        <input type="date" class="form-control" id="startDate"><input type="date" class="form-control" id="endDate">
        <button class="btn btn-primary btn-sm" onclick="load()">🔍 查询</button>
    </div>
    <table class="data-table"><thead><tr><th>类型</th><th>日期</th><th>笔数</th><th>总数量</th></tr></thead><tbody id="tb"></tbody></table>
</div></div>
<script>
    function load(){XINAI.ajax.get('${pageContext.request.contextPath}/inventory/report/inoutSummary',{startDate:document.getElementById('startDate').value,endDate:document.getElementById('endDate').value},function(res){
        if(res&&res.code===0){var h='';res.data.forEach(function(r){h+='<tr><td>'+(r.type||'')+'</td><td>'+(r.date||'')+'</td><td>'+(r.count||0)+'</td><td>'+(r.total_qty||0)+'</td></tr>';});
            if(res.data.length===0)h='<tr><td colspan="4"><div class="empty-state"><div class="empty-icon">📭</div><p>暂无数据</p></div></td></tr>';document.getElementById('tb').innerHTML=h;}
    });}
    function exportExcel(){var html='<html><meta charset="utf-8"><body><table border="1"><thead><tr><th>类型</th><th>日期</th><th>笔数</th><th>总数量</th></tr></thead>';var rows=document.getElementById('tb').querySelectorAll('tr');rows.forEach(function(r){if(!r.querySelector('.empty-state')){html+='<tr>';r.querySelectorAll('td').forEach(function(td){html+='<td>'+td.textContent.trim()+'</td>';});html+='</tr>';}});html+='</table></body></html>';
        var blob=new Blob([html],{type:'application/vnd.ms-excel'});var a=document.createElement('a');a.href=URL.createObjectURL(blob);a.download='出入库汇总报表.xls';a.click();}
    load();
</script>
