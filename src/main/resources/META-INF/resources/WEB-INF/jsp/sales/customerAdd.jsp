<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card"><div class="card-header"><h3>新增客户</h3></div>
<div class="card-body">
    <div class="form-row"><div class="form-group"><label>客户名称 <span style="color:red;">*</span></label><input type="text" class="form-control" id="name"></div><div class="form-group"><label>对接人</label><input type="text" class="form-control" id="contact"></div></div>
    <div class="form-row"><div class="form-group"><label>联系电话</label><input type="text" class="form-control" id="phone"></div><div class="form-group"><label>地址</label><input type="text" class="form-control" id="address"></div></div>
    <div class="form-group"><label>备注</label><textarea class="form-control" id="remark"></textarea></div>
    <div class="form-actions"><button class="btn btn-primary" onclick="submitForm()">保存</button><button class="btn btn-outline" onclick="history.back()">取消</button></div>
</div></div>
<script>
    function submitForm() {
        var name = document.getElementById('name').value.trim(); if(!name){alert('请输入客户名称');return;}
        XINAI.ajax.post('${pageContext.request.contextPath}/sales/customer/add', {customerName:name,contactPerson:document.getElementById('contact').value,contactPhone:document.getElementById('phone').value,address:document.getElementById('address').value,remark:document.getElementById('remark').value}, function(res) { if(res&&res.code===0){alert('新增成功');loadPage('${pageContext.request.contextPath}/sales/customerList');} else alert(res.msg); });
    }
</script>
