/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.service;
import java.util.Date;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
/**
 *
 * @author lehad
 */
public class CheckExpiriedDateOfJob implements Job{
    public void execute (JobExecutionContext context)throws JobExecutionException{
        System.out.println("Job is checking " + new Date());
    }
}
