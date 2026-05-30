package com.xinai.inventory.dao;

import com.xinai.inventory.entity.SysUser;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

public interface SystemDao {
    SysUser login(@Param("userId") String userId, @Param("password") String password);
    SysUser getUserById(@Param("userId") String userId);
    List<SysUser> getUserList(Map<String, Object> params);
    int getUserCount(Map<String, Object> params);
    int insertUser(SysUser user);
    int updateUser(SysUser user);
    int deleteUser(@Param("userId") String userId);
    int updatePassword(@Param("userId") String userId, @Param("password") String password);
    int getMaxUserSeq(@Param("deptCode") String deptCode, @Param("postCode") String postCode);
    List<SysUser> getAllUsers();
    List<SysUser> getUsersByRole(@Param("role") String role);
}
