/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.service;

import java.util.Date;
import java.util.List;
import org.quartz.CronScheduleBuilder;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.impl.StdSchedulerFactory;
import org.quartz.impl.matchers.GroupMatcher;

/**
 *
 * @author lehad
 */
public class CheckExpiriedDateOfJob_Main {

    public static void main(String[] args) {
        try {
            JobDetail job = JobBuilder.newJob(CheckExpiriedDateOfJob.class)
                    .withIdentity("job", "group").build();
            Trigger trigger = TriggerBuilder.newTrigger()
                    .withIdentity("cronTrigger", "group")
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
