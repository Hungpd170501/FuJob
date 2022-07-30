/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/ServletListener.java to edit this template
 */
package se1621.listener;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import se1621.dao.v2.CategoryDAOImpl;
import se1621.dao.v2.RoleDAO;
import se1621.dao.v2.RoleDAOImpl;
import se1621.dao.v2.SkillDAOImpl;
import se1621.entity.CategoryEntity;
import se1621.entity.RoleEntity;
import se1621.entity.SkillEntity;
import se1621.utils.DBUtils;
import se1621.utils.FirebaseUtils;
import se1621.utils.HibernateUtils;
import se1621.utils.PropertiesFileHelper;

import java.util.List;
import java.util.Properties;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

import static com.sun.activation.registries.LogSupport.log;

/**
 * Web application lifecycle listener.
 *
 * @author ACER
 */
public class ContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        CompletableFuture<Void> future1 = CompletableFuture.runAsync(() -> {
            try {
                String siteMapLocation = context.getInitParameter("SITEMAP_PROPERTIES_FILE_LOCATION");
                Properties siteMapProperties = PropertiesFileHelper.getProperties(context, siteMapLocation);
                context.setAttribute("SITE_MAP", siteMapProperties);
            } catch (Throwable t) {
                log(t.getMessage());
            }
        });
        CompletableFuture<Void> future2 = CompletableFuture.runAsync(() -> {
            try {
                String authenticationPropertiesLocation = context.getInitParameter("AUTHENTICATION_PROPERTIES_FILE_LOCATION");
                Properties authenticationProperties = PropertiesFileHelper.getProperties(context, authenticationPropertiesLocation);
                context.setAttribute("AUTHENTICATION_LIST", authenticationProperties);
            } catch (Throwable t) {
                log(t.getMessage());
            }
        });
        CompletableFuture<Void> future3 = CompletableFuture.runAsync(() -> {
            try {
                DBUtils.getInstance();
            } catch (Throwable t) {
                log(t.getMessage());
            }
        });
        CompletableFuture<Void> future4 = CompletableFuture.runAsync(() -> {
            try {
                HibernateUtils.getSession();
            } catch (Throwable t) {
                log(t.getMessage());
            }
        });
        CompletableFuture<Void> future5 = CompletableFuture.runAsync(() -> {
            try {
                FirebaseUtils.getInstance().getFirebaseApp();
            } catch (Throwable t) {
                log(t.getMessage());
            }
        });
        try {
            CompletableFuture.allOf(future1, future2,future3,future4,future5).get();
        } catch (InterruptedException | ExecutionException e) {
            throw new RuntimeException(e);
        }

        CompletableFuture<Void> future11 = CompletableFuture.runAsync(() -> {
            try {
                CategoryDAOImpl categoryDAOImpl = new CategoryDAOImpl();
                List<CategoryEntity> listCategory = categoryDAOImpl.getAllUsingHQL("FROM CategoryEntity c WHERE c.categoryStatus=1 ORDER BY c.categoryName");
                context.setAttribute("CATEGORY_LIST", listCategory);
            } catch (Throwable t) {
                log(t.getMessage());
            }
        });
        CompletableFuture<Void> future12 = CompletableFuture.runAsync(() -> {
            try {
                SkillDAOImpl skillDAOImpl = new SkillDAOImpl();
                List<SkillEntity> listSkill = skillDAOImpl.getAllUsingHQL("FROM SkillEntity s WHERE s.skillStatus=1 ORDER BY s.skillName");
                context.setAttribute("SKILL_LIST", listSkill);
            } catch (Throwable t) {
                log(t.getMessage());
            }
        });
        CompletableFuture<Void> future13 = CompletableFuture.runAsync(() -> {
            try {
                RoleDAO roleDAO = new RoleDAOImpl();
                List<RoleEntity> listRole = roleDAO.getAll("RoleEntity");
                context.setAttribute("ROLE_LIST", listRole);
            } catch (Throwable t) {
                log(t.getMessage());
            }
        });
        try {
            CompletableFuture.allOf(future11, future12, future13).get();
        } catch (InterruptedException | ExecutionException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
