<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card"><div class="card-header"><h3>新增材料</h3></div>
<div class="card-body">
    <div class="form-group"><label>材料编号预览</label><div class="code-preview" id="codePreview">选择大类后自动生成</div></div>
    <div class="form-row">
        <div class="form-group"><label>材料大类 <span style="color:red;">*</span></label><select class="form-control" id="categoryCode" onchange="previewCode()"><option value="">请选择</option><option value="01">钢筋</option><option value="02">水泥</option><option value="03">砂石</option><option value="04">砖</option><option value="05">木材</option><option value="06">防水材料</option></select></div>
        <div class="form-group"><label>规格编码</label><input type="text" class="form-control" id="specCode" value="01" onchange="previewCode()"></div>
    </div>
    <div class="form-row">
        <div class="form-group"><label>材料名称 <span style="color:red;">*</span></label><input type="text" class="form-control" id="materialName"></div>
        <div class="form-group"><label>规格型号</label><input type="text" class="form-control" id="specModel"></div>
    </div>
    <div class="form-row">
        <div class="form-group"><label>计量单位</label><input type="text" class="form-control" id="unit" placeholder="如: 吨、立方米、千块"></div>
        <div class="form-group"><label>参考单价</label><input type="number" step="0.01" class="form-control" id="refPrice"></div>
    </div>
    <div class="form-row">
        <div class="form-group"><label>安全库存下限</label><input type="number" class="form-control" id="safetyLower"></div>
        <div class="form-group"><label>安全库存上限</label><input type="number" class="form-control" id="safetyUpper"></div>
    </div>
    <div class="form-actions"><button class="btn btn-primary" onclick="submitForm()">保存</button><button class="btn btn-outline" onclick="history.back()">取消</button></div>
</div></div>
<script>
    function previewCode(){var cat=document.getElementById('categoryCode').value;var spec=document.getElementById('specCode').value||'01';if(cat)document.getElementById('codePreview').textContent='CL'+cat+spec+'XXXX';else document.getElementById('codePreview').textContent='选择大类后自动生成';}
    function submitForm(){var cat=document.getElementById('categoryCode').value;var name=document.getElementById('materialName').value.trim();if(!cat){alert('请选择材料大类');return;}if(!name){alert('请输入材料名称');return;}
        XINAI.ajax.post('${pageContext.request.contextPath}/inventory/material/add',{categoryCode:cat,specCode:document.getElementById('specCode').value||'01',materialName:name,specModel:document.getElementById('specModel').value,unit:document.getElementById('unit').value,refPrice:parseFloat(document.getElementById('refPrice').value)||0,safetyLower:parseInt(document.getElementById('safetyLower').value)||0,safetyUpper:parseInt(document.getElementById('safetyUpper').value)||0},function(res){if(res&&res.code===0){alert('新增成功！编号: '+(res.data?res.data.materialId:''));loadPage('${pageContext.request.contextPath}/inventory/materialList');} else alert(res.msg);});}
</script>
