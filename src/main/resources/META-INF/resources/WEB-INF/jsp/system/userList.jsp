<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card">
    <div class="card-header">
        <h3>用户管理</h3>
        <div>
            <button class="btn btn-primary btn-sm" onclick="showAddUser()">＋ 新增用户</button>
        </div>
    </div>
    <div class="card-body">
        <div class="filter-bar">
            <select class="form-control" id="filterDept" onchange="loadUsers()">
                <option value="">全部部门</option>
                <option value="01">采购部</option>
                <option value="02">销售部</option>
                <option value="03">仓储部</option>
                <option value="04">行政部</option>
                <option value="05">财务部</option>
            </select>
            <select class="form-control" id="filterPost" onchange="loadUsers()">
                <option value="">全部岗位</option>
                <option value="01">采购人员</option>
                <option value="02">销售人员</option>
                <option value="03">仓库人员</option>
                <option value="04">管理员</option>
                <option value="05">财务人员</option>
            </select>
            <select class="form-control" id="filterStatus" onchange="loadUsers()">
                <option value="">全部状态</option>
                <option value="0">启用</option>
                <option value="1">禁用</option>
            </select>
            <input type="text" class="form-control" id="filterKeyword" placeholder="搜索账号/姓名" style="min-width:180px;">
            <button class="btn btn-primary btn-sm" onclick="loadUsers()">🔍 搜索</button>
        </div>
        <table class="data-table">
            <thead>
                <tr>
                    <th>用户账号</th>
                    <th>用户姓名</th>
                    <th>部门</th>
                    <th>岗位</th>
                    <th>角色</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody id="userTableBody"></tbody>
        </table>
        <div id="userPagination"></div>
    </div>
</div>
<script>
    var currentPage = 1;
    function loadUsers() {
        var params = {
            page: currentPage,
            limit: 10,
            deptCode: document.getElementById('filterDept').value,
            postCode: document.getElementById('filterPost').value,
            status: document.getElementById('filterStatus').value,
            keyword: document.getElementById('filterKeyword').value
        };
        XINAI.ajax.get('${pageContext.request.contextPath}/system/user/list', params, function(res) {
            if (res && res.code === 0) {
                var html = '';
                res.data.forEach(function(u) {
                    html += '<tr>' +
                        '<td>' + XINAI.util.getUserIdHtml(u.userId, u.deptCode) + '</td>' +
                        '<td><strong>' + u.username + '</strong></td>' +
                        '<td>' + u.deptName + '</td>' +
                        '<td>' + u.postName + '</td>' +
                        '<td>' + u.roleName + '</td>' +
                        '<td>' + XINAI.util.getStatusTag(u.status, 'user') + '</td>' +
                        '<td class="operation">' +
                        '<button class="btn btn-outline btn-sm" onclick="editUser(\'' + u.userId + '\')">✏️ 编辑</button>' +
                        '<button class="btn btn-outline btn-sm" onclick="resetPwd(\'' + u.userId + '\')">🔑 重置密码</button>' +
                        '<button class="btn btn-danger btn-sm" onclick="deleteUser(\'' + u.userId + '\')">🗑️ 删除</button>' +
                        '</td></tr>';
                });
                if (res.data.length === 0) {
                    html = '<tr><td colspan="7"><div class="empty-state"><div class="empty-icon">📭</div><p>暂无数据</p></div></td></tr>';
                }
                document.getElementById('userTableBody').innerHTML = html;
                XINAI.pagination.render('userPagination', res.count, currentPage, 10, function(p) { currentPage = p; loadUsers(); });
            }
        });
    }

    function showAddUser() {
        loadPage('${pageContext.request.contextPath}/system/userAdd');
    }

    function editUser(id) {
        loadPage('${pageContext.request.contextPath}/system/userEdit?userId=' + id);
    }

    function deleteUser(id) {
        XINAI.util.confirm('确定删除用户 ' + id + ' 吗？', function() {
            XINAI.ajax.del('${pageContext.request.contextPath}/system/user/delete/' + id, function(res) {
                if (res && res.code === 0) { alert('删除成功'); loadUsers(); }
                else { alert(res ? res.msg : '删除失败'); }
            });
        });
    }

    function resetPwd(id) {
        XINAI.util.confirm('确定重置该用户密码为123456吗？', function() {
            XINAI.ajax.put('${pageContext.request.contextPath}/system/user/resetPassword/' + id, {}, function(res) {
                if (res && res.code === 0) { alert('密码已重置为123456'); }
                else { alert(res ? res.msg : '重置失败'); }
            });
        });
    }

    loadUsers();
</script>
