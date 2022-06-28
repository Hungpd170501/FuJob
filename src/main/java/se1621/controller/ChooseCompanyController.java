/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package se1621.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import se1621.dao.UserDAO;
import se1621.dto.Role;
import se1621.dto.User;

/**
 *
 * @author HNGB
 */
@WebServlet(name = "ChooseCompanyController", urlPatterns = {"/ChooseCompanyController"})
public class ChooseCompanyController extends HttpServlet {

    private static final String ERROR = "/view/choose-company.jsp";
    private static final String SUCCESS = "/MainController?action=SearchCompanyID&searchCompanyID=";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            User loginUser = (User) session.getAttribute("LOGIN_USER");
            int userID = loginUser.getUserID();
            String fullName = loginUser.getFullName();
            String email = loginUser.getEmail();
            String password = loginUser.getPassword();
            String roleID = loginUser.getRole().getRoleID();
            int companyID = Integer.parseInt(request.getParameter("choose-companyName"));
            User user = User.builder()
                    .userID(userID)
                    .fullName(fullName)
                    .password(password)
                    .email(email)
                    .role(new Role(roleID, ""))
                    .companyID(companyID)
                    .build();
            UserDAO dao = new UserDAO();
            boolean check = dao.updateCompanyID(user, companyID);
            if (user != null && check) {
                session.setAttribute("LOGIN_USER", user);
                url = SUCCESS + companyID;
            }
        } catch (NumberFormatException | SQLException e) {
            log("Error at UpdateController: " + e);
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ChooseCompanyController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ChooseCompanyController.class.getName()).log(Level.SEVERE, null, ex);
        }
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