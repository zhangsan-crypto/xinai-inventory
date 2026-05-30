<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card">
    <div class="card-header"><h3>编辑用户</h3></div>
    <div class="card-body">
        <input type="hidden" id="editUserId" value="${userId}">
        <div class="form-row">
            <div class="form-group">
                <label>用户账号</label>
                <input type="text" class="form-control" id="showUserId" readonly>
            </div>
            <div class="form-group">
                <label>用户姓名</label>
                <input type="text" class="form-control" id="editUsername" placeholder="请输入用户姓名">
            </div>
        </div>
        <div class="form-row">
            <div class="form-group">
                <label>部门</label>
                <select class="form-control" id="editDept">
                    <option value="01">采购部</option>
                    <option value="02">销售部</option>
                    <option value="03">仓储部</option>
                    <option value="04">行政部</option>
                    <option value="05">财务部</option>
                </select>
            </div>
            <div class="form-group">
                <label>岗位</label>
                <select class="form-control" id="editPost">
                    <option value="01">采购人员</option>
                    <option value="02">销售人员</option>
                    <option value="03">仓库人员</option>
                    <option value="04">管理员</option>
                    <option value="05">财务人员</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label>状态</label>
            <select class="form-control" id="editStatus">
                <option value="0">启用</option>
                <option value="1">禁用</option>
            </select>
        </div>
        <div class="form-actions">
            <button class="btn btn-primary" onclick="updateUser()">保存修改</button>
            <button class="btn btn-outline" onclick="loadPage('${pageContext.request.contextPath}/system/userList')">取消</button>
        </div>
    </div>
</div>
<script>
    var userId = document.getElementById('editUserId').value;
    XINAI.ajax.get('${pageContext.request.contextPath}/system/user/' + userId, {}, function(res) {
        if (res && res.code === 0 && res.data) {
            var u = res.data;
            document.getElementById('showUserId').value = u.userId;
            document.getElementById('editUsername').value = u.username || '';
            document.getElementById('editDept').value = u.deptCode || '01';
            document.getElementById('editPost').value = u.postCode || '01';
            document.getElementById('editStatus').value = u.status || '0';
        }
    });

    function updateUser() {
        var data = {
            userId: userId,
            username: document.getElementById('editUsername').value.trim(),
            deptCode: document.getElementById('editDept').value,
            postCode: document.getElementById('editPost').value,
            status: document.getElementById('editStatus').value,
            role: document.getElementById('editPost').value === '01' ? 'purchase' : document.getElementById('editPost').value === '02' ? 'sale' : document.getElementById('editPost').value === '03' ? 'warehouse' : 'admin'
        };
        if (!data.username) { alert('请输入用户姓名'); return; }
        XINAI.ajax.put('${pageContext.request.contextPath}/system/user/update', data, function(res) {
            if (res && res.code === 0) { alert('修改成功'); loadPage('${pageContext.request.contextPath}/system/userList'); }
            else { alert(res ? res.msg : '修改失败'); }
        });
    }
</script>
