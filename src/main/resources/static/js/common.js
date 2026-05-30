/* ============================================
   鑫爱建筑进销存管理信息系统 - 公共脚本
   ============================================ */

var XINAI = XINAI || {};

// 工具方法
XINAI.util = {
    formatDate: function(d) {
        if (!d) return '-';
        var date = new Date(d);
        var y = date.getFullYear();
        var m = ('0' + (date.getMonth() + 1)).slice(-2);
        var day = ('0' + date.getDate()).slice(-2);
        return y + '-' + m + '-' + day;
    },
    formatDateTime: function(d) {
        if (!d) return '-';
        var date = new Date(d);
        var y = date.getFullYear();
        var m = ('0' + (date.getMonth() + 1)).slice(-2);
        var day = ('0' + date.getDate()).slice(-2);
        var h = ('0' + date.getHours()).slice(-2);
        var mi = ('0' + date.getMinutes()).slice(-2);
        return y + '-' + m + '-' + day + ' ' + h + ':' + mi;
    },
    getStatusTag: function(status, type) {
        var map = {
            '0': ['tag-warning', '待审批'],
            '1': ['tag-success', '已审批'],
            '2': ['tag-danger', '已驳回']
        };
        if (type === 'inbound') {
            map = { '0': ['tag-warning', '待验收'], '1': ['tag-success', '已入库'] };
        } else if (type === 'outbound') {
            map = { '0': ['tag-warning', '待出库'], '1': ['tag-success', '已出库'] };
        } else if (type === 'return') {
            map = { '0': ['tag-warning', '待处理'], '1': ['tag-success', '已退货'] };
        } else if (type === 'user') {
            map = { '0': ['tag-success', '启用'], '1': ['tag-danger', '禁用'] };
        } else if (type === 'material') {
            map = { '0': ['tag-success', '正常'], '1': ['tag-gray', '停用'] };
        } else if (type === 'cooperation') {
            map = { '0': ['tag-success', '合作中'], '1': ['tag-gray', '已停止'] };
        } else if (type === 'warning') {
            map = { '0': ['tag-danger', '未处理'], '1': ['tag-success', '已处理'] };
        } else if (type === 'warningType') {
            map = { '0': ['tag-danger', '库存不足'], '1': ['tag-warning', '库存积压'] };
        } else if (type === 'salesReturn') {
            map = { '0': ['tag-gray', '待退货'], '1': ['tag-success', '已退货入库'] };
        }
        var m = map[status] || ['tag-gray', status];
        return '<span class="tag ' + m[0] + '">' + m[1] + '</span>';
    },
    getDiffTag: function(val) {
        if (val > 0) return '<span class="tag tag-success">+' + val + '</span>';
        if (val < 0) return '<span class="tag tag-danger">' + val + '</span>';
        return '<span class="tag tag-gray">0</span>';
    },
    getMaterialCodeHtml: function(code, categoryCode) {
        var colorClasses = { '01': 'dept-01', '02': 'dept-02', '03': 'dept-03' };
        var cls = colorClasses[categoryCode] || '';
        return '<code class="user-id ' + cls + '">' + code + '</code>';
    },
    getUserIdHtml: function(userId, deptCode) {
        var colorClasses = { '01': 'dept-01', '02': 'dept-02', '03': 'dept-03' };
        var cls = colorClasses[deptCode] || '';
        return '<code class="user-id ' + cls + '">' + userId + '</code>';
    },
    confirm: function(msg, callback) {
        if (confirm(msg)) { callback(); }
    },
    alert: function(msg, type) {
        alert(msg);
    }
};

// AJAX请求封装
XINAI.ajax = {
    get: function(url, params, callback) {
        var query = [];
        for (var k in params) { if (params[k] !== '' && params[k] !== undefined) query.push(k + '=' + encodeURIComponent(params[k])); }
        var qs = query.length ? '?' + query.join('&') : '';
        var xhr = new XMLHttpRequest();
        xhr.open('GET', url + qs, true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    try { callback(JSON.parse(xhr.responseText)); } catch(e) { callback(null); }
                } else { callback(null); }
            }
        };
        xhr.send();
    },
    post: function(url, data, callback) {
        var xhr = new XMLHttpRequest();
        xhr.open('POST', url, true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    try { callback(JSON.parse(xhr.responseText)); } catch(e) { callback(null); }
                } else { callback(null); }
            }
        };
        xhr.send(JSON.stringify(data));
    },
    put: function(url, data, callback) {
        var xhr = new XMLHttpRequest();
        xhr.open('PUT', url, true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    try { callback(JSON.parse(xhr.responseText)); } catch(e) { callback(null); }
                } else { callback(null); }
            }
        };
        xhr.send(JSON.stringify(data));
    },
    del: function(url, callback) {
        var xhr = new XMLHttpRequest();
        xhr.open('DELETE', url, true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    try { callback(JSON.parse(xhr.responseText)); } catch(e) { callback(null); }
                } else { callback(null); }
            }
        };
        xhr.send();
    }
};

// 分页组件
XINAI.pagination = {
    render: function(elementId, total, page, limit, callback) {
        var el = document.getElementById(elementId);
        if (!el) return;
        var totalPages = Math.ceil(total / limit);
        if (totalPages <= 1) { el.innerHTML = ''; return; }
        var html = '<div class="pagination">';
        if (page > 1) html += '<a class="page-item" data-page="' + (page-1) + '">‹ 上一页</a>';
        html += '<span class="page-item active">' + page + '/' + totalPages + '</span>';
        if (page < totalPages) html += '<a class="page-item" data-page="' + (page+1) + '">下一页 ›</a>';
        html += '</div>';
        el.innerHTML = html;
        el.querySelectorAll('.page-item[data-page]').forEach(function(a) {
            a.addEventListener('click', function() { callback(parseInt(this.dataset.page)); });
        });
    }
};

// 弹窗
XINAI.modal = {
    show: function(html) {
        var overlay = document.createElement('div');
        overlay.className = 'modal-overlay show';
        overlay.innerHTML = '<div class="modal-box">' + html + '</div>';
        overlay.addEventListener('click', function(e) { if (e.target === overlay) XINAI.modal.close(overlay); });
        document.body.appendChild(overlay);
        return overlay;
    },
    close: function(overlay) {
        if (overlay) { overlay.remove(); }
    }
};

// 页面初始化
document.addEventListener('DOMContentLoaded', function() {
    // 顶部下拉菜单
    var userMenu = document.querySelector('.user-info');
    if (userMenu) {
        userMenu.addEventListener('click', function(e) {
            var dropdown = this.querySelector('.dropdown-menu');
            if (dropdown) dropdown.classList.toggle('show');
            e.stopPropagation();
        });
        document.addEventListener('click', function() {
            document.querySelectorAll('.dropdown-menu.show').forEach(function(m) { m.classList.remove('show'); });
        });
    }
});
