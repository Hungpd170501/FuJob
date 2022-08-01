package se1621.entity;

import jakarta.persistence.*;

import java.time.Instant;
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
@Table(name = "tblJobs")
public class JobEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "jobID", nullable = false)
    private Integer jobID;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "userID", nullable = false)
    @BatchSize(size = 1)
    private UserEntity user;

    @Column(name = "jobTitle")
    private String jobTitle;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "jobCategoryID")
    @BatchSize(size = 1)
    private CategoryEntity jobCategoryID;

    @Column(name = "minBudget")
    private Double minBudget;
    
    @Column(name = "maxBudget")
    private Double maxBudget;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "paymentMethodID")
    @BatchSize(size = 1)
    private PaymentMethodEntity paymentMethod;

    @Column(name = "address", length = 100)
    private String address;

    @Column(name = "email")
    private String email;

    @Column(name = "phone", length = 15)
    private String phone;

    @Column(name = "description", length = 2000)
    private String description;

    @Column(name = "createdDate")
    private Instant createdDate;

    @Column(name = "lastModifiedDate")
    private Instant lastModifiedDate;

    @Column(name = "expiriedDate")
    private Instant expiriedDate;

    @Column(name = "jobStatus", nullable = false)
    private Integer jobStatus;

    @ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinTable(name = "tblJobSkills",
            joinColumns = {
                @JoinColumn(name = "jobID")},
            inverseJoinColumns = {
                @JoinColumn(name = "skillID")})
    private Set<SkillEntity> skills;

    @OneToMany(mappedBy = "job")
    private Set<JobApplicationEntity> jobApplications;

    @Column(name = "reasonCancel", length = 2000)
    private String reasonCancel;

    @Column(name = "disputeStatus")
    private Boolean disputeStatus;

    @OneToMany(mappedBy = "job")
    @BatchSize(size = 1)
    private Set<EvaluateCompletionEntity> tblEvaluateCompletions;

}
