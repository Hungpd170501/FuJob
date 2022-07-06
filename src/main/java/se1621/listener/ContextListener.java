/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/ServletListener.java to edit this template
 */
package se1621.listener;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import java.util.Properties;
import se1621.utils.DBUtils;
import se1621.utils.HibernateUtils;
import se1621.utils.PropertiesFileHelper;

/**
 * Web application lifecycle listener.
 *
 * @author ACER
 */
public class ContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        String siteMapLocation = context.getInitParameter("SITEMAP_PROPERTIES_FILE_LOCATION");
        Properties siteMapProperties = PropertiesFileHelper.getProperties(context, siteMapLocation);
        context.setAttribute("SITE_MAP", siteMapProperties);
        DBUtils.getInstance().getConnection();
        HibernateUtils.getSession();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
