package se1621.entity;

import jakarta.persistence.*;

import java.time.Instant;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

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

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "resumeID", nullable = false)
    private ResumeEntity resume;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "jobID", nullable = false)
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
}
