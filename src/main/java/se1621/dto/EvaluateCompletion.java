package se1621.dto;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EvaluateCompletion {
    private int evaluateCompletionID;
    private User reviewer;
    private Resume resume;
    private Job job;
    private int ratingValue;
    private String content;
    private Date createdDate;
    private Date lastModifiedDate;
    // 3 Completed
    // 4 UnCompleted
    private int evaluateCompletionStatus;
}
