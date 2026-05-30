<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    com.xinai.inventory.entity.SysUser user = (com.xinai.inventory.entity.SysUser) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
    pageContext.setAttribute("cu", user);
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>鑫爱建筑进销存管理信息系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="admin-wrapper">
    <!-- 侧边栏 -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <h2>鑫爱建筑</h2>
            <p>进销存管理信息系统</p>
        </div>
        <nav class="sidebar-menu" id="sidebarMenu">
            <div class="menu-section">概览</div>
            <a class="menu-item active" href="${pageContext.request.contextPath}/main" target="contentFrame" onclick="return navigate(this)">
                <span class="icon">📊</span> 首页Dashboard
            </a>
            <c:if test="${cu.role == 'admin'}">
                <div class="menu-section">系统管理</div>
                <a class="menu-item" href="${pageContext.request.contextPath}/system/userList" target="contentFrame" onclick="return navigate(this)">
                    <span class="icon">👤</span> 用户管理
                </a>
                <a class="menu-item" href="${pageContext.request.contextPath}/system/changePassword" target="contentFrame" onclick="return navigate(this)">
                    <span class="icon">🔑</span> 密码修改
                </a>
                <a class="menu-item" href="${pageContext.request.contextPath}/system/permissionList" target="contentFrame" onclick="return navigate(this)">
                    <span class="icon">🔐</span> 权限管理
                </a>
            </c:if>
            <c:if test="${cu.role == 'purchase' || cu.role == 'admin'}">
                <div class="menu-section">采购管理</div>
                <a class="menu-item" href="${pageContext.request.contextPath}/purchase/planList" target="contentFrame" onclick="return navigate(this)">
                    <span class="icon">📋</span> 采购计划管理
                </a>
                <a class="menu-item" href="${pageContext.request.contextPath}/purchase/inboundList" target="contentFrame" onclick="return navigate(this)">
                    <span class="icon">📦</span> 采购入库管理
                </a>
                <a class="menu-item" href="${pageContext.request.contextPath}/purchase/supplierList" target="contentFrame" onclick="return navigate(this)">
                    <span class="icon">🏢</span> 供应商信息管理
                </a>
                <a class="menu-item" href="${pageContext.request.contextPath}/purchase/returnList" target="contentFrame" onclick="return navigate(this)">
                    <span class="icon">↩️</span> 采购退货管理
                </a>
            </c:if>
            <c:if test="${cu.role == 'sale' || cu.role == 'admin'}">
                <div class="menu-section">销售管理</div>
                <a class="menu-item" href="${pageContext.request.contextPath}/sales/orderList" target="contentFrame" onclick="return navigate(this)">
                    <span class="icon">📝</span> 销售订单管理
                </a>
                <a class="menu-item" href="${pageContext.request.contextPath}/sales/outboundList" target="contentFrame" onclick="return navigate(this)">
                    <span class="icon">🚚</span> 销售出库管理
                </a>
                <a class="menu-item" href="${pageContext.request.contextPath}/sales/customerList" target="contentFrame" onclick="return navigate(this)">
                    <span class="icon">🤝</span> 客户信息管理
                </a>
                <a class="menu-item" href="${pageContext.request.contextPath}/sales/returnList" target="contentFrame" onclick="return navigate(this)">
                    <span class="icon">↩️</span> 销售退货管理
                </a>
            </c:if>
            <c:if test="${cu.role == 'warehouse' || cu.role == 'admin'}">
                <div class="menu-section">库存管理</div>
                <a class="menu-item" href="${pageContext.request.contextPath}/inventory/materialList" target="contentFrame" onclick="return navigate(this)">
                    <span class="icon">🧱</span> 物料信息管理
                </a>
                <a class="menu-item" href="${pageContext.request.contextPath}/inventory/checkList" target="contentFrame" onclick="return navigate(this)">
                    <span class="icon">✅</span> 库存盘点管理
                </a>
                <a class="menu-item" href="${pageContext.request.contextPath}/inventory/reportLedger" target="contentFrame" onclick="return navigate(this)">
                    <span class="icon">📄</span> 库存报表管理
                </a>
                <a class="menu-item" href="${pageContext.request.contextPath}/inventory/warningList" target="contentFrame" onclick="return navigate(this)">
                    <span class="icon">⚠️</span> 库存预警管理
                </a>
            </c:if>
        </nav>
    </aside>

    <!-- 主区域 -->
    <div class="main-area">
        <header class="topbar">
            <div class="page-title" id="pageTitle">首页Dashboard</div>
            <div class="user-info" style="position:relative;">
                <div style="text-align:right;">
                    <div class="user-name">${cu.username}</div>
                    <div class="user-role">${cu.roleName} · ${cu.deptName}</div>
                </div>
                <div class="avatar">${cu.username.substring(0,1)}</div>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/system/changePassword">🔑 修改密码</a>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/system/logout" style="color:#ef4444;">🚪 退出登录</a>
                </div>
            </div>
        </header>
        <div class="content" id="mainContent">
            <!-- Dashboard内容 -->
            <div class="welcome-section">
                <div class="welcome-content">
                    <div>
                        <h2>欢迎回来，${cu.username}！</h2>
                        <p>今天是 <%= new java.text.SimpleDateFormat("yyyy年MM月dd日 EEEE").format(new java.util.Date()) %></p>
                        <span class="welcome-role">${cu.roleName} · ${cu.deptName}</span>
                    </div>
                    <div class="time-display" id="timeDisplay"></div>
                </div>
            </div>

            <div class="stats-grid" id="statsGrid"></div>
            <div class="dashboard-grid">
                <div class="card">
                    <div class="card-header"><h3>⚡ 快捷操作</h3></div>
                    <div class="card-body" id="quickActions"></div>
                </div>
                <div class="warning-dashboard">
                    <h4>⚠️ 库存预警 <span id="warningCount" class="tag tag-danger">0</span></h4>
                    <div id="warningList"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/common.js"></script>
<script>
    // 菜单导航
    function navigate(el) {
        document.querySelectorAll('.menu-item').forEach(function(m) { m.classList.remove('active'); });
        el.classList.add('active');
        document.getElementById('pageTitle').textContent = el.textContent.trim();
        var url = el.getAttribute('href');
        if (url === '${pageContext.request.contextPath}/main' || url === '/main') {
            showDashboard();
            return false;
        }
        loadPage(url);
        return false;
    }

    function loadPage(url) {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', url, true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                document.getElementById('mainContent').innerHTML = xhr.responseText;
                var scripts = document.getElementById('mainContent').querySelectorAll('script');
                scripts.forEach(function(s) {
                    var newScript = document.createElement('script');
                    newScript.text = s.textContent;
                    document.body.appendChild(newScript);
                });
            }
        };
        xhr.send();
    }

    function showDashboard() {
        var now = new Date();
        var days = ['日', '一', '二', '三', '四', '五', '六'];
        var dateStr = now.getFullYear() + '年' + (now.getMonth()+1) + '月' + now.getDate() + '日 星期' + days[now.getDay()];
        var html = '<div class="welcome-section"><div class="welcome-content"><div>' +
            '<h2>欢迎回来，${cu.username}！</h2>' +
            '<p>' + dateStr + '</p>' +
            '<span class="welcome-role">${cu.roleName} · ${cu.deptName}</span>' +
            '</div><div class="time-display" id="timeDisplay"></div></div></div>' +
            '<div class="stats-grid" id="statsGrid"></div>' +
            '<div class="dashboard-grid">' +
            '<div class="card"><div class="card-header"><h3>⚡ 快捷操作</h3></div><div class="card-body" id="quickActions"></div></div>' +
            '<div class="warning-dashboard"><h4>⚠️ 库存预警 <span id="warningCount" class="tag tag-danger">0</span></h4><div id="warningList"></div></div>' +
            '</div>';
        document.getElementById('mainContent').innerHTML = html;
        updateClock();
        if (window._clockTimer) clearInterval(window._clockTimer);
        window._clockTimer = setInterval(updateClock, 1000);
        loadDashboardData();
    }

    function updateClock() {
        var el = document.getElementById('timeDisplay');
        if (el) el.textContent = new Date().toLocaleTimeString('zh-CN', {hour:'2-digit',minute:'2-digit',second:'2-digit'});
    }

    function renderQuickActions() {
        var role = '${cu.role}';
        var ctx = '${pageContext.request.contextPath}';
        var actions = [];
        if (role === 'admin') {
            actions = [
                {icon:'👤', label:'用户管理', url:ctx+'/system/userList'},
                {icon:'🧱', label:'材料管理', url:ctx+'/inventory/materialList'},
                {icon:'📋', label:'采购计划', url:ctx+'/purchase/planList'},
                {icon:'📝', label:'销售订单', url:ctx+'/sales/orderList'},
                {icon:'📄', label:'库存报表', url:ctx+'/inventory/reportLedger'},
                {icon:'⚠️', label:'库存预警', url:ctx+'/inventory/warningList'}
            ];
        } else if (role === 'purchase') {
            actions = [
                {icon:'➕', label:'新建采购计划', url:ctx+'/purchase/planAdd'},
                {icon:'📦', label:'采购入库', url:ctx+'/purchase/inboundList'},
                {icon:'🏢', label:'供应商管理', url:ctx+'/purchase/supplierList'},
                {icon:'↩️', label:'采购退货', url:ctx+'/purchase/returnList'},
                {icon:'📋', label:'采购计划列表', url:ctx+'/purchase/planList'}
            ];
        } else if (role === 'sale') {
            actions = [
                {icon:'➕', label:'新建订单', url:ctx+'/sales/orderAdd'},
                {icon:'🚚', label:'销售出库', url:ctx+'/sales/outboundList'},
                {icon:'🤝', label:'客户管理', url:ctx+'/sales/customerList'},
                {icon:'↩️', label:'销售退货', url:ctx+'/sales/returnList'},
                {icon:'📝', label:'订单列表', url:ctx+'/sales/orderList'}
            ];
        } else if (role === 'warehouse') {
            actions = [
                {icon:'🧱', label:'材料管理', url:ctx+'/inventory/materialList'},
                {icon:'✅', label:'库存盘点', url:ctx+'/inventory/checkList'},
                {icon:'📄', label:'库存报表', url:ctx+'/inventory/reportLedger'},
                {icon:'⚠️', label:'库存预警', url:ctx+'/inventory/warningList'}
            ];
        }
        var el = document.getElementById('quickActions');
        if (!el || !actions.length) return;
        var h = '<div class="quick-actions-grid">';
        actions.forEach(function(a) {
            h += '<div class="quick-action-btn" onclick="loadPage(\'' + a.url + '\')">' +
                '<div class="q-icon">' + a.icon + '</div>' +
                '<div class="q-label">' + a.label + '</div></div>';
        });
        h += '</div>';
        el.innerHTML = h;
    }

    function loadDashboardData() {
        // 快捷操作
        renderQuickActions();

        // 加载预警
        XINAI.ajax.get('${pageContext.request.contextPath}/inventory/warning/realtime', {}, function(res) {
            if (res && res.code === 0 && res.data) {
                var list = document.getElementById('warningList');
                var count = document.getElementById('warningCount');
                if (list) {
                    if (res.data.length === 0) {
                        list.innerHTML = '<p style="color:#22c55e;font-size:13px;">✅ 当前无库存预警</p>';
                    } else {
                        var h = '';
                        res.data.forEach(function(w) {
                            var type = w.warningType === '0' ? 'warning-low' : 'warning-high';
                            var label = w.warningType === '0' ? '库存不足' : '库存积压';
                            h += '<div class="warning-item"><span><strong>' + w.materialName + '</strong> ' + label + '</span><span class="tag ' + (w.warningType === '0' ? 'tag-danger' : 'tag-warning') + '">当前: ' + w.currentQty + '</span></div>';
                        });
                        list.innerHTML = h;
                    }
                    if (count) count.textContent = res.data.length;
                }
            }
        });

        // 加载统计
        var role = '${cu.role}';
        var statsHtml = '';
        if (role === 'admin') {
            statsHtml = '<div class="stat-card"><div class="stat-icon">👥</div><div class="stat-label">系统用户</div><div class="stat-value" id="statUsers">-</div><div class="stat-desc">各岗位用户合计</div></div>' +
                '<div class="stat-card"><div class="stat-icon">⚠️</div><div class="stat-label">库存预警</div><div class="stat-value" id="statWarnings">-</div><div class="stat-desc">待处理预警</div></div>' +
                '<div class="stat-card"><div class="stat-icon">📋</div><div class="stat-label">待审批采购计划</div><div class="stat-value" id="statPlans">-</div><div class="stat-desc">等待主管审批</div></div>' +
                '<div class="stat-card"><div class="stat-icon">📝</div><div class="stat-label">待审批销售订单</div><div class="stat-value" id="statOrders">-</div><div class="stat-desc">等待主管审批</div></div>';
        } else if (role === 'purchase') {
            statsHtml = '<div class="stat-card"><div class="stat-icon">📋</div><div class="stat-label">待审批计划</div><div class="stat-value" id="statPlans">-</div><div class="stat-desc">等待主管审批</div></div>' +
                '<div class="stat-card"><div class="stat-icon">📦</div><div class="stat-label">本月入库</div><div class="stat-value" id="statInbound">-</div><div class="stat-desc">采购入库笔数</div></div>' +
                '<div class="stat-card"><div class="stat-icon">🏢</div><div class="stat-label">供应商</div><div class="stat-value" id="statSuppliers">-</div><div class="stat-desc">合作中供应商</div></div>' +
                '<div class="stat-card"><div class="stat-icon">↩️</div><div class="stat-label">退货待处理</div><div class="stat-value" id="statReturns">-</div><div class="stat-desc">采购退货</div></div>';
        } else if (role === 'sale') {
            statsHtml = '<div class="stat-card"><div class="stat-icon">📝</div><div class="stat-label">待审批订单</div><div class="stat-value" id="statOrders">-</div><div class="stat-desc">等待主管审批</div></div>' +
                '<div class="stat-card"><div class="stat-icon">🚚</div><div class="stat-label">本月出库</div><div class="stat-value" id="statOutbound">-</div><div class="stat-desc">销售出库笔数</div></div>' +
                '<div class="stat-card"><div class="stat-icon">🤝</div><div class="stat-label">客户</div><div class="stat-value" id="statCustomers">-</div><div class="stat-desc">合作中客户</div></div>' +
                '<div class="stat-card"><div class="stat-icon">↩️</div><div class="stat-label">退货待审批</div><div class="stat-value" id="statSalesReturns">-</div><div class="stat-desc">销售退货</div></div>';
        } else if (role === 'warehouse') {
            statsHtml = '<div class="stat-card"><div class="stat-icon">🧱</div><div class="stat-label">物料品类</div><div class="stat-value" id="statMaterials">-</div><div class="stat-desc">库存物料总数</div></div>' +
                '<div class="stat-card"><div class="stat-icon">⚠️</div><div class="stat-label">库存预警</div><div class="stat-value" id="statWarnings">-</div><div class="stat-desc">待处理预警</div></div>' +
                '<div class="stat-card"><div class="stat-icon">📦</div><div class="stat-label">今日入库</div><div class="stat-value" id="statTodayIn">-</div><div class="stat-desc">采购入库</div></div>' +
                '<div class="stat-card"><div class="stat-icon">🚚</div><div class="stat-label">今日出库</div><div class="stat-value" id="statTodayOut">-</div><div class="stat-desc">销售出库</div></div>';
        }
        document.getElementById('statsGrid').innerHTML = statsHtml;

        // 加载各角色统计数据
        if (role === 'admin' || role === 'purchase') {
            XINAI.ajax.get('${pageContext.request.contextPath}/purchase/plan/list', {page:1, limit:1, approvalStatus:'0'}, function(res) {
                var el = document.getElementById('statPlans'); if (el) el.textContent = res ? res.count : 0;
            });
        }
        if (role === 'admin' || role === 'sale') {
            XINAI.ajax.get('${pageContext.request.contextPath}/sales/order/list', {page:1, limit:1, approvalStatus:'0'}, function(res) {
                var el = document.getElementById('statOrders'); if (el) el.textContent = res ? res.count : 0;
            });
        }
        if (role === 'warehouse' || role === 'admin') {
            XINAI.ajax.get('${pageContext.request.contextPath}/inventory/warning/list', {page:1, limit:1, status:'0'}, function(res) {
                var el = document.getElementById('statWarnings'); if (el) el.textContent = res ? res.count : 0;
            });
        }
    }

    // 初始化
    loadDashboardData();
    updateClock();
    if (window._clockTimer) clearInterval(window._clockTimer);
    window._clockTimer = setInterval(updateClock, 1000);
</script>
</body>
</html>
