/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.service;

import org.quartz.CronScheduleBuilder;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.impl.StdSchedulerFactory;

/**
 *
 * @author lehad
 */
public class CheckExpiriedDateOfJob_Main {

    public static void main(String[] args) {
        try {
            JobDetail job = JobBuilder.newJob(CheckExpiriedDateOfJob.class)
                    .withIdentity("job1", "group1").build();
            Trigger trigger = TriggerBuilder.newTrigger()
                    .withIdentity("cronTrigger1", "group1")
                    .withSchedule(CronScheduleBuilder
                            .cronSchedule("0/10 * * * * ?")).build();
            Scheduler scheduler = new StdSchedulerFactory().getScheduler();
            scheduler.start();
            scheduler.scheduleJob(job, trigger);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
