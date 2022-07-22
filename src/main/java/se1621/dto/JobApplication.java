/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dto;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class JobApplication {
    private int jobApplicationID;
    private int resumeID;
    Job job;
    Resume resume;
    SubmitJob submitJob;
    private String cvFile;
    private String priceDeal;
    private String message;
    private Date createdDate;
    private Date lastModifiedDate;
    private int jobApplicationStatus;
    private String reasonRejection;
    private String reasonRejectionSubmmit;
    EvaluateCompletion evaluateCompletion;
}