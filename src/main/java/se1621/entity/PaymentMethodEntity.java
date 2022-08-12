package se1621.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.Set;

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
