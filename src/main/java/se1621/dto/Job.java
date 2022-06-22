package se1621.dto;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
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
    CompanyInfo company;
    Category category;
    private int budget;
    private int paymentMethodID;
    private String address;
    private String email;
    private String phone;
    private String description;
    private Date createdDate;
    private Date lastModifiedDate;
    private Date expiriedDate;
    List<JobSkills> listJobSkills;
    private int jobStatus;
}
