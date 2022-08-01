package se1621.entity;

import jakarta.persistence.*;

import java.time.Instant;
import java.util.Set;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.annotations.BatchSize;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString(onlyExplicitlyIncluded = true)
@Entity
@Table(name = "tblJobApplications")
public class JobApplicationEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "jobApplicationID", nullable = false)
    private Integer jobApplicationID;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "resumeID", nullable = false)
    @BatchSize(size = 1)
    private ResumeEntity resume;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "jobID", nullable = false)
    @BatchSize(size = 1)
    private JobEntity job;

    @Lob
    @Column(name = "cvFile")
    private String cvFile;

    @Column(name = "priceDeal", length = 50)
    private String priceDeal;

    @Column(name = "message", length = 2000)
    private String message;

    @Column(name = "createdDate")
    private Instant createdDate;

    @Column(name = "lastModifiedDate")
    private Instant lastModifiedDate;

    @Column(name = "jobApplicationStatus", nullable = false)
    private Integer jobApplicationStatus;

    @Column(name = "reasonRejection", length = 2000)
    private String reasonRejection;

    @Column(name = "reasonUnaplly", length = 2000)
    private String reasonUnaplly;

    @Column(name = "reasonRejectSubmit", length = 2000)
    private String reasonRejectSubmit;

    @Fetch(FetchMode.SELECT)
    @BatchSize(size=1)
    @OneToMany(mappedBy = "jobApplication")
    private Set<SubmitJobEntity> submitJob;

    @OneToMany(mappedBy = "jobApplication")
    private Set<DisputeEntity> disputes;

}
