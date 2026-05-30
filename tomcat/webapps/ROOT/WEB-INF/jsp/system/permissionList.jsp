<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card">
    <div class="card-header"><h3>权限管理</h3></div>
    <div class="card-body">
        <table class="data-table">
            <thead>
                <tr>
                    <th>角色</th>
                    <th>系统管理</th>
                    <th>采购管理</th>
                    <th>销售管理</th>
                    <th>库存管理</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>系统管理员</strong></td>
                    <td><span class="tag tag-success">✓ 全部权限</span></td>
                    <td><span class="tag tag-success">✓ 全部权限</span></td>
                    <td><span class="tag tag-success">✓ 全部权限</span></td>
                    <td><span class="tag tag-success">✓ 全部权限</span></td>
                </tr>
                <tr>
                    <td><strong>采购人员</strong></td>
                    <td><span class="tag tag-gray">✗ 无权限</span></td>
                    <td><span class="tag tag-success">✓ 采购计划、入库、供应商、退货</span></td>
                    <td><span class="tag tag-gray">✗ 无权限</span></td>
                    <td><span class="tag tag-gray">✗ 无权限</span></td>
                </tr>
                <tr>
                    <td><strong>销售人员</strong></td>
                    <td><span class="tag tag-gray">✗ 无权限</span></td>
                    <td><span class="tag tag-gray">✗ 无权限</span></td>
                    <td><span class="tag tag-success">✓ 销售订单、出库、客户、退货</span></td>
                    <td><span class="tag tag-gray">✗ 无权限</span></td>
                </tr>
                <tr>
                    <td><strong>仓库人员</strong></td>
                    <td><span class="tag tag-gray">✗ 无权限</span></td>
                    <td><span class="tag tag-gray">✗ 无权限</span></td>
                    <td><span class="tag tag-gray">✗ 无权限</span></td>
                    <td><span class="tag tag-success">✓ 物料、盘点、报表、预警</span></td>
                </tr>
            </tbody>
        </table>
        <div style="margin-top:16px;padding:16px;background:#f8fafc;border-radius:8px;font-size:13px;color:#64748b;">
            <strong>说明：</strong>系统权限基于用户角色自动控制，不同角色的用户登录后只能访问对应功能模块。<br>
            <strong>系统管理员：</strong>可访问全部功能模块，包括系统管理、采购管理、销售管理、库存管理。<br>
            <strong>角色分配规则：</strong>新增用户时，根据选择的岗位自动分配角色。
        </div>
    </div>
</div>
