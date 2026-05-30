<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card">
    <div class="card-header"><h3>编辑供应商</h3></div>
    <div class="card-body">
        <input type="hidden" id="editId" value="${supplierId}">
        <div class="form-row">
            <div class="form-group"><label>供应商名称</label><input type="text" class="form-control" id="editName"></div>
            <div class="form-group"><label>联系人</label><input type="text" class="form-control" id="editContact"></div>
        </div>
        <div class="form-row">
            <div class="form-group"><label>联系电话</label><input type="text" class="form-control" id="editPhone"></div>
            <div class="form-group"><label>主营材料</label><input type="text" class="form-control" id="editMaterial"></div>
        </div>
        <div class="form-group"><label>合作状态</label><select class="form-control" id="editStatus"><option value="0">合作中</option><option value="1">已停止</option></select></div>
        <div class="form-group"><label>地址</label><input type="text" class="form-control" id="editAddress"></div>
        <div class="form-group"><label>备注</label><textarea class="form-control" id="editRemark"></textarea></div>
        <div class="form-actions">
            <button class="btn btn-primary" onclick="updateSupplier()">保存修改</button>
            <button class="btn btn-outline" onclick="history.back()">取消</button>
        </div>
    </div>
</div>
<script>
    var id = document.getElementById('editId').value;
    XINAI.ajax.get('${pageContext.request.contextPath}/purchase/supplier/' + id, {}, function(res) {
        if (res && res.code === 0 && res.data) {
            var d = res.data;
            document.getElementById('editName').value = d.supplierName||'';
            document.getElementById('editContact').value = d.contactPerson||'';
            document.getElementById('editPhone').value = d.contactPhone||'';
            document.getElementById('editMaterial').value = d.mainMaterial||'';
            document.getElementById('editAddress').value = d.address||'';
            document.getElementById('editRemark').value = d.remark||'';
            document.getElementById('editStatus').value = d.cooperationStatus||'0';
        }
    });
    function updateSupplier() {
        XINAI.ajax.put('${pageContext.request.contextPath}/purchase/supplier/update', {
            supplierId: parseInt(id), supplierName: document.getElementById('editName').value,
            contactPerson: document.getElementById('editContact').value, contactPhone: document.getElementById('editPhone').value,
            mainMaterial: document.getElementById('editMaterial').value, cooperationStatus: document.getElementById('editStatus').value,
            address: document.getElementById('editAddress').value, remark: document.getElementById('editRemark').value
        }, function(res) { if (res && res.code === 0) { alert('修改成功'); loadPage('${pageContext.request.contextPath}/purchase/supplierList'); } else alert(res.msg); });
    }
</script>
