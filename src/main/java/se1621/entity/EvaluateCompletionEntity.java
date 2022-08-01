package se1621.entity;

import java.time.Instant;

import jakarta.persistence.*;
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
@Table(name = "tblEvaluateCompletion")
public class EvaluateCompletionEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "evaluateCompletionID", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "reviewerID", nullable = false)
    private UserEntity reviewer;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "jobID", nullable = false)
    private JobEntity job;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "resumeID", nullable = false)
    private ResumeEntity resume;

    @Column(name = "ratingValue")
    private Integer ratingValue;

    @Column(name = "content", length = 3000)
    private String content;

    @Column(name = "createdDate")
    private Instant createdDate;

    @Column(name = "lastModifiedDate")
    private Instant lastModifiedDate;

    @Column(name = "evaluateCompletionStatus")
    private Integer evaluateCompletionStatus;
}
