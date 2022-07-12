/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package se1621.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.commons.lang3.StringUtils;
import se1621.dto.User;

import java.util.Properties;

/**
 * @author ACER
 */
public class AuthenticationFilter implements Filter {

    private static final boolean debug = true;

    private FilterConfig filterConfig = null;

    public AuthenticationFilter() {
    }

    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) {

        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        String uri = httpServletRequest.getRequestURI();
        try {
            Properties authenticationProperties = (Properties) request.getServletContext().getAttribute("AUTHENTICATION_LIST");
            String resource = uri.substring(uri.lastIndexOf("/") + 1);
            resource=(StringUtils.equals(resource,"MainController"))?httpServletRequest.getParameter("action"):resource;
            HttpSession session = httpServletRequest.getSession(false);
            String rule = authenticationProperties.getProperty(resource);
            if (rule == null||rule.equals("allowed")) {
                chain.doFilter(request, response);
            } else {
                if(session==null||session.getAttribute("LOGIN_USER")==null){
                    ((HttpServletResponse) response).sendRedirect("loginPage");
                }else{
                    if(StringUtils.contains(rule,new StringBuilder().append("|").append(((User) session.getAttribute("LOGIN_USER")).getRole().getRoleID()).append("|").toString())){
                        chain.doFilter(request, response);
                    }else{
                        request.setAttribute("LOGIN_MESSAGE", "Your role is not supported!");
                        httpServletRequest.getRequestDispatcher("/view/login.jsp").forward(request, response);
                    }
                }
            }
        } catch (Throwable t) {
            log(t.getMessage());
        }
    }

    public void destroy() {
    }

    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("AuthenticationFilter:Initializing filter");
            }
        }
    }

    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("AuthenticationFilter()");
        }
        return ("AuthenticationFilter(" + filterConfig + ")");
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

}
