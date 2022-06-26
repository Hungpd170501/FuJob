/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dto.Error;

public class CompanyInfoError {

    private int companyIDError;
    private String companyNameError;
    private String addressError;
    private String websiteError;
    private String gmailError;
    private String phoneError;
    private String typeCompanyError;
    private String establishedYearError;
    private int numberOfEmployeeError;
    private String companyOverviewError;
    private String avatarError;

    public CompanyInfoError(int companyIDError, String companyNameError, String addressError, String websiteError, String gmailError, String phoneError, String typeCompanyError, String establishedYearError, int numberOfEmployeeError, String companyOverviewError, String avatarError) {
        this.companyIDError = companyIDError;
        this.companyNameError = companyNameError;
        this.addressError = addressError;
        this.websiteError = websiteError;
        this.gmailError = gmailError;
        this.phoneError = phoneError;
        this.typeCompanyError = typeCompanyError;
        this.establishedYearError = establishedYearError;
        this.numberOfEmployeeError = numberOfEmployeeError;
        this.companyOverviewError = companyOverviewError;
        this.avatarError = avatarError;
    }

    public CompanyInfoError() {
        this.companyIDError = 0;
        this.companyNameError = "";
        this.addressError = "";
        this.websiteError = "";
        this.gmailError = "";
        this.phoneError = "";
        this.typeCompanyError = "";
        this.establishedYearError = "";
        this.numberOfEmployeeError = 0;
        this.companyOverviewError = "";
        this.avatarError = "";
    }

    public int getCompanyIDError() {
        return companyIDError;
    }

    public void setCompanyIDError(int companyIDError) {
        this.companyIDError = companyIDError;
    }

    public String getCompanyNameError() {
        return companyNameError;
    }

    public void setCompanyNameError(String companyNameError) {
        this.companyNameError = companyNameError;
    }

    public String getAddressError() {
        return addressError;
    }

    public void setAddressError(String addressError) {
        this.addressError = addressError;
    }

    public String getWebsiteError() {
        return websiteError;
    }

    public void setWebsiteError(String websiteError) {
        this.websiteError = websiteError;
    }

    public String getGmailError() {
        return gmailError;
    }

    public void setGmailError(String gmailError) {
        this.gmailError = gmailError;
    }

    public String getPhoneError() {
        return phoneError;
    }

    public void setPhoneError(String phoneError) {
        this.phoneError = phoneError;
    }

    public String getTypeCompanyError() {
        return typeCompanyError;
    }

    public void setTypeCompanyError(String typeCompanyError) {
        this.typeCompanyError = typeCompanyError;
    }

    public String getEstablishedYearError() {
        return establishedYearError;
    }

    public void setEstablishedYearError(String establishedYearError) {
        this.establishedYearError = establishedYearError;
    }

    public int getNumberOfEmployeeError() {
        return numberOfEmployeeError;
    }

    public void setNumberOfEmployeeError(int numberOfEmployeeError) {
        this.numberOfEmployeeError = numberOfEmployeeError;
    }

    public String getCompanyOverviewError() {
        return companyOverviewError;
    }

    public void setCompanyOverviewError(String companyOverviewError) {
        this.companyOverviewError = companyOverviewError;
    }

    public String getAvatarError() {
        return avatarError;
    }

    public void setAvatarError(String avatarError) {
        this.avatarError = avatarError;
    }

    @Override
    public String toString() {
        return "CompanyInfoError{" + "companyIDError=" + companyIDError + ", companyNameError=" + companyNameError + ", addressError=" + addressError + ", websiteError=" + websiteError + ", gmailError=" + gmailError + ", phoneError=" + phoneError + ", typeCompanyError=" + typeCompanyError + ", establishedYearError=" + establishedYearError + ", numberOfEmployeeError=" + numberOfEmployeeError + ", companyOverviewError=" + companyOverviewError + ", avatarError=" + avatarError + '}';
    }

}
