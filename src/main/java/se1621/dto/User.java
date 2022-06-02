/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dto;

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
public class User {
    private int userID;
    private String username;
    private String password;
    private String fullName;
    private String phone;
    private String email;
    private int status;
    Role role;
<<<<<<< HEAD
    private int companyID;        
}
=======
    private int companyID;      
}
>>>>>>> 128d229c6b685ed8cb04b26deeaa84d14ca38160
