<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card">
    <div class="card-header"><h3>新增用户</h3></div>
    <div class="card-body">
        <div class="form-row">
            <div class="form-group">
                <label>所属部门</label>
                <select class="form-control" id="deptCode" onchange="previewUserId()">
                    <option value="">请选择</option>
                    <option value="01">采购部</option>
                    <option value="02">销售部</option>
                    <option value="03">仓储部</option>
                    <option value="04">行政部</option>
                    <option value="05">财务部</option>
                </select>
            </div>
            <div class="form-group">
                <label>岗位</label>
                <select class="form-control" id="postCode" onchange="previewUserId()">
                    <option value="">请选择</option>
                    <option value="01">采购人员</option>
                    <option value="02">销售人员</option>
                    <option value="03">仓库人员</option>
                    <option value="04">管理员</option>
                    <option value="05">财务人员</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label>用户姓名</label>
            <input type="text" class="form-control" id="username" placeholder="请输入用户姓名">
        </div>
        <div class="form-group">
            <label>登录密码</label>
            <input type="text" class="form-control" id="password" value="123456" placeholder="默认为123456">
        </div>
        <div class="form-group">
            <label>用户账号预览</label>
            <div class="code-preview" id="codePreview">选择部门和岗位后自动生成</div>
        </div>
        <div class="form-actions">
            <button class="btn btn-primary" onclick="submitUser()">保存</button>
            <button class="btn btn-outline" onclick="history.back()">取消</button>
        </div>
    </div>
</div>
<script>
    function previewUserId() {
        var dept = document.getElementById('deptCode').value;
        var post = document.getElementById('postCode').value;
        if (dept && post) {
            document.getElementById('codePreview').textContent = 'YH' + dept + post + 'XX';
        } else {
            document.getElementById('codePreview').textContent = '选择部门和岗位后自动生成';
        }
    }

    function submitUser() {
        var deptCode = document.getElementById('deptCode').value;
        var postCode = document.getElementById('postCode').value;
        var username = document.getElementById('username').value.trim();
        var password = document.getElementById('password').value;

        if (!deptCode || !postCode) { alert('请选择部门和岗位'); return; }
        if (!username) { alert('请输入用户姓名'); return; }

        var data = { deptCode: deptCode, postCode: postCode, username: username, password: password };
        XINAI.ajax.post('${pageContext.request.contextPath}/system/user/add', data, function(res) {
            if (res && res.code === 0) {
                alert('新增成功！用户账号: ' + (res.data ? res.data.userId : ''));
                loadPage('${pageContext.request.contextPath}/system/userList');
            } else {
                alert(res ? res.msg : '新增失败');
            }
        });
    }
</script>
