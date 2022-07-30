/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package se1621.controller;

import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import se1621.dao.UserDAO;
import se1621.dto.User;
import se1621.utils.Helper;

/**
 *
 * @author ACER
 */
@WebServlet(name = "ChangePasswordController", urlPatterns = {"/ChangePasswordController"})
public class ChangePasswordController extends HttpServlet {

    private static final String ERROR = "/view/login.jsp";
    private static final String AD = "AD";
    private static final String US = "US";
    private static final String HR = "HR";
    private static final String HRM = "HRM";
    private static final String USER_PAGE = "/view/index.jsp";
    private static final String ADMIN_PAGE = "#";

    protected void processRequest(jakarta.servlet.http.HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response)
            throws jakarta.servlet.ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            User loginUser = (User) session.getAttribute("LOGIN_USER");
            String password = request.getParameter("password");
            UserDAO userDAO = new UserDAO();
            if (userDAO.updateUserPassword(loginUser.getEmail(), Helper.hashPassword(password))) {
                switch (loginUser.getUserStatus()) {
                    case 0:
                        request.setAttribute("LOGIN_MESSAGE", "Your account has been deactivated. Please contact to FuJob Support to reactivate it!!");
                        break;
                    case 2:
                        request.setAttribute("LOGIN_MESSAGE", "Your account hasn't been verified. Please check your acccount's email to activate it!!");
                        break;
                    case 1:
                        switch (loginUser.getRole().getRoleID()) {
                            case US:
                                request.setAttribute("MESSAGE_CHANGEPASS", "Change password successfully!");
                                url = USER_PAGE;
                                break;
                            case HR:
                                request.setAttribute("MESSAGE_CHANGEPASS", "Change password successfully!");
                                url = USER_PAGE;
                                break;
                            case AD:
                                request.setAttribute("MESSAGE_CHANGEPASS", "Change password successfully!");
                                url = ADMIN_PAGE;
                                break;
                            case HRM:
                                request.setAttribute("MESSAGE_CHANGEPASS", "Change password successfully!");
                                url = USER_PAGE;
                                break;
                            default:
                                request.setAttribute("LOGIN_MESSAGE", "Your role is not supported!");
                                break;
                        }
                        break;
                    default:
                        break;
                }
            } else {
                request.setAttribute("CHANGE_PASSWORD_MESSAGE", "Opp something wrong!");
            }
        } catch (Exception e) {
            request.setAttribute("LOGIN_MESSAGE", "Something wrong!!");
            log("Error at LoginController: " + e);
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
        processRequest(request, response);
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
