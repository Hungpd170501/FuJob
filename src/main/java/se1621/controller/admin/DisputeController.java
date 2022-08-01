package se1621.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import se1621.dao.v2.DisputeDAO;
import se1621.dao.v2.DisputeDAOImpl;
import se1621.entity.DisputeEntity;

import java.io.IOException;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

import static java.util.stream.Collectors.groupingBy;
import static java.util.stream.Collectors.toList;

@WebServlet(name = "DisputeController", value = "/DisputeController")
public class DisputeController extends HttpServlet {
    private static final String ERROR = "/view/error.jsp";
    private static final String SUCCESS = "/WEB-INF/viewAdmin/disputes-list.jsp";
    private static final Map<Integer, String> disputeStatusMap  = new HashMap<Integer, String>() {{
        put(0, "CLOSED");
        put(1, "OPEN");
        put(2, "RESOLVED");
    }};

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            DisputeDAO disputeDAO = new DisputeDAOImpl();
            Instant currentDayMinusThree
                    = Calendar.getInstance().toInstant()
                    .minus(3, ChronoUnit.DAYS);
            List<DisputeEntity> listAllDispute
                    = disputeDAO
                    .getAllUsingHQL("select distinct d from DisputeEntity d left join fetch d.jobApplication left join fetch d.evidences");
            Map<Integer, List<DisputeEntity>> listDisputeByStatus
                    = listAllDispute.stream()
                    .filter(e -> (e.getDisputeStatus() != null ) && e.getCreatedDate().isAfter(currentDayMinusThree))
                    .collect(groupingBy(DisputeEntity::getDisputeStatus, toList()));
            listDisputeByStatus.forEach((key, value)->{
                String statusString=disputeStatusMap.get(key);
                request.setAttribute(statusString+"_DISPUTE_LIST", value);
                request.setAttribute("COUNT_DISPUTE_"+statusString, value.size());
            });
            url = SUCCESS;
        } catch (Exception e) {
            log("Error at DisputeController: " + e);
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
