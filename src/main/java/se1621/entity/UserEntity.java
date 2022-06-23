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

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString(onlyExplicitlyIncluded = true)
@Entity
@Table(name = "tblUsers")
public class UserEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "userID", nullable = false)
    private Integer userID;

    @Column(name = "password", nullable = false, length = 500)
    private String password;

    @Column(name = "fullName", nullable = false, length = 50)
    private String fullName;

    @Column(name = "email", length = 50)
    private String email;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "roleID")
    private RoleEntity role;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "companyID")
    private CompanyEntity companyID;

    @Column(name = "createdDate")
    private Instant createdDate;

    @Column(name = "lastModifiedDate")
    private Instant lastModifiedDate;

    @Column(name = "userStatus")
    private Integer userStatus;

    @OneToMany(mappedBy = "user")
    private Set<ResumeEntity> resumes;

    @OneToMany(mappedBy = "user")
    private Set<JobEntity> jobs;
}