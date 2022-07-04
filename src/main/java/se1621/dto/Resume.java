package se1621.dto;

import lombok.*;

import java.sql.Date;
import java.util.List;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Resume {
    private int resumeID;
    private int userID;
    private String avatar;
    private String fullName;
    private String gender;
    private Date dateOfBirth;
    private String gmail;
    private String phone;
    private String address;
    private String major;
    private String gpa;
    private String website;
    private String gitHub;
    private String linkedIn;
    private String overview;
    private Date createdDate;
    private Date lastModifiedDate;
    private int resumeStatus;
    List<ResumeSkill> listResumeSkills;
}