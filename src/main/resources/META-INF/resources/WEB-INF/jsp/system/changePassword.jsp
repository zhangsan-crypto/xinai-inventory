<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card" style="max-width:500px;margin:0 auto;">
    <div class="card-header"><h3>修改密码</h3></div>
    <div class="card-body">
        <div class="form-group">
            <label>原密码</label>
            <input type="password" class="form-control" id="oldPwd" placeholder="请输入原密码">
        </div>
        <div class="form-group">
            <label>新密码</label>
            <input type="password" class="form-control" id="newPwd" placeholder="请输入新密码">
        </div>
        <div class="form-group">
            <label>确认新密码</label>
            <input type="password" class="form-control" id="confirmPwd" placeholder="请再次输入新密码">
        </div>
        <div class="form-actions">
            <button class="btn btn-primary" onclick="changePwd()">确认修改</button>
            <button class="btn btn-outline" onclick="loadPage('${pageContext.request.contextPath}/main')">取消</button>
        </div>
    </div>
</div>
<script>
    function changePwd() {
        var oldPwd = document.getElementById('oldPwd').value;
        var newPwd = document.getElementById('newPwd').value;
        var confirmPwd = document.getElementById('confirmPwd').value;
        if (!oldPwd || !newPwd) { alert('请填写完整'); return; }
        if (newPwd !== confirmPwd) { alert('两次密码输入不一致'); return; }
        if (newPwd.length < 6) { alert('密码长度至少6位'); return; }
        XINAI.ajax.put('${pageContext.request.contextPath}/system/user/changePassword', {oldPwd: oldPwd, newPwd: newPwd}, function(res) {
            if (res && res.code === 0) { alert('密码修改成功！'); }
            else { alert(res ? res.msg : '修改失败'); }
        });
    }
</script>
