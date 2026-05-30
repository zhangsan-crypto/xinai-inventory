<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card"><div class="card-header"><h3>编辑材料</h3></div>
<div class="card-body">
    <input type="hidden" id="mid" value="${materialId}">
    <div class="form-group"><label>材料编号</label><input type="text" class="form-control" id="showId" readonly></div>
    <div class="form-row"><div class="form-group"><label>材料名称</label><input type="text" class="form-control" id="editName"></div><div class="form-group"><label>规格型号</label><input type="text" class="form-control" id="editSpec"></div></div>
    <div class="form-row"><div class="form-group"><label>计量单位</label><input type="text" class="form-control" id="editUnit"></div><div class="form-group"><label>参考单价</label><input type="number" step="0.01" class="form-control" id="editPrice"></div></div>
    <div class="form-row"><div class="form-group"><label>安全库存下限</label><input type="number" class="form-control" id="editLower"></div><div class="form-group"><label>安全库存上限</label><input type="number" class="form-control" id="editUpper"></div></div>
    <div class="form-actions"><button class="btn btn-primary" onclick="update()">保存修改</button><button class="btn btn-outline" onclick="history.back()">取消</button></div>
</div></div>
<script>
    var mid=document.getElementById('mid').value;
    XINAI.ajax.get('${pageContext.request.contextPath}/inventory/material/'+mid,{},function(res){if(res&&res.code===0&&res.data){var d=res.data;document.getElementById('showId').value=d.materialId;document.getElementById('editName').value=d.materialName||'';document.getElementById('editSpec').value=d.specModel||'';document.getElementById('editUnit').value=d.unit||'';document.getElementById('editPrice').value=d.refPrice||0;document.getElementById('editLower').value=d.safetyLower||0;document.getElementById('editUpper').value=d.safetyUpper||0;}});
    function update(){XINAI.ajax.put('${pageContext.request.contextPath}/inventory/material/update',{materialId:mid,materialName:document.getElementById('editName').value,specModel:document.getElementById('editSpec').value,unit:document.getElementById('editUnit').value,refPrice:parseFloat(document.getElementById('editPrice').value)||0,safetyLower:parseInt(document.getElementById('editLower').value)||0,safetyUpper:parseInt(document.getElementById('editUpper').value)||0},function(res){if(res&&res.code===0){alert('修改成功');loadPage('${pageContext.request.contextPath}/inventory/materialList');} else alert(res.msg);});}
</script>
