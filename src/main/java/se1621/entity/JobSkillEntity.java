package se1621.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "tblJobSkills")
public class JobSkillEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "jobSkillID", nullable = false)
    private Integer jobSkillID;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "jobID", nullable = false)
    private JobEntity jobID;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "skillID", nullable = false)
    private SkillEntity skillID;

    public Integer getJobSkillID() {
        return jobSkillID;
    }

    public void setJobSkillID(Integer jobSkillID) {
        this.jobSkillID = jobSkillID;
    }

    public JobEntity getJobID() {
        return jobID;
    }

    public void setJobID(JobEntity jobID) {
        this.jobID = jobID;
    }

    public SkillEntity getSkillID() {
        return skillID;
    }

    public void setSkillID(SkillEntity skillID) {
        this.skillID = skillID;
    }

}
