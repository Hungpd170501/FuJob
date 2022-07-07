package se1621.entity;

import jakarta.persistence.*;

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
@Table(name = "tblPaymentMethods")
public class PaymentMethodEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "paymentMethodID", nullable = false)
    private Integer paymentMethodID;

    @Column(name = "paymentMethodName", nullable = false, length = 50)
    private String paymentMethodName;

    @OneToMany(mappedBy = "paymentMethod")
    private Set<JobEntity> jobs;
}
