package se1621.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.Instant;
import java.util.Set;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString(onlyExplicitlyIncluded = true)
@Entity
@Table(name = "tblCategories")
public class CategoryEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "categoryID", nullable = false)
    private Integer categoryID;

    @Column(name = "categoryName", nullable = false, length = 50)
    private String categoryName;

    @Column(name = "img", length = 2000)
    private String img;

    @Column(name = "createdDate")
    private Instant createdDate;

    @Column(name = "lastModifiedDate")
    private Instant lastModifiedDate;

    @Column(name = "categoryStatus")
    private Boolean categoryStatus;

    @OneToMany(mappedBy = "jobCategoryID", cascade = CascadeType.ALL)
    private Set<JobEntity> jobs;
}
