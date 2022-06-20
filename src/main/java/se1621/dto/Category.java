package se1621.dto;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

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
