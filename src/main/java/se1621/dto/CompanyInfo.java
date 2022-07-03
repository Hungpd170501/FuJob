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
public class CompanyInfo {
    private int companyID;
    private String companyName;
    private String address;
    private String website;
    private String gmail;
    private String phone;
    private String typeCompany;
    private int establishedYear;
    private int numberOfEmployee;
    private String companyOverview;
    private String avatar;
    private Date createdDate;
    private Date lastModifiedDate;
    private String businessLicense;
    private int companyStatus;

}