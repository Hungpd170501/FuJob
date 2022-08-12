/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dto;

import lombok.*;

import java.sql.Date;

/**
 * @author lehad
 */
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SubmitJob {
    private int submitJobID;
    private int jobApplicationID;
    private String messageSubmit;
    private String jobFile;
    private Date createdDate;
    private Date lastModifiedDate;
    private int submitJobStatus;

}

