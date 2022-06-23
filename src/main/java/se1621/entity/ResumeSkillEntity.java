package se1621.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "tblResumeSkills")
public class ResumeSkillEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "resumeSkillID", nullable = false)
    private Integer resumeSkillID;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "resumeID", nullable = false)
    private ResumeEntity resumeID;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "skillID", nullable = false)
    private SkillEntity skillID;

    public Integer getResumeSkillID() {
        return resumeSkillID;
    }

    public void setResumeSkillID(Integer resumeSkillID) {
        this.resumeSkillID = resumeSkillID;
    }

    public ResumeEntity getResumeID() {
        return resumeID;
    }

    public void setResumeID(ResumeEntity resumeID) {
        this.resumeID = resumeID;
    }

    public SkillEntity getSkillID() {
        return skillID;
    }

    public void setSkillID(SkillEntity skillID) {
        this.skillID = skillID;
    }

}
