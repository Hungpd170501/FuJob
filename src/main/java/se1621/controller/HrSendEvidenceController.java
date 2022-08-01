/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package se1621.controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import se1621.dao.EvidenceDAO;
import se1621.dto.Disputes;
import se1621.dto.Evidences;
import se1621.dto.User;
import se1621.service.FirebaseStoreServiceImpl;

/**
 *
 * @author quocb
 */
@WebServlet(name="HrSendEvidenceController", urlPatterns={"/HrSendEvidenceController"})
public class HrSendEvidenceController extends HttpServlet {
   
    private static final String ERROR = "/view/error.jsp";
    private static final String SUCCESS = "/MainController?action=ViewJobHrDispute&userID=";;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("LOGIN_USER");
            int userID = user.getUserID();
            String userStory = request.getParameter("userStory");
            int disputeID =  Integer.parseInt(request.getParameter("disputeID"));
            Part filePart = request.getPart("fileEvidence");
            FirebaseStoreServiceImpl firebaseStoreServiceImpl = new FirebaseStoreServiceImpl();
            String filename = firebaseStoreServiceImpl.uploadFile(filePart);
            Evidences evidences = Evidences.builder()
                    .disputes(Disputes.builder().disputeID(disputeID).build())
                    .user(user)
                    .message(userStory)
                    .evidenceFile(filename)
                    .build();
            EvidenceDAO evidenceDAO = new EvidenceDAO();
            boolean checkSendEvidence = evidenceDAO.createEvidence(evidences);
            if(checkSendEvidence){                
                    request.setAttribute("MESSAGE_UPDATE", "Send Evidence Sucessfull!");
                    url = SUCCESS + userID;
            }
        } catch (Exception e) {
            log("Error at View all job Controller" + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
