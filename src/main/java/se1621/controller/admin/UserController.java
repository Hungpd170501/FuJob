/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package se1621.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import se1621.dao.v2.UserDAOImpl;
import se1621.entity.RoleEntity;
import se1621.entity.UserEntity;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import static java.util.stream.Collectors.*;

@WebServlet(name = "UserController", urlPatterns = {"/UserController"})
public class UserController extends HttpServlet {

    private static final String ERROR = "/view/error.jsp";
    private static final String SUCCESS = "/WEB-INF/viewAdmin/users-list.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            UserDAOImpl userDAOImpl = new UserDAOImpl();
            List<UserEntity> listAllUser = userDAOImpl.getAll("UserEntity");
            Map<RoleEntity, List<UserEntity>> listUserByRoles
                    = listAllUser.stream()
                    .filter(e -> e.getRole() != null)
                    .collect(groupingBy(UserEntity::getRole, toList()));
            listUserByRoles.forEach((key, value) -> {
                request.setAttribute("COUNT_TOTAL_" + key.getRoleID(), value.size());
                Map<Integer, Long> map
                        = value.stream()
                        .filter(entity -> entity.getUserStatus() != null)
                        .collect(groupingBy(UserEntity::getUserStatus, counting()));
                if (map.size() != 3) {
                    for (int i = 0; i <= 2; i++)
                        map.putIfAbsent(i, 0L);
                }
                for (var entry : map.entrySet()) {
                    request.setAttribute(key.getRoleID() + "_" + entry.getKey(), entry.getValue());
                }
            });
            request.setAttribute("COUNT_USER_LIST", listAllUser.size());
            request.setAttribute("USER_LIST", listAllUser);
            url = SUCCESS;
        } catch (Exception e) {
            log("Error at UserController: " + e);
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
