<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card"><div class="card-header"><h3>新增供应商</h3></div>
<div class="card-body">
    <div class="form-row">
        <div class="form-group"><label>供应商名称 <span style="color:red;">*</span></label><input type="text" class="form-control" id="supplierName"></div>
        <div class="form-group"><label>联系人</label><input type="text" class="form-control" id="contactPerson"></div>
    </div>
    <div class="form-row">
        <div class="form-group"><label>联系电话</label><input type="text" class="form-control" id="contactPhone"></div>
        <div class="form-group"><label>主营材料</label><input type="text" class="form-control" id="mainMaterial"></div>
    </div>
    <div class="form-group"><label>地址</label><input type="text" class="form-control" id="address"></div>
    <div class="form-group"><label>备注</label><textarea class="form-control" id="remark"></textarea></div>
    <div class="form-actions">
        <button class="btn btn-primary" onclick="submitForm()">保存</button>
        <button class="btn btn-outline" onclick="history.back()">取消</button>
    </div>
</div></div>
<script>
    function submitForm() {
        var name = document.getElementById('supplierName').value.trim();
        if (!name) { alert('请输入供应商名称'); return; }
        XINAI.ajax.post('${pageContext.request.contextPath}/purchase/supplier/add', {
            supplierName: name, contactPerson: document.getElementById('contactPerson').value,
            contactPhone: document.getElementById('contactPhone').value, mainMaterial: document.getElementById('mainMaterial').value,
            address: document.getElementById('address').value, remark: document.getElementById('remark').value
        }, function(res) { if (res && res.code === 0) { alert('新增成功'); loadPage('${pageContext.request.contextPath}/purchase/supplierList'); } else alert(res.msg); });
    }
</script>
