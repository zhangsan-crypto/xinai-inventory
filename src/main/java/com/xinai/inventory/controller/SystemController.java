package com.xinai.inventory.controller;

import com.xinai.inventory.entity.SysUser;
import com.xinai.inventory.service.SystemService;
import com.xinai.inventory.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/system")
public class SystemController {

    @Autowired
    private SystemService systemService;

    @PostMapping("/login")
    @ResponseBody
    public Result login(@RequestBody Map<String, String> params, HttpSession session) {
        String userId = params.get("userId");
        String password = params.get("password");
        SysUser user = systemService.login(userId, password);
        if (user == null) {
            return Result.error("账号或密码错误");
        }
        if ("1".equals(user.getStatus())) {
            return Result.error("该账号已被禁用");
        }
        session.setAttribute("user", user);
        return Result.success("登录成功", user);
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @GetMapping("/user/list")
    @ResponseBody
    public Result userList(@RequestParam Map<String, Object> params) {
        return systemService.getUserList(params);
    }

    @GetMapping("/user/{userId}")
    @ResponseBody
    public Result getUser(@PathVariable String userId) {
        SysUser user = systemService.getUserById(userId);
        return user != null ? Result.success(user) : Result.error("用户不存在");
    }

    @PostMapping("/user/add")
    @ResponseBody
    public Result addUser(@RequestBody SysUser user) {
        return systemService.addUser(user);
    }

    @PutMapping("/user/update")
    @ResponseBody
    public Result updateUser(@RequestBody SysUser user) {
        return systemService.updateUser(user);
    }

    @DeleteMapping("/user/delete/{userId}")
    @ResponseBody
    public Result deleteUser(@PathVariable String userId) {
        return systemService.deleteUser(userId);
    }

    @PutMapping("/user/changePassword")
    @ResponseBody
    public Result changePassword(@RequestBody Map<String, String> params, HttpSession session) {
        SysUser user = (SysUser) session.getAttribute("user");
        return systemService.changePassword(user.getUserId(), params.get("oldPwd"), params.get("newPwd"));
    }

    @PutMapping("/user/resetPassword/{userId}")
    @ResponseBody
    public Result resetPassword(@PathVariable String userId) {
        return systemService.resetPassword(userId);
    }

    @GetMapping("/user/all")
    @ResponseBody
    public Result getAllUsers() {
        List<SysUser> users = systemService.getAllUsers();
        return Result.success(users);
    }
}
