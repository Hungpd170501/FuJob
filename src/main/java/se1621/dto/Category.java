package se1621.dto;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Category {
    public int categoryID;
    public String categoryName;
    public String img;
    public Date createdDate;
    public Date lastModifiedDate;
    public int categoryStatus;

}