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
public class Job {
    CompanyInfo company;
    Category category;
    List<JobSkills> listJobSkills;
    private int jobID;
    private int userID;
    private String jobTitle;
    private float minBudget;
    private float maxBudget;
    private String address;
    private String email;
    private String phone;
    private String description;
    private Date createdDate;
    private Date lastModifiedDate;
    private Date expiriedDate;
    private int jobStatus;
    private PayMentMethod payMentMethod;
    private int bids;
    private int disputeStatus;
}