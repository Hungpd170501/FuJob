/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dto;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Job {
    private int jobID;
    private int userID;
    private String jobTitle;
    private String ExperienceNeeded;
    CompanyInfo company;
    Category category;
    Skill skill;
    private Date deadline;
    private String completionTime;
    private String salary;
    private String address;
    private String email;
    private String phone;
    private String description;
    private Date lastDateUpdate;
    private int jobStatus;
}
