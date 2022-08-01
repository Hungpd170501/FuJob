package se1621.entity;

import jakarta.persistence.*;

import java.time.Instant;
import java.time.LocalDate;
import java.util.LinkedHashSet;
import java.util.Set;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.annotations.BatchSize;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString(onlyExplicitlyIncluded = true)
@Entity
@Table(name = "tblResumes")
public class ResumeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "resumeID", nullable = false)
    private Integer resumeID;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "userID", nullable = false)
    @BatchSize(size = 1)
    private UserEntity user;

    @Column(name = "avatar", length = 2000)
    private String avatar;

    @Column(name = "fullName", length = 50)
    private String fullName;

    @Column(name = "gender", length = 10)
    private String gender;

    @Column(name = "dateOfBirth")
    private LocalDate dateOfBirth;

    @Column(name = "gmail", length = 50)
    private String gmail;

    @Column(name = "phone", length = 20)
    private String phone;

    @Column(name = "address", length = 50)
    private String address;

    @Column(name = "major", length = 50)
    private String major;

    @Column(name = "gpa", length = 15)
    private String gpa;

    @Column(name = "website", length = 100)
    private String website;

    @Column(name = "gitHub", length = 3000)
    private String gitHub;

    @Column(name = "linkedIn", length = 3000)
    private String linkedIn;

    @Column(name = "overview", length = 3000)
    private String overview;

    @Column(name = "createdDate")
    private Instant createdDate;

    @Column(name = "lastModifiedDate")
    private Instant lastModifiedDate;

    @Column(name = "resumeStatus")
    private Integer resumeStatus;

    @ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinTable(name = "tblResumeSkills",
            joinColumns = {
                @JoinColumn(name = "resumeID")},
            inverseJoinColumns = {
                @JoinColumn(name = "skillID")})
    @Builder.Default
    private Set<SkillEntity> skills = new LinkedHashSet<>();

    @OneToMany(mappedBy = "resume")
    private Set<JobApplicationEntity> jobApplications;

    @OneToMany(mappedBy = "resume")
    private Set<EvaluateCompletionEntity> EvaluateCompletions;

}
