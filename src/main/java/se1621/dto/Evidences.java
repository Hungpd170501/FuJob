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
public class Evidences {
    private int evidenceID;
    private Disputes disputes;
    private User user;
    private String message;
    private String evidenceFile;
    private Date createdDate;
    private Date lastModifiedDate;
}
