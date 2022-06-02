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
<<<<<<< HEAD
=======
    CompanyInfo company;
>>>>>>> 128d229c6b685ed8cb04b26deeaa84d14ca38160
    Category category;
    private String skill;
    private Date deadline;
    private String completionTime;
    private String salary;
    private String address;
    private String email;
    private String phone;
    private String description;

    
}