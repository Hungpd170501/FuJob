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
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import se1621.dao.JobDAO;
import se1621.dto.Category;
import se1621.dto.Job;
import se1621.dto.Skill;
import se1621.dto.User;

/**
 *
 * @author HNGB
 */
@WebServlet(name = "PostJobController", urlPatterns = {"/PostJobController"})
public class PostJobController extends HttpServlet {

    private static final String ERROR = "/view/post-a-job.jsp";
    private static final String SUCCESS = "/MainController?action=SearchJobID&searchJobID=";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String jobTitle = request.getParameter("jobtitle");
            String experienceNeeded = request.getParameter("chooseExY");
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            String[] skillID = request.getParameterValues("skillID");
            List<Integer> skillSet = new ArrayList<>();
            for (String skill : skillID) {
                skillSet.add(Integer.parseInt(skill));
            }
            Date deadline = Date.valueOf(request.getParameter("deadline"));
            String completionTime = request.getParameter("completiontime");
            String salary = request.getParameter("salary");
            String address = request.getParameter("address");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String description = request.getParameter("description");
            HttpSession session = request.getSession();
            User loginUser = (User) session.getAttribute("LOGIN_USER");
            int userID = loginUser.getUserID();
            Job job = Job.builder().userID(userID)
                    .jobTitle(jobTitle)
                    .ExperienceNeeded(experienceNeeded)
                    .category(Category.builder().categoryID(categoryID).build())
                    .deadline(deadline)
                    .completionTime(completionTime)
                    .salary(salary)
                    .address(address)
                    .email(email)
                    .phone(phone)
                    .description(description)
                    .build();
            JobDAO jobdao = new JobDAO();
            boolean check = jobdao.createJob(job);
            if (check) {
                int jobID = jobdao.getJobIDJustCreate(userID);
                request.setAttribute("MESSAGE", "Create Project Successfully!");
                url = SUCCESS + jobID;
            }

        } catch (Exception e) {
            log(e.getMessage());
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
