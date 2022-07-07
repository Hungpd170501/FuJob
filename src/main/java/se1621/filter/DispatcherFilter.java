/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package se1621.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;

import java.util.Properties;

/**
 * @author ACER
 */
public class DispatcherFilter implements Filter {

    private static final boolean debug = true;

    private FilterConfig filterConfig = null;

    public DispatcherFilter() {
    }

    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain) {

        HttpServletRequest req = (HttpServletRequest) request;
        String uri = req.getRequestURI();
        String url;
        try {
            ServletContext context = request.getServletContext();
            Properties siteMapProperties = (Properties) context.getAttribute("SITE_MAP");
            int lastIndex = uri.lastIndexOf("/");
            String resource = uri.substring(lastIndex + 1);
            url=resource.isBlank()?"MainController?action=IndexController":siteMapProperties.getProperty(resource);
            if (url != null) {
                req.getRequestDispatcher(url).forward(request, response);
            } else {
                chain.doFilter(request, response);
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
                log("DispatcherFilter:Initializing filter");
            }
        }
    }

    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("DispatcherFilter()");
        }
        return ("DispatcherFilter(" + filterConfig + ")");
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

}
