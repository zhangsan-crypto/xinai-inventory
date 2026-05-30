package com.xinai.inventory.service;

import com.xinai.inventory.entity.SysUser;
import com.xinai.inventory.util.Result;
import java.util.List;
import java.util.Map;

public interface SystemService {
    SysUser login(String userId, String password);
    Result getUserList(Map<String, Object> params);
    SysUser getUserById(String userId);
    Result addUser(SysUser user);
    Result updateUser(SysUser user);
    Result deleteUser(String userId);
    Result changePassword(String userId, String oldPwd, String newPwd);
    Result resetPassword(String userId);
    List<SysUser> getAllUsers();
}
