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
import se1621.dao.JobSkillsDAO;
import se1621.dto.Category;
import se1621.dto.Job;
import se1621.dto.JobSkills;
import se1621.dto.PayMentMethod;
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
            int jobID = 0;
            String jobIDString = request.getParameter("jobID");
            if (!jobIDString.isBlank()) {
                jobID = Integer.parseInt(jobIDString);
            }
            String jobTitle = request.getParameter("jobTitle");
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            String[] skillID = request.getParameterValues("skillID");
            int paymentMethodID = Integer.parseInt(request.getParameter("paymentMethodID"));
            List<Integer> skillSet = new ArrayList<>();
            for (String skill : skillID) {
                skillSet.add(Integer.parseInt(skill));
            }
            Date expiriedDate = Date.valueOf(request.getParameter("expiriedDate"));
            float minBudget = Float.parseFloat(request.getParameter("minBudget"));
            float maxBudget = Float.parseFloat(request.getParameter("maxBudget"));
            String address = request.getParameter("address");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String description = request.getParameter("description");
            HttpSession session = request.getSession();
            User loginUser = (User) session.getAttribute("LOGIN_USER");
            int userID = loginUser.getUserID();
            Job job = Job.builder()
                    .jobID(jobID)
                    .userID(userID)
                    .jobTitle(jobTitle)
                    .category(Category.builder().categoryID(categoryID).build())
                    .address(address)
                    .payMentMethod(PayMentMethod.builder().paymentMethodID(paymentMethodID).build())
                    .email(email)
                    .expiriedDate(expiriedDate)
                    .phone(phone)
                    .minBudget(minBudget)
                    .maxBudget(maxBudget)
                    .description(description)
                    .build();
            JobDAO jobdao = new JobDAO();
            JobSkillsDAO jsDAO = new JobSkillsDAO();
            List<JobSkills> listJobSkills = new ArrayList<>();
            List<JobSkills> listJs = jsDAO.getSkillRequire(jobID);
            if (!listJs.isEmpty()) {
                jsDAO.deleteJobSkills(jobID);
            }
            Job checkJob = jobdao.getJob(jobID);
            if (checkJob.getJobID()>0) {
                //neu job da ton tai thi tien hanh update
                if (jobdao.updateJob(job)) {
                    //update thanh cong thi set skill
                    for (Integer skillId : skillSet) {
                        JobSkills jobSkills = JobSkills.builder().jobID(jobID).skill(Skill.builder().skillID(skillId).build()).build();
                        listJobSkills.add(jobSkills);
                    }
                    List<Boolean> listCheckCreateJobSkill = new ArrayList<>();
                    for (JobSkills jobSkills : listJobSkills) {
                        boolean checkCreateSkillRequire = jsDAO.createSkillRequire(jobSkills);
                        if (checkCreateSkillRequire) {
                            listCheckCreateJobSkill.add(checkCreateSkillRequire);
                        }
                    }
                    if (!listCheckCreateJobSkill.contains(false)) {
                        request.setAttribute("MESSAGE_JOB", "Update Project Successfull!");
                        url = SUCCESS + jobID;
                    }
                } else {
                    //update k thanh cong thi loi
                    url = ERROR;
                }
            } else {
                //job chua ton tai thi tao moi
                if (jobdao.createJob(job)) {
                    jobID = jobdao.getJobIDJustCreate(userID);
                    for (Integer skill : skillSet) {
                        JobSkills jobSkills = JobSkills.builder().jobID(jobID).skill(Skill.builder().skillID(skill).build()).build();
                        listJobSkills.add(jobSkills);
                    }
                    List<Boolean> listCheckCreateJobSkill = new ArrayList<>();
                    for (JobSkills jobSkills : listJobSkills) {
                        boolean checkCreateSkillRequire = jsDAO.createSkillRequire(jobSkills);
                        if (checkCreateSkillRequire) {
                            listCheckCreateJobSkill.add(checkCreateSkillRequire);
                        }
                    }
                    if (!listCheckCreateJobSkill.contains(false)) {
                        request.setAttribute("MESSAGE_JOB", "Post Project Successfull!");
                        url = SUCCESS + jobID;
                    }
                } else {
                    //tao k thanh cong thi loi
                    url = ERROR;
                }
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
