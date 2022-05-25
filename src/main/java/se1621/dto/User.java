/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dto;



public class User {
    private String userID;
    private String password;
    private String fullName;
    private String email;
    private String roleID;
    private boolean status;

    public User(String userID, String password, String fullName, String email, String roleID, boolean status) {
        this.userID = userID;
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.roleID = roleID;
        this.status = status;
    }

    public User() {
        this.userID = "";
        this.password = "";
        this.fullName = "";
        this.email = "";
        this.roleID = "";
        this.status = true;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRoleID() {
        return roleID;
    }

    public void setRoleID(String roleID) {
        this.roleID = roleID;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "User{" + "userID=" + userID + ", password=" + password + ", fullName=" + fullName + ", email=" + email + ", roleID=" + roleID + ", status=" + status + '}';
    }
    
    
    
    

    
    
}
