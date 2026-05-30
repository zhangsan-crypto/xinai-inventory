package com.xinai.inventory.service.impl;

import com.xinai.inventory.dao.SystemDao;
import com.xinai.inventory.entity.SysUser;
import com.xinai.inventory.service.SystemService;
import com.xinai.inventory.util.CodeGenerator;
import com.xinai.inventory.util.MD5Util;
import com.xinai.inventory.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SystemServiceImpl implements SystemService {

    @Autowired
    private SystemDao systemDao;

    @Override
    public SysUser login(String userId, String password) {
        String md5Pwd = MD5Util.md5(password);
        return systemDao.login(userId, md5Pwd);
    }

    @Override
    public Result getUserList(Map<String, Object> params) {
        int page = params.get("page") != null ? Integer.parseInt(params.get("page").toString()) : 1;
        int limit = params.get("limit") != null ? Integer.parseInt(params.get("limit").toString()) : 10;
        params.put("offset", (page - 1) * limit);
        params.put("limit", limit);
        List<SysUser> list = systemDao.getUserList(params);
        int total = systemDao.getUserCount(params);
        return Result.page(list, total);
    }

    @Override
    public SysUser getUserById(String userId) {
        return systemDao.getUserById(userId);
    }

    @Override
    @Transactional
    public Result addUser(SysUser user) {
        int seq = systemDao.getMaxUserSeq(user.getDeptCode(), user.getPostCode()) + 1;
        String userId = CodeGenerator.generateUserCode(user.getDeptCode(), user.getPostCode(), seq);
        user.setUserId(userId);
        user.setUserSeq(String.format("%02d", seq));
        user.setPassword(MD5Util.md5(user.getPassword() != null ? user.getPassword() : "123456"));

        // 根据岗位自动设置角色
        if (user.getRole() == null || user.getRole().isEmpty()) {
            if ("01".equals(user.getPostCode())) user.setRole("purchase");
            else if ("02".equals(user.getPostCode())) user.setRole("sale");
            else if ("03".equals(user.getPostCode())) user.setRole("warehouse");
            else if ("04".equals(user.getPostCode())) user.setRole("admin");
            else user.setRole("purchase");
        }

        systemDao.insertUser(user);
        return Result.success("新增用户成功，账号: " + userId, user);
    }

    @Override
    @Transactional
    public Result updateUser(SysUser user) {
        systemDao.updateUser(user);
        return Result.success("修改用户成功");
    }

    @Override
    @Transactional
    public Result deleteUser(String userId) {
        systemDao.deleteUser(userId);
        return Result.success("删除用户成功");
    }

    @Override
    @Transactional
    public Result changePassword(String userId, String oldPwd, String newPwd) {
        SysUser user = systemDao.getUserById(userId);
        if (user == null) return Result.error("用户不存在");
        if (!MD5Util.verify(oldPwd, user.getPassword())) return Result.error("原密码错误");
        systemDao.updatePassword(userId, MD5Util.md5(newPwd));
        return Result.success("密码修改成功");
    }

    @Override
    @Transactional
    public Result resetPassword(String userId) {
        systemDao.updatePassword(userId, MD5Util.md5("123456"));
        return Result.success("密码已重置为123456");
    }

    @Override
    public List<SysUser> getAllUsers() {
        return systemDao.getAllUsers();
    }
}
