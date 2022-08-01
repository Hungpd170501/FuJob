package se1621.entity;

import jakarta.persistence.*;

import java.time.LocalDate;
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
@Table(name = "tblEvidences")
public class EvidenceEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "evidenceID", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "disputeID", nullable = false)
    private DisputeEntity dispute;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "userID", nullable = false)
    @BatchSize(size = 1)
    private UserEntity user;

    @Column(name = "message", nullable = false, length = 3000)
    private String message;

    @Column(name = "evidenceFile", nullable = false, length = 3000)
    private String evidenceFile;

    @Column(name = "createdDate")
    private LocalDate createdDate;

    @Column(name = "lastModifiedDate")
    private LocalDate lastModifiedDate;
}
