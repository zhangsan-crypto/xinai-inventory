-- ============================================
-- 鑫爱建筑进销存管理信息系统 - 数据库初始化脚本
-- ============================================

DROP DATABASE IF EXISTS xinai_inventory;
CREATE DATABASE xinai_inventory DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE xinai_inventory;

SET NAMES utf8mb4;

-- 1. 用户表
DROP TABLE IF EXISTS sys_user;
CREATE TABLE sys_user (
    user_id VARCHAR(20) NOT NULL COMMENT '用户账号(YH+部门编码+岗位编码+序号,7位)',
    username VARCHAR(50) NOT NULL COMMENT '用户姓名',
    password VARCHAR(100) NOT NULL COMMENT '登录密码(MD5加密)',
    dept_code VARCHAR(2) DEFAULT NULL COMMENT '部门编码:01采购,02销售,03仓储,04行政,05财务',
    post_code VARCHAR(2) DEFAULT NULL COMMENT '岗位编码:01采购,02销售,03仓库,04管理,05财务',
    user_seq VARCHAR(2) DEFAULT NULL COMMENT '用户序号(2位)',
    role VARCHAR(20) NOT NULL COMMENT '角色:admin/purchase/sale/warehouse',
    status VARCHAR(1) DEFAULT '0' COMMENT '状态:0启用,1禁用',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 2. 材料信息表
DROP TABLE IF EXISTS material;
CREATE TABLE material (
    material_id VARCHAR(20) NOT NULL COMMENT '材料编号(CL+大类+规格+序号,9位)',
    material_name VARCHAR(100) NOT NULL COMMENT '材料名称',
    category_code VARCHAR(2) DEFAULT NULL COMMENT '材料大类编码:01钢筋,02水泥,03砂石,04砖,05木材,06防水材料',
    spec_code VARCHAR(2) DEFAULT NULL COMMENT '规格编码',
    material_seq VARCHAR(4) DEFAULT NULL COMMENT '材料序号(4位)',
    spec_model VARCHAR(100) DEFAULT NULL COMMENT '规格型号',
    unit VARCHAR(20) DEFAULT NULL COMMENT '计量单位',
    ref_price DECIMAL(10,2) DEFAULT 0.00 COMMENT '参考单价',
    safety_lower DECIMAL(10,0) DEFAULT 0 COMMENT '安全库存下限',
    safety_upper DECIMAL(10,0) DEFAULT 0 COMMENT '安全库存上限',
    status VARCHAR(1) DEFAULT '0' COMMENT '状态:0正常,1停用',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (material_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='材料信息表';

-- 3. 供应商信息表
DROP TABLE IF EXISTS supplier;
CREATE TABLE supplier (
    supplier_id INT AUTO_INCREMENT NOT NULL COMMENT '供应商编号(自增)',
    supplier_name VARCHAR(100) NOT NULL COMMENT '供应商名称',
    contact_person VARCHAR(50) DEFAULT NULL COMMENT '联系人',
    contact_phone VARCHAR(20) DEFAULT NULL COMMENT '联系电话',
    main_material VARCHAR(200) DEFAULT NULL COMMENT '主营材料',
    cooperation_status VARCHAR(1) DEFAULT '0' COMMENT '合作状态:0合作中,1已停止',
    address VARCHAR(200) DEFAULT NULL COMMENT '地址',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (supplier_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='供应商信息表';

-- 4. 客户信息表
DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT NOT NULL COMMENT '客户编号(自增)',
    customer_name VARCHAR(100) NOT NULL COMMENT '客户名称',
    contact_person VARCHAR(50) DEFAULT NULL COMMENT '对接人',
    contact_phone VARCHAR(20) DEFAULT NULL COMMENT '联系电话',
    cooperation_status VARCHAR(1) DEFAULT '0' COMMENT '合作状态:0合作中,1已停止',
    address VARCHAR(200) DEFAULT NULL COMMENT '地址',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (customer_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='客户信息表';

-- 5. 采购计划表
DROP TABLE IF EXISTS purchase_plan;
CREATE TABLE purchase_plan (
    plan_id VARCHAR(20) NOT NULL COMMENT '采购计划编号(CG+年月+序号,11位)',
    plan_year VARCHAR(4) DEFAULT NULL COMMENT '年份',
    plan_month VARCHAR(2) DEFAULT NULL COMMENT '月份',
    plan_seq VARCHAR(4) DEFAULT NULL COMMENT '计划序号(4位)',
    material_id VARCHAR(20) DEFAULT NULL COMMENT '材料编号',
    material_name VARCHAR(100) DEFAULT NULL COMMENT '材料名称',
    spec_model VARCHAR(100) DEFAULT NULL COMMENT '规格型号',
    demand_qty DECIMAL(10,0) DEFAULT 0 COMMENT '需求数量',
    plan_date DATE DEFAULT NULL COMMENT '计划日期',
    applicant VARCHAR(20) DEFAULT NULL COMMENT '采购人员(用户账号)',
    approval_status VARCHAR(1) DEFAULT '0' COMMENT '审批状态:0待审批,1已审批,2已驳回',
    approver VARCHAR(20) DEFAULT NULL COMMENT '审批人',
    approval_time DATETIME DEFAULT NULL COMMENT '审批时间',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (plan_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='采购计划表';

-- 6. 采购入库表
DROP TABLE IF EXISTS purchase_inbound;
CREATE TABLE purchase_inbound (
    inbound_id INT AUTO_INCREMENT NOT NULL COMMENT '采购入库单号(自增)',
    plan_id VARCHAR(20) DEFAULT NULL COMMENT '关联采购计划编号',
    material_id VARCHAR(20) DEFAULT NULL COMMENT '材料编号',
    material_name VARCHAR(100) DEFAULT NULL COMMENT '材料名称',
    spec_model VARCHAR(100) DEFAULT NULL COMMENT '规格型号',
    inbound_qty DECIMAL(10,0) DEFAULT 0 COMMENT '入库数量',
    inbound_date DATE DEFAULT NULL COMMENT '入库日期',
    supplier_id INT DEFAULT NULL COMMENT '供应商编号',
    operator VARCHAR(20) DEFAULT NULL COMMENT '操作人(采购人员账号)',
    warehouse_keeper VARCHAR(20) DEFAULT NULL COMMENT '仓库验收人',
    status VARCHAR(1) DEFAULT '0' COMMENT '状态:0待验收,1已入库',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (inbound_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='采购入库表';

-- 7. 采购退货表
DROP TABLE IF EXISTS purchase_return;
CREATE TABLE purchase_return (
    return_id INT AUTO_INCREMENT NOT NULL COMMENT '采购退货单号(自增)',
    inbound_id INT DEFAULT NULL COMMENT '关联采购入库单号',
    material_id VARCHAR(20) DEFAULT NULL COMMENT '材料编号',
    material_name VARCHAR(100) DEFAULT NULL COMMENT '材料名称',
    return_qty DECIMAL(10,0) DEFAULT 0 COMMENT '退货数量',
    return_reason VARCHAR(500) DEFAULT NULL COMMENT '退货原因',
    return_date DATE DEFAULT NULL COMMENT '退货日期',
    supplier_id INT DEFAULT NULL COMMENT '供应商编号',
    operator VARCHAR(20) DEFAULT NULL COMMENT '操作人',
    status VARCHAR(1) DEFAULT '0' COMMENT '状态:0待处理,1已退货',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (return_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='采购退货表';

-- 8. 销售订单表
DROP TABLE IF EXISTS sales_order;
CREATE TABLE sales_order (
    order_id VARCHAR(20) NOT NULL COMMENT '销售订单编号(XS+年月+序号,11位)',
    order_year VARCHAR(4) DEFAULT NULL COMMENT '年份',
    order_month VARCHAR(2) DEFAULT NULL COMMENT '月份',
    order_seq VARCHAR(4) DEFAULT NULL COMMENT '订单序号(4位)',
    customer_id INT DEFAULT NULL COMMENT '客户编号',
    customer_name VARCHAR(100) DEFAULT NULL COMMENT '客户名称',
    material_id VARCHAR(20) DEFAULT NULL COMMENT '材料编号',
    material_name VARCHAR(100) DEFAULT NULL COMMENT '材料名称',
    spec_model VARCHAR(100) DEFAULT NULL COMMENT '规格型号',
    sales_qty DECIMAL(10,0) DEFAULT 0 COMMENT '销售数量',
    unit_price DECIMAL(10,2) DEFAULT 0.00 COMMENT '单价',
    total_amount DECIMAL(12,2) DEFAULT 0.00 COMMENT '总金额',
    delivery_requirement VARCHAR(500) DEFAULT NULL COMMENT '交货要求',
    order_date DATE DEFAULT NULL COMMENT '订单日期',
    applicant VARCHAR(20) DEFAULT NULL COMMENT '销售人员(用户账号)',
    approval_status VARCHAR(1) DEFAULT '0' COMMENT '审批状态:0待审批,1已审批,2已驳回',
    approver VARCHAR(20) DEFAULT NULL COMMENT '审批人',
    approval_time DATETIME DEFAULT NULL COMMENT '审批时间',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (order_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='销售订单表';

-- 9. 销售出库表
DROP TABLE IF EXISTS sales_outbound;
CREATE TABLE sales_outbound (
    outbound_id INT AUTO_INCREMENT NOT NULL COMMENT '销售出库单号(自增)',
    order_id VARCHAR(20) DEFAULT NULL COMMENT '关联销售订单编号',
    material_id VARCHAR(20) DEFAULT NULL COMMENT '材料编号',
    material_name VARCHAR(100) DEFAULT NULL COMMENT '材料名称',
    outbound_qty DECIMAL(10,0) DEFAULT 0 COMMENT '出库数量',
    outbound_date DATE DEFAULT NULL COMMENT '出库日期',
    operator VARCHAR(20) DEFAULT NULL COMMENT '操作人(销售人员账号)',
    warehouse_keeper VARCHAR(20) DEFAULT NULL COMMENT '仓库出库人',
    status VARCHAR(1) DEFAULT '0' COMMENT '状态:0待出库,1已出库',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (outbound_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='销售出库表';

-- 10. 销售退货表
DROP TABLE IF EXISTS sales_return;
CREATE TABLE sales_return (
    return_id INT AUTO_INCREMENT NOT NULL COMMENT '销售退货单号(自增)',
    order_id VARCHAR(20) DEFAULT NULL COMMENT '关联销售订单编号',
    customer_id INT DEFAULT NULL COMMENT '客户编号',
    material_id VARCHAR(20) DEFAULT NULL COMMENT '材料编号',
    material_name VARCHAR(100) DEFAULT NULL COMMENT '材料名称',
    return_qty DECIMAL(10,0) DEFAULT 0 COMMENT '退货数量',
    return_reason VARCHAR(500) DEFAULT NULL COMMENT '退货原因',
    return_date DATE DEFAULT NULL COMMENT '退货日期',
    approval_status VARCHAR(1) DEFAULT '0' COMMENT '审批状态:0待审批,1已审批,2已驳回',
    operator VARCHAR(20) DEFAULT NULL COMMENT '操作人',
    status VARCHAR(1) DEFAULT '0' COMMENT '状态:0待退货,1已退货入库',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (return_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='销售退货表';

-- 11. 库存台账表
DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT NOT NULL COMMENT '库存记录ID(自增)',
    material_id VARCHAR(20) NOT NULL COMMENT '材料编号',
    material_name VARCHAR(100) DEFAULT NULL COMMENT '材料名称',
    spec_model VARCHAR(100) DEFAULT NULL COMMENT '规格型号',
    current_qty DECIMAL(10,0) DEFAULT 0 COMMENT '当前库存数量',
    unit VARCHAR(20) DEFAULT NULL COMMENT '计量单位',
    ref_price DECIMAL(10,2) DEFAULT 0.00 COMMENT '参考单价',
    last_inbound_date DATE DEFAULT NULL COMMENT '最近入库日期',
    last_outbound_date DATE DEFAULT NULL COMMENT '最近出库日期',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (inventory_id),
    UNIQUE KEY uk_material_id (material_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='库存台账表';

-- 12. 库存盘点表
DROP TABLE IF EXISTS inventory_check;
CREATE TABLE inventory_check (
    check_id VARCHAR(20) NOT NULL COMMENT '盘点单号(PD+年月+序号,11位)',
    check_year VARCHAR(4) DEFAULT NULL COMMENT '年份',
    check_month VARCHAR(2) DEFAULT NULL COMMENT '月份',
    check_seq VARCHAR(4) DEFAULT NULL COMMENT '盘点序号(4位)',
    material_id VARCHAR(20) DEFAULT NULL COMMENT '材料编号',
    material_name VARCHAR(100) DEFAULT NULL COMMENT '材料名称',
    book_qty DECIMAL(10,0) DEFAULT 0 COMMENT '账面数量',
    actual_qty DECIMAL(10,0) DEFAULT 0 COMMENT '实际数量',
    diff_qty DECIMAL(10,0) DEFAULT 0 COMMENT '差异数量',
    diff_reason VARCHAR(500) DEFAULT NULL COMMENT '差异原因',
    check_date DATE DEFAULT NULL COMMENT '盘点日期',
    checker VARCHAR(20) DEFAULT NULL COMMENT '盘点人(仓库人员账号)',
    approval_status VARCHAR(1) DEFAULT '0' COMMENT '审批状态:0待审批,1已审批',
    approver VARCHAR(20) DEFAULT NULL COMMENT '审批人',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (check_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='库存盘点表';

-- 13. 库存预警表
DROP TABLE IF EXISTS inventory_warning;
CREATE TABLE inventory_warning (
    warning_id INT AUTO_INCREMENT NOT NULL COMMENT '预警ID(自增)',
    material_id VARCHAR(20) DEFAULT NULL COMMENT '材料编号',
    material_name VARCHAR(100) DEFAULT NULL COMMENT '材料名称',
    current_qty DECIMAL(10,0) DEFAULT 0 COMMENT '当前库存',
    safety_lower DECIMAL(10,0) DEFAULT 0 COMMENT '安全库存下限',
    safety_upper DECIMAL(10,0) DEFAULT 0 COMMENT '安全库存上限',
    warning_type VARCHAR(1) DEFAULT NULL COMMENT '预警类型:0库存不足,1库存积压',
    warning_date DATE DEFAULT NULL COMMENT '预警日期',
    status VARCHAR(1) DEFAULT '0' COMMENT '处理状态:0未处理,1已处理',
    handler VARCHAR(20) DEFAULT NULL COMMENT '处理人',
    handle_time DATETIME DEFAULT NULL COMMENT '处理时间',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (warning_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='库存预警表';

-- 14. 库存报表记录表
DROP TABLE IF EXISTS inventory_report;
CREATE TABLE inventory_report (
    report_id INT AUTO_INCREMENT NOT NULL COMMENT '报表ID(自增)',
    report_type VARCHAR(1) DEFAULT NULL COMMENT '报表类型:0库存台账,1出入库汇总,2盘点报表',
    report_name VARCHAR(200) DEFAULT NULL COMMENT '报表名称',
    start_date DATE DEFAULT NULL COMMENT '统计开始日期',
    end_date DATE DEFAULT NULL COMMENT '统计结束日期',
    generate_time DATETIME DEFAULT NULL COMMENT '生成时间',
    operator VARCHAR(20) DEFAULT NULL COMMENT '生成人',
    file_path VARCHAR(500) DEFAULT NULL COMMENT '导出文件路径',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (report_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='库存报表记录表';

-- ============================================
-- 插入初始数据
-- ============================================

-- 管理员账号 (admin/123456)
INSERT INTO sys_user (user_id, username, password, dept_code, post_code, user_seq, role, status)
VALUES ('YH040401', '系统管理员', 'e10adc3949ba59abbe56e057f20f883e', '04', '04', '01', 'admin', '0');

-- 采购人员账号
INSERT INTO sys_user (user_id, username, password, dept_code, post_code, user_seq, role, status)
VALUES ('YH010101', '采购人员张三', 'e10adc3949ba59abbe56e057f20f883e', '01', '01', '01', 'purchase', '0');

-- 销售人员账号
INSERT INTO sys_user (user_id, username, password, dept_code, post_code, user_seq, role, status)
VALUES ('YH020201', '销售人员李四', 'e10adc3949ba59abbe56e057f20f883e', '02', '02', '01', 'sale', '0');

-- 仓库人员账号
INSERT INTO sys_user (user_id, username, password, dept_code, post_code, user_seq, role, status)
VALUES ('YH030301', '仓库人员王五', 'e10adc3949ba59abbe56e057f20f883e', '03', '03', '01', 'warehouse', '0');

-- 材料示例数据
INSERT INTO material (material_id, material_name, category_code, spec_code, material_seq, spec_model, unit, ref_price, safety_lower, safety_upper, status)
VALUES ('CL01010001', 'HRB400螺纹钢', '01', '01', '0001', 'Φ25×9m', '吨', 3850.00, 50, 500, '0');
INSERT INTO material (material_id, material_name, category_code, spec_code, material_seq, spec_model, unit, ref_price, safety_lower, safety_upper, status)
VALUES ('CL01010002', 'HPB300盘圆', '01', '01', '0002', 'Φ8盘圆', '吨', 3750.00, 30, 300, '0');
INSERT INTO material (material_id, material_name, category_code, spec_code, material_seq, spec_model, unit, ref_price, safety_lower, safety_upper, status)
VALUES ('CL02010001', 'P.O42.5水泥', '02', '01', '0001', '散装42.5级', '吨', 420.00, 100, 1000, '0');
INSERT INTO material (material_id, material_name, category_code, spec_code, material_seq, spec_model, unit, ref_price, safety_lower, safety_upper, status)
VALUES ('CL02020001', 'P.O52.5水泥', '02', '02', '0001', '袋装52.5级', '吨', 520.00, 50, 500, '0');
INSERT INTO material (material_id, material_name, category_code, spec_code, material_seq, spec_model, unit, ref_price, safety_lower, safety_upper, status)
VALUES ('CL03010001', '机制砂', '03', '01', '0001', '中砂2.3-3.0', '立方米', 85.00, 200, 2000, '0');
INSERT INTO material (material_id, material_name, category_code, spec_code, material_seq, spec_model, unit, ref_price, safety_lower, safety_upper, status)
VALUES ('CL04010001', '烧结普通砖', '04', '01', '0001', '240×115×53mm', '千块', 350.00, 100, 1000, '0');

-- 库存台账初始数据
INSERT INTO inventory (material_id, material_name, spec_model, current_qty, unit, ref_price)
VALUES ('CL01010001', 'HRB400螺纹钢', 'Φ25×9m', 200, '吨', 3850.00);
INSERT INTO inventory (material_id, material_name, spec_model, current_qty, unit, ref_price)
VALUES ('CL01010002', 'HPB300盘圆', 'Φ8盘圆', 150, '吨', 3750.00);
INSERT INTO inventory (material_id, material_name, spec_model, current_qty, unit, ref_price)
VALUES ('CL02010001', 'P.O42.5水泥', '散装42.5级', 500, '吨', 420.00);
INSERT INTO inventory (material_id, material_name, spec_model, current_qty, unit, ref_price)
VALUES ('CL02020001', 'P.O52.5水泥', '袋装52.5级', 80, '吨', 520.00);
INSERT INTO inventory (material_id, material_name, spec_model, current_qty, unit, ref_price)
VALUES ('CL03010001', '机制砂', '中砂2.3-3.0', 800, '立方米', 85.00);
INSERT INTO inventory (material_id, material_name, spec_model, current_qty, unit, ref_price)
VALUES ('CL04010001', '烧结普通砖', '240×115×53mm', 500, '千块', 350.00);

-- 供应商示例数据
INSERT INTO supplier (supplier_name, contact_person, contact_phone, main_material, cooperation_status, address)
VALUES ('鑫达钢材有限公司', '赵经理', '13800138001', '螺纹钢、盘圆、线材', '0', '河北省唐山市路北区');
INSERT INTO supplier (supplier_name, contact_person, contact_phone, main_material, cooperation_status, address)
VALUES ('海螺水泥股份有限公司', '钱经理', '13800138002', '水泥、混凝土', '0', '安徽省芜湖市');
INSERT INTO supplier (supplier_name, contact_person, contact_phone, main_material, cooperation_status, address)
VALUES ('恒通砂石经营部', '孙经理', '13800138003', '砂石、碎石', '0', '四川省成都市龙泉驿区');

-- 客户示例数据
INSERT INTO customer (customer_name, contact_person, contact_phone, cooperation_status, address)
VALUES ('中建三局项目部', '周工', '13900139001', '0', '湖北省武汉市洪山区');
INSERT INTO customer (customer_name, contact_person, contact_phone, cooperation_status, address)
VALUES ('鑫鑫建筑劳务公司', '吴经理', '13900139002', '0', '四川省成都市高新区');
INSERT INTO customer (customer_name, contact_person, contact_phone, cooperation_status, address)
VALUES ('绿城房产开发公司', '郑经理', '13900139003', '0', '浙江省杭州市西湖区');
