/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dto.Error;

/**
 *
 * @author HNGB
 */
public class UserError {

    private String userIDError;
    private String passwordError;
    private String fullNameError;
    private String emailError;
    private String roleIDError;
    private boolean statusError;

    public UserError(String userIDError, String passwordError, String fullNameError, String emailError, String roleIDError, boolean statusError) {
        this.userIDError = userIDError;
        this.passwordError = passwordError;
        this.fullNameError = fullNameError;
        this.emailError = emailError;
        this.roleIDError = roleIDError;
        this.statusError = statusError;
    }

    public UserError() {
        this.userIDError = "";
        this.passwordError = "";
        this.fullNameError = "";
        this.emailError = "";
        this.roleIDError = "";
        this.statusError = true;
    }

    public String getUserIDError() {
        return userIDError;
    }

    public void setUserIDError(String userIDError) {
        this.userIDError = userIDError;
    }

    public String getPasswordError() {
        return passwordError;
    }

    public void setPasswordError(String passwordError) {
        this.passwordError = passwordError;
    }

    public String getFullNameError() {
        return fullNameError;
    }

    public void setFullNameError(String fullNameError) {
        this.fullNameError = fullNameError;
    }

    public String getEmailError() {
        return emailError;
    }

    public void setEmailError(String emailError) {
        this.emailError = emailError;
    }

    public String getRoleIDError() {
        return roleIDError;
    }

    public void setRoleIDError(String roleIDError) {
        this.roleIDError = roleIDError;
    }

    public boolean isStatusError() {
        return statusError;
    }

    public void setStatusError(boolean statusError) {
        this.statusError = statusError;
    }

    @Override
    public String toString() {
        return "UserError{" + "userIDError=" + userIDError + ", passwordError=" + passwordError + ", fullNameError=" + fullNameError + ", emailError=" + emailError + ", roleIDError=" + roleIDError + ", statusError=" + statusError + '}';
    }

}
