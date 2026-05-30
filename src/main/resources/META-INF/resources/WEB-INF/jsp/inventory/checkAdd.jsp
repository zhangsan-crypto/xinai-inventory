<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card"><div class="card-header"><h3>新增库存盘点</h3></div>
<div class="card-body">
    <div class="form-group"><label>盘点单号</label><div class="code-preview">自动生成：PD + 年份(4位) + 月份(2位) + 序号(4位)</div></div>
    <div class="form-row">
        <div class="form-group"><label>选择材料 <span style="color:red;">*</span></label><select class="form-control" id="materialId" onchange="onMatChange()"><option value="">请选择</option></select></div>
        <div class="form-group"><label>盘点日期</label><input type="date" class="form-control" id="checkDate"></div>
    </div>
    <div class="form-row">
        <div class="form-group"><label>账面数量</label><input type="text" class="form-control" id="bookQty" readonly></div>
        <div class="form-group"><label>实际数量 <span style="color:red;">*</span></label><input type="number" class="form-control" id="actualQty" onchange="calcDiff()"></div>
    </div>
    <div class="form-group"><label>差异数量</label><input type="text" class="form-control" id="diffQty" readonly></div>
    <div class="form-group"><label>差异原因</label><textarea class="form-control" id="diffReason"></textarea></div>
    <div class="form-actions"><button class="btn btn-primary" onclick="submitForm()">提交盘点</button><button class="btn btn-outline" onclick="history.back()">取消</button></div>
</div></div>
<script>
    document.getElementById('checkDate').value=new Date().toISOString().slice(0,10);
    XINAI.ajax.get('${pageContext.request.contextPath}/inventory/material/all',{},function(res){if(res&&res.code===0){var sel=document.getElementById('materialId');res.data.forEach(function(m){sel.innerHTML+='<option value="'+m.materialId+'" data-name="'+m.materialName+'" data-spec="'+(m.specModel||'')+'">'+m.materialId+' - '+m.materialName+'</option>';});}});
    function onMatChange(){var opt=document.getElementById('materialId').options[document.getElementById('materialId').selectedIndex];if(opt.value){XINAI.ajax.get('${pageContext.request.contextPath}/inventory/inventory/'+opt.value,{},function(res2){if(res2&&res2.code===0&&res2.data){document.getElementById('bookQty').value=res2.data.currentQty;}});}}
    function calcDiff(){var book=parseInt(document.getElementById('bookQty').value)||0;var actual=parseInt(document.getElementById('actualQty').value)||0;document.getElementById('diffQty').value=actual-book;}
    function submitForm(){var sel=document.getElementById('materialId');var opt=sel.options[sel.selectedIndex];var actual=parseInt(document.getElementById('actualQty').value);if(!opt.value){alert('请选择材料');return;}if(isNaN(actual)){alert('请输入实际数量');return;}
        XINAI.ajax.post('${pageContext.request.contextPath}/inventory/check/add',{materialId:opt.value,materialName:opt.dataset.name,bookQty:parseInt(document.getElementById('bookQty').value)||0,actualQty:actual,diffReason:document.getElementById('diffReason').value,checkDate:document.getElementById('checkDate').value},function(res){if(res&&res.code===0){alert('盘点单提交成功！编号: '+(res.data?res.data.checkId:''));loadPage('${pageContext.request.contextPath}/inventory/checkList');} else alert(res.msg);});}
</script>
