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
public class Resume {
    private int resumeID;
    private int userID;
    private String avartar;
    private String fullName;
    private String gender;
    private Date dateOfBirth;
    private String gmail;
    private String phone;
    private String address;
    private String schoolName;
    private String major;
    private String gpa;
    private String experienceYear;
    private String skills;
    private String website;
    private String overview;
}

