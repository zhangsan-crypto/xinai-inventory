<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card"><div class="card-header"><h3>库存台账报表</h3><button class="btn btn-primary btn-sm" onclick="exportExcel()">📥 导出Excel</button></div>
<div class="card-body">
    <div class="filter-bar"><input type="text" class="form-control" id="keyword" placeholder="搜索材料名称"><button class="btn btn-primary btn-sm" onclick="load()">🔍 查询</button></div>
    <table class="data-table"><thead><tr><th>材料编号</th><th>材料名称</th><th>规格型号</th><th>当前库存</th><th>单位</th><th>参考单价</th><th>库存金额</th><th>最近入库</th><th>最近出库</th></tr></thead><tbody id="tb"></tbody></table>
</div></div>
<script>
    function load(){XINAI.ajax.get('${pageContext.request.contextPath}/inventory/report/ledger',{keyword:document.getElementById('keyword').value},function(res){
        if(res&&res.code===0){var h='';res.data.forEach(function(r){h+='<tr><td><code class="user-id dept-01">'+(r.material_id||'')+'</code></td><td><strong>'+(r.material_name||'')+'</strong></td><td>'+(r.spec_model||'-')+'</td><td><strong>'+(r.current_qty||0)+'</strong></td><td>'+(r.unit||'-')+'</td><td>¥'+(r.ref_price||0).toFixed(2)+'</td><td><strong>¥'+(r.total_value||0).toFixed(2)+'</strong></td><td>'+(r.last_inbound_date?XINAI.util.formatDate(r.last_inbound_date):'-')+'</td><td>'+(r.last_outbound_date?XINAI.util.formatDate(r.last_outbound_date):'-')+'</td></tr>';});
            if(res.data.length===0)h='<tr><td colspan="9"><div class="empty-state"><div class="empty-icon">📭</div><p>暂无数据</p></div></td></tr>';document.getElementById('tb').innerHTML=h;}
    });}
    function exportExcel(){var html='<html><head><meta charset="utf-8"><title>库存台账</title></head><body><table border="1"><thead><tr><th>材料编号</th><th>材料名称</th><th>规格型号</th><th>库存数量</th><th>单位</th><th>单价</th><th>金额</th></tr></thead>';var rows=document.getElementById('tb').querySelectorAll('tr');rows.forEach(function(r){if(!r.querySelector('.empty-state')){html+='<tr>';r.querySelectorAll('td').forEach(function(td){html+='<td>'+td.textContent.trim()+'</td>';});html+='</tr>';}});html+='</table></body></html>';
        var blob=new Blob([html],{type:'application/vnd.ms-excel'});var a=document.createElement('a');a.href=URL.createObjectURL(blob);a.download='库存台账报表.xls';a.click();}
    load();
</script>
