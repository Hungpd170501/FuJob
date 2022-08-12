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
@Table(name = "tblRoles")
public class RoleEntity {
    @Id
    @Column(name = "roleID", nullable = false, length = 50)
    private String roleID;

    @Column(name = "roleName", nullable = false, length = 50)
    private String roleName;

    @Column(name = "createdDate")
    private Instant createdDate;

    @Column(name = "lastModifiedDate")
    private Instant lastModifiedDate;

    @Column(name = "roleStatus")
    private Boolean roleStatus;

    @OneToMany(mappedBy = "role")
    private Set<UserEntity> users;
}
