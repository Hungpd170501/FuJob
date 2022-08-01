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

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString(onlyExplicitlyIncluded = true)
@Entity
@Table(name = "tblDisputes")
public class DisputeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "disputeID", nullable = false)
    private Integer id;

    @Column(name = "userID", nullable = false)
    private Integer userID;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "jobApplicationID", nullable = false)
    private JobApplicationEntity jobApplication;

    @Column(name = "title", nullable = false, length = 3000)
    private String title;

    @Column(name = "message", nullable = false, length = 3000)
    private String message;

    @Column(name = "createdDate")
    private Instant createdDate;

    @Column(name = "lastModifiedDate")
    private Instant lastModifiedDate;

    @Column(name = "reasonCancelDispute", length = 3000)
    private String reasonCancelDispute;

    @Column(name = "disputeStatus")
    private Integer disputeStatus;

    @OneToMany(mappedBy = "dispute")
    @BatchSize(size = 2)
    private Set<EvidenceEntity> evidences;
}
