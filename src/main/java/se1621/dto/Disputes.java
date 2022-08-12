/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dto;

import lombok.*;

import java.sql.Date;

/**
 * @author HNGB
 */
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Disputes {
    private int disputeID;
    private String title;
    private String message;
    private JobApplication jobApplication;
    private User user;
    private String reasonCancelDispute;
    private Date createdDate;
    private Date lastModifiedDate;
    private int disStatus;
    private Evidences evidence;
}
