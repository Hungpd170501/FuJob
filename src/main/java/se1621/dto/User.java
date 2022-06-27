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
public class User {
    private int userID;
    private String password;
    private String fullName;
    private String email;
    private Date createdDate;
    private Date lastModifiedDate;
    private int userStatus;
    Role role;
    private int projectPosted;
    private int companyID;
}