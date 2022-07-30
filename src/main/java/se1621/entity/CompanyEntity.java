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
@Table(name = "tblCompanies")
public class CompanyEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "companyID", nullable = false)
    private Integer companyID;

    @Column(name = "companyName", length = 50)
    private String companyName;

    @Column(name = "address", length = 50)
    private String address;

    @Column(name = "website", length = 100)
    private String website;

    @Column(name = "gmail", length = 50)
    private String gmail;

    @Column(name = "phone", length = 20)
    private String phone;

    @Column(name = "typeCompany", length = 30)
    private String typeCompany;

    @Column(name = "establishedYear")
    private Integer establishedYear;

    @Column(name = "numberOfEmployee")
    private Integer numberOfEmployee;

    @Column(name = "companyOverview", length = 3000)
    private String companyOverview;

    @Column(name = "avatar", length = 2000)
    private String avatar;

    @Column(name = "createdDate")
    private Instant createdDate;

    @Column(name = "lastModifiedDate")
    private Instant lastModifiedDate;

    @Column(name = "companyStatus")
    private Integer companyStatus;
    
    @Column(name = "businessLicense", length = 2000)
    private String businessLicense;

    @OneToMany(mappedBy = "companyID")
    private Set<UserEntity> users;
}
