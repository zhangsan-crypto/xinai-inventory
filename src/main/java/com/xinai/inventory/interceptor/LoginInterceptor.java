package com.xinai.inventory.interceptor;

import com.xinai.inventory.entity.SysUser;
import org.springframework.web.servlet.HandlerInterceptor;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        SysUser user = (SysUser) request.getSession().getAttribute("user");
        if (user == null) {
            String ajaxHeader = request.getHeader("X-Requested-With");
            if ("XMLHttpRequest".equals(ajaxHeader)) {
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write("{\"code\":401,\"msg\":\"未登录，请先登录\"}");
            } else {
                response.sendRedirect(request.getContextPath() + "/login");
            }
            return false;
        }

        String path = request.getServletPath();
        String role = user.getRole();

        // 权限校验
        if (!"admin".equals(role)) {
            if (path.startsWith("/system/")) {
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().write("<script>alert('无权限访问');location.href='" + request.getContextPath() + "/main';</script>");
                return false;
            }
            if (path.startsWith("/purchase/") && !"purchase".equals(role)) {
                response.getWriter().write("<script>alert('无权限访问');location.href='" + request.getContextPath() + "/main';</script>");
                return false;
            }
            if (path.startsWith("/sales/") && !"sale".equals(role)) {
                response.getWriter().write("<script>alert('无权限访问');location.href='" + request.getContextPath() + "/main';</script>");
                return false;
            }
            if (path.startsWith("/inventory/") && !"warehouse".equals(role)) {
                response.getWriter().write("<script>alert('无权限访问');location.href='" + request.getContextPath() + "/main';</script>");
                return false;
            }
        }

        return true;
    }
}
