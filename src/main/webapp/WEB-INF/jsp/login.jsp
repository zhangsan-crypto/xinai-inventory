<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>鑫爱建筑进销存管理信息系统 - 登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="login-wrapper">
        <div class="login-card">
            <div class="logo">
                <h1>鑫爱建筑</h1>
                <p>进销存管理信息系统</p>
            </div>
            <form id="loginForm" onsubmit="return doLogin()">
                <div class="form-group">
                    <label for="userId">用户账号</label>
                    <input type="text" id="userId" class="form-control" placeholder="请输入用户账号 (如 YH040401)" required>
                </div>
                <div class="form-group">
                    <label for="password">登录密码</label>
                    <input type="password" id="password" class="form-control" placeholder="请输入登录密码" required>
                </div>
                <button type="submit" class="btn-submit" id="loginBtn">登 录</button>
                <div class="error-msg" id="errorMsg"></div>
            </form>
            <div style="text-align:center;margin-top:24px;padding-top:20px;border-top:1px solid #e2e8f0;font-size:12px;color:#94a3b8;">
                <p style="margin-bottom:4px;">初始账号: YH040401 / 123456 (管理员)</p>
                <p>YH010101 (采购) | YH020201 (销售) | YH030301 (仓库)</p>
            </div>
        </div>
    </div>
    <script>
        function doLogin() {
            var userId = document.getElementById('userId').value.trim();
            var password = document.getElementById('password').value;
            var btn = document.getElementById('loginBtn');
            if (!userId || !password) {
                showError('请输入账号和密码');
                return false;
            }
            btn.disabled = true;
            btn.textContent = '登录中...';
            var xhr = new XMLHttpRequest();
            xhr.open('POST', '${pageContext.request.contextPath}/system/login', true);
            xhr.setRequestHeader('Content-Type', 'application/json');
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    btn.disabled = false;
                    btn.textContent = '登 录';
                    if (xhr.status === 200) {
                        try {
                            var res = JSON.parse(xhr.responseText);
                            if (res.code === 0) {
                                window.location.href = '${pageContext.request.contextPath}/main';
                            } else {
                                showError(res.msg || '登录失败');
                            }
                        } catch(e) {
                            showError('系统错误');
                        }
                    } else {
                        showError('请求失败，请检查网络');
                    }
                }
            };
            xhr.send(JSON.stringify({userId: userId, password: password}));
            return false;
        }
        function showError(msg) {
            var el = document.getElementById('errorMsg');
            el.textContent = msg;
            el.style.display = 'block';
        }
        document.getElementById('userId').addEventListener('keydown', function(e) { if (e.key === 'Enter') document.getElementById('password').focus(); });
        document.getElementById('password').addEventListener('keydown', function(e) { if (e.key === 'Enter') document.getElementById('loginForm').dispatchEvent(new Event('submit')); });
    </script>
</body>
</html>
