/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package se1621.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.commons.lang3.StringUtils;
import se1621.dao.UserDAO;
import se1621.dto.User;
import se1621.utils.Helper;
import se1621.utils.JwtTokenUtils;

import java.io.IOException;

@WebServlet(name = "RecoveryPasswordHandler", urlPatterns = {"/RecoveryPasswordHandler"})
public class RecoveryPasswordHandler extends HttpServlet {

    private static final String ERROR = "/view/recovery_password.jsp";
    private static final String SUCCESS = "/view/change-password.jsp";

    protected void processRequest(jakarta.servlet.http.HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response)
            throws jakarta.servlet.ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String token = request.getParameter("token");
            if (!token.isEmpty()) {
                JwtTokenUtils jwtTokenUtils = new JwtTokenUtils();
                if (jwtTokenUtils.canParseToken(token)) {
                    if (!jwtTokenUtils.isTokenExpired(token)) {
                        UserDAO userDAO = new UserDAO();
                        User user = userDAO.checkUserByEmail(jwtTokenUtils.getEmailFromToken(token));
                        Helper helper = new Helper();
                        if (user != null && helper.checkPass(user.getPassword(), jwtTokenUtils.getPasswordFromToken(token))) {
                            HttpSession session = request.getSession();
                            session.setAttribute("LOGIN_USER", user);
                            url = SUCCESS;
                        }
                    }
                }
            }
            if (!StringUtils.equals(url, SUCCESS)) {
                request.setAttribute("RECOVERY_PASSWORD_MESSAGE", "It looks like you clicked on an invalid password reset link. Please try again!");
            }
        } catch (Exception e) {
            log("Error at RecoveryPasswordHandler: " + e);
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
