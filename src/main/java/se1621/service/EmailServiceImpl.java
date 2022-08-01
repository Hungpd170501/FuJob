package se1621.service;

import jakarta.servlet.ServletContext;
import se1621.dto.User;
import se1621.utils.EmailUtils;
import se1621.utils.JwtTokenUtils;

public class EmailServiceImpl implements EmailService {

    private static final String EMAIL_WELCOME_SUBJECT = "Welcome to FuJob";
    private static final String EMAIL_FORGOT_PASSWORD = "Reset your FuJob password";
    private static final String EMAIL_VERIFY = "FuJob email verification";

    @Override
    public void sendEmail(ServletContext context, User repliient, String type) {
        String host = context.getInitParameter("host");
        String port = context.getInitParameter("port");
        String user = context.getInitParameter("user");
        String pass = context.getInitParameter("pass");
        try {
            String content = null;
            String subject = null;
            switch (type) {
                case "welcome":
                    subject = EMAIL_WELCOME_SUBJECT;
                    content = "<center> <table style=\"max-width:570px; font-family:Arial,sans-serif; box-sizing: border-box;\"> <tr> <td> <img style=\"height:auto !important; width: 100% !important;\" src=\"https://www.worldhappiness.com/wp-content/uploads/emails/signup-completed.jpg\"> <img src=\"https://drive.google.com/uc?export=view&id=12boe6KyjxLNnCm9SlwVzhLojDjTUhchP\" style=\"height:20% !important;max-width:570px !important;width: 20% !important; display: block;margin: auto; width:570\"> </td> </tr> <tr> <td style=\"word-break: break-word; text-align:left\"> <h1 style=\"color: #2f3133; font-size: 19px; font-weight: bold;\"> Welcome to FuJob.</h1> </td> </tr> <tr> <td style=\"text-align:left; font-size:16px;\"> <p style=\"color:#74787e; line-height:1.5em; margin-top:0;\"> Thank you for creating an FuJob account.For the next 12 months, you'll have free access to all FuJob services within the limits. </p> <p style=\"color:#74787e; line-height:1.5em; margin-top:0\"> If you are unable to access FuJob Services, please note that some services may take up to 24 hours to fully activate. If you &#39;re still unable to access FuJob Services after that time, please visit <a href=\"#\" style=\"text-decoration:none\">FuJob Support.</a> </p> </td> </tr> <tr> <td style=\"text-align: center; font-size:16px;\"> <a href=\"http://localhost:8080/FuJob/\" style=\"margin:auto; background:#e50555;border-color:#e50555;border-radius:4px;border-style:solid;border-width:15px 25px;box-sizing:border-box;color:#ffffff;display:inline-block;font-size:16px;text-decoration:none;font-weight:bold\" target=\"_blank\">Getting Started Resources &gt;&gt; </a> </td> </tr> <tr> <td style=\"text-align:left; font-size: 16px;\"> <p style=\"color:#74787e;line-height:1.5em;margin-top:20\">Welcome to the FuJob community! If you have a moment, share FuJob with friends.</p> <p style=\"color:#74787e;line-height:1.5em;margin-top:0\"> Cheers, <br> The FuJob<sup>®</sup> Team </p> </td> </tr> <tr> <td style=\"text-align:left; font-size: 16px; ;padding:0px 35px; word-break:break-word\"> <table width=\"100%\" cellpadding=\"20\" cellspacing=\"0\"> <tbody> <tr> <td align=\"center\"> <table cellpadding=\"0\" cellspacing=\"0\"> <tbody> <tr style=\"font-size:0pt;line-height:0pt;text-align:left\"> <td width=\"50\"> <a href=\"https://www.facebook.com\" target=\"_blank\"> <img src=\"https://ci6.googleusercontent.com/proxy/ar0u61ZlE5KcjjPLlWpOzNYiIDf6Y36MSanKxMjCvai0-BwHjGNkXysRF_gP1YqGDgHF_nMxBshl_C5TlukDKarwL0RNOnZlo5OpbKV4UUbjzXYXswxScl8=s0-d-e1-ft#https://www.worldhappiness.com/wp-content/uploads/facebook-circled.png\" width=\"50\" height=\"50\" alt=\"Facebook\"> </a> </td> <td style=\"font-size:0pt;line-height:0pt;text-align:left\" width=\"50\"> <a href=\"https://twitter.com\" target=\"_blank\"> <img src=\"https://ci4.googleusercontent.com/proxy/H0r_tJCPO4tH_ANsF6XU4f18QYDfcrEjfv9llRzspmeHeaITbYqeTXvSsjVPWhqyHKXmIE-B6Q4GhYY05UVMOJOoaMVcwBt1J3OA2E4touhVvlaCaLqV6w=s0-d-e1-ft#https://www.worldhappiness.com/wp-content/uploads/twitter-circled.png\" width=\"50\" height=\"50\" alt=\"Twitter\"> </a> </td> <td style=\"font-size:0pt;line-height:0pt;text-align:left;padding:4px\" width=\"44\"> <a href=\"https://www.youtube.com\" target=\"_blank\"> <img src=\"https://ci3.googleusercontent.com/proxy/WPIeLc6vGeHaODEcjoPxh8kW-7Xg8CRG4DLM36K_2GcrwxP0NpDXuXDBTxviwpOrcaAHJDRs3ELCBrFeXputLUvcnhIIIQI7xQPUHaSrVQ=s0-d-e1-ft#https://img.icons8.com/flat_round/64/000000/youtube-play.png\" width=\"43\" height=\"43\" alt=\"Youtube\"> </a> </td> <td style=\"font-size:0pt;line-height:0pt;text-align:left\" width=\"41\"> <a href=\"https://www.instagram.com\" target=\"_blank\"> <img src=\"https://ci5.googleusercontent.com/proxy/9TnPMzHVMsv52kwLnEtC7zKWG3euehio24UnVM-kYsK9fqzfZkJVPP1lTBLEDoDcZdK7BsOSbNaU8rQr1bynLkdOwPR5yDDXTGBHqr04AxDLEHnE9z9eS3k=s0-d-e1-ft#https://www.worldhappiness.com/wp-content/uploads/linkedin-circled.png\" width=\"50\" height=\"50\" alt=\"Instagram\"> </a> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> <p style=\"color:#bbbfc3;font-size:12px;line-height:1.5em;margin-top:0; text-align: center;\">© 2022 FuJob. All rights reserved.</p> <p style=\"color:#bbbfc3;font-size:12px;line-height:1.5em;margin-top:0; text-align: center;\">District 9, HCM City. </p> </td> </tr> </table> </center>";
                    break;
                case "forgot":
                    JwtTokenUtils jwtTokenUtils = new JwtTokenUtils();
                    String token = jwtTokenUtils.generateToken(repliient);
                    subject = EMAIL_FORGOT_PASSWORD;
                    content ="<center> <table style=\"max-width:570px; font-family:Arial,sans-serif; box-sizing: border-box;\"> <tr> <td> <img style=\"height:auto !important; width: 100% !important;\" src=\"https://ci6.googleusercontent.com/proxy/7ItXCchrwnraVo29StcLG2NrMw-7vOYDAH9Opk5A9SBNV3Vt4BpuOJNvnYj4jpvTi7eSdCN9AdwVoouvaEnNcpjNz3OYSv0yOETbXg=s0-d-e1-ft#https://cctvapp.net/wp-content/uploads/2021/06/pwd1-1.jpg\"> <img src=\"https://drive.google.com/uc?export=view&id=12boe6KyjxLNnCm9SlwVzhLojDjTUhchP\" style=\"height:20% !important;max-width:570px !important;width: 20% !important; display: block;margin: auto; width:570\"> </td> </tr> <tr> <td style=\"word-break: break-word; text-align:left\"> <h1 style=\"color: #2f3133; font-size: 19px; font-weight: bold;\"> FuJob password reset</h1> </td> </tr> <tr> <td style=\"text-align:left; font-size:16px;\"> <p style=\"color:#74787e; line-height:1.5em; margin-top:0;\"> We heard that you lost your FuJob password. Sorry about that! </p> <p style=\"color:#74787e; line-height:1.5em; margin-top:0\"> But do not worry! You can use the following button to reset your password: </p> </td> </tr> <tr> <td style=\"text-align: center; font-size:16px;\"> <a href=\"http://localhost:8080/FuJob/RecoveryPasswordHandler?token="+token+"\" style=\"margin:auto; background:#210666;border-color:#210666;border-radius:4px;border-style:solid;border-width:15px 25px;box-sizing:border-box;color:#ffffff;display:inline-block;font-size:16px;text-decoration:none;font-weight:bold\" target=\"_blank\">Reset your password </a> </td> </tr> <tr> <td style=\"text-align:left; font-size: 16px;\"> <p style=\"color:#74787e;line-height:1.5em;margin-top:20\">If you do not use this link within 15 min, it will expire. To get a new password reset link, visit: <a href=\"http://localhost:8080/FuJob/view/recovery_password.jsp\" target=\"_blank\">link.</a> </p> <p style=\"color:#74787e;line-height:1.5em;margin-top:0\"> Thanks, <br> The FuJob<sup>®</sup> Team </p> </td> </tr> <tr> <td style=\"text-align:left; font-size: 16px; ;padding:0px 35px; word-break:break-word\"> <table width=\"100%\" cellpadding=\"20\" cellspacing=\"0\"> <tbody> <tr> <td align=\"center\"> <table cellpadding=\"0\" cellspacing=\"0\"> <tbody> <tr style=\"font-size:0pt;line-height:0pt;text-align:left\"> <td width=\"50\"> <a href=\"https://www.facebook.com\" target=\"_blank\"> <img src=\"https://ci6.googleusercontent.com/proxy/ar0u61ZlE5KcjjPLlWpOzNYiIDf6Y36MSanKxMjCvai0-BwHjGNkXysRF_gP1YqGDgHF_nMxBshl_C5TlukDKarwL0RNOnZlo5OpbKV4UUbjzXYXswxScl8=s0-d-e1-ft#https://www.worldhappiness.com/wp-content/uploads/facebook-circled.png\" width=\"50\" height=\"50\" alt=\"Facebook\"> </a> </td> <td style=\"font-size:0pt;line-height:0pt;text-align:left\" width=\"50\"> <a href=\"https://twitter.com\" target=\"_blank\"> <img src=\"https://ci4.googleusercontent.com/proxy/H0r_tJCPO4tH_ANsF6XU4f18QYDfcrEjfv9llRzspmeHeaITbYqeTXvSsjVPWhqyHKXmIE-B6Q4GhYY05UVMOJOoaMVcwBt1J3OA2E4touhVvlaCaLqV6w=s0-d-e1-ft#https://www.worldhappiness.com/wp-content/uploads/twitter-circled.png\" width=\"50\" height=\"50\" alt=\"Twitter\"> </a> </td> <td style=\"font-size:0pt;line-height:0pt;text-align:left;padding:4px\" width=\"44\"> <a href=\"https://www.youtube.com\" target=\"_blank\"> <img src=\"https://ci3.googleusercontent.com/proxy/WPIeLc6vGeHaODEcjoPxh8kW-7Xg8CRG4DLM36K_2GcrwxP0NpDXuXDBTxviwpOrcaAHJDRs3ELCBrFeXputLUvcnhIIIQI7xQPUHaSrVQ=s0-d-e1-ft#https://img.icons8.com/flat_round/64/000000/youtube-play.png\" width=\"43\" height=\"43\" alt=\"Youtube\"> </a> </td> <td style=\"font-size:0pt;line-height:0pt;text-align:left\" width=\"41\"> <a href=\"https://www.instagram.com\" target=\"_blank\"> <img src=\"https://ci5.googleusercontent.com/proxy/9TnPMzHVMsv52kwLnEtC7zKWG3euehio24UnVM-kYsK9fqzfZkJVPP1lTBLEDoDcZdK7BsOSbNaU8rQr1bynLkdOwPR5yDDXTGBHqr04AxDLEHnE9z9eS3k=s0-d-e1-ft#https://www.worldhappiness.com/wp-content/uploads/linkedin-circled.png\" width=\"50\" height=\"50\" alt=\"Instagram\"> </a> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> <p style=\"color:#bbbfc3;font-size:12px;line-height:1.5em;margin-top:0; text-align: center;\">© 2022 FuJob. All rights reserved.</p> <p style=\"color:#bbbfc3;font-size:12px;line-height:1.5em;margin-top:0; text-align: center;\">District 9, HCM City. </p> </td> </tr> </table> </center>"; 
                    break;
                case "verify":
                    JwtTokenUtils jwtTokenUtilsA = new JwtTokenUtils();
                    String verifyEmailToken = jwtTokenUtilsA.generateVerifyEmailToken(repliient);
                    subject = EMAIL_VERIFY;
                    content ="<center> <table style=\"max-width:570px; font-family:Arial,sans-serif; box-sizing: border-box;\"> <tr> <td> <img style=\"height:auto !important; width: 100% !important;\" src=\"https://blog-consumer.glassdoor.com/app/uploads/sites/2/iStock-504243026-e1514926306494-1024x560.jpg\"> <img src=\"https://drive.google.com/uc?export=view&id=12boe6KyjxLNnCm9SlwVzhLojDjTUhchP\" style=\"height:20% !important;max-width:570px !important;width: 20% !important; display: block;margin: auto; width:570\"> </td> </tr> <tr> <td style=\"word-break: break-word; text-align:left\"> <h1 style=\"color: #2f3133; font-size: 19px; font-weight: bold;\"> Thanks for signing up for FuJob!</h1> </td> </tr> <tr> <td style=\"text-align:left; font-size:16px;\"> <p style=\"color:#74787e; line-height:1.5em; margin-top:0;\"> Please confirm your account by clicking the button below: </p> </td> </tr> <tr> <td style=\"text-align: left; font-size:16px;\"> <a href=\"http://localhost:8080/FuJob/EmailVerifyHandler?token="+verifyEmailToken+"\" style=\"margin:auto; background:#687df1; border-color: #687df1;border-radius:4px;border-style:solid;border-width:15px 25px;box-sizing:border-box;color:#ffffff;display:inline-block;font-size:16px;text-decoration:none;font-weight:bold\" target=\"_blank\">Click to Verify Email </a> </td> </tr> <tr> <td style=\"text-align:left; font-size: 16px;\"> <p style=\"color:#74787e;line-height:1.5em;margin-top:20\">Once confirmed, you will be able to log in to FuJob with your new account! If you have a moment, share FuJob with friends.</p> <p style=\"color:#74787e;line-height:1.5em;margin-top:0\"> Best wishes, <br> The FuJob<sup>®</sup> Team </p> </td> </tr> <tr> <td style=\"text-align:left; font-size: 16px; ;padding:0px 35px; word-break:break-word\"> <table width=\"100%\" cellpadding=\"20\" cellspacing=\"0\"> <tbody> <tr> <td align=\"center\"> <table cellpadding=\"0\" cellspacing=\"0\"> <tbody> <tr style=\"font-size:0pt;line-height:0pt;text-align:left\"> <td width=\"50\"> <a href=\"https://www.facebook.com\" target=\"_blank\"> <img src=\"https://ci6.googleusercontent.com/proxy/ar0u61ZlE5KcjjPLlWpOzNYiIDf6Y36MSanKxMjCvai0-BwHjGNkXysRF_gP1YqGDgHF_nMxBshl_C5TlukDKarwL0RNOnZlo5OpbKV4UUbjzXYXswxScl8=s0-d-e1-ft#https://www.worldhappiness.com/wp-content/uploads/facebook-circled.png\" width=\"50\" height=\"50\" alt=\"Facebook\"> </a> </td> <td style=\"font-size:0pt;line-height:0pt;text-align:left\" width=\"50\"> <a href=\"https://twitter.com\" target=\"_blank\"> <img src=\"https://ci4.googleusercontent.com/proxy/H0r_tJCPO4tH_ANsF6XU4f18QYDfcrEjfv9llRzspmeHeaITbYqeTXvSsjVPWhqyHKXmIE-B6Q4GhYY05UVMOJOoaMVcwBt1J3OA2E4touhVvlaCaLqV6w=s0-d-e1-ft#https://www.worldhappiness.com/wp-content/uploads/twitter-circled.png\" width=\"50\" height=\"50\" alt=\"Twitter\"> </a> </td> <td style=\"font-size:0pt;line-height:0pt;text-align:left;padding:4px\" width=\"44\"> <a href=\"https://www.youtube.com\" target=\"_blank\"> <img src=\"https://ci3.googleusercontent.com/proxy/WPIeLc6vGeHaODEcjoPxh8kW-7Xg8CRG4DLM36K_2GcrwxP0NpDXuXDBTxviwpOrcaAHJDRs3ELCBrFeXputLUvcnhIIIQI7xQPUHaSrVQ=s0-d-e1-ft#https://img.icons8.com/flat_round/64/000000/youtube-play.png\" width=\"43\" height=\"43\" alt=\"Youtube\"> </a> </td> <td style=\"font-size:0pt;line-height:0pt;text-align:left\" width=\"41\"> <a href=\"https://www.instagram.com\" target=\"_blank\"> <img src=\"https://ci5.googleusercontent.com/proxy/9TnPMzHVMsv52kwLnEtC7zKWG3euehio24UnVM-kYsK9fqzfZkJVPP1lTBLEDoDcZdK7BsOSbNaU8rQr1bynLkdOwPR5yDDXTGBHqr04AxDLEHnE9z9eS3k=s0-d-e1-ft#https://www.worldhappiness.com/wp-content/uploads/linkedin-circled.png\" width=\"50\" height=\"50\" alt=\"Instagram\"> </a> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> <p style=\"color:#bbbfc3;font-size:12px;line-height:1.5em;margin-top:0; text-align: center;\">© 2022 FuJob. All rights reserved.</p> <p style=\"color:#bbbfc3;font-size:12px;line-height:1.5em;margin-top:0; text-align: center;\">District 9, HCM City. </p> </td> </tr> </table> </center>";
                    break;
                default:
                    subject = "FuJob";
                    content = "Maybe this email is wrong, don't care about it!";
                    break;
            }
            EmailUtils emailUtils= new EmailUtils();
            emailUtils.sendEmail(host, port, user, pass, repliient.getEmail(), subject, content);
        } catch (Exception e) {}
    }

    @Override
    public void sendEmail(ServletContext context, User recipient, String nameReporter, String subject, String messageDispute, String jobTitle) {
        String host = context.getInitParameter("host");
        String port = context.getInitParameter("port");
        String user = context.getInitParameter("user");
        String pass = context.getInitParameter("pass");
        try {
            String content ="<center>\n" +
"        <table style=\"max-width:570px; font-family:Arial,sans-serif; box-sizing: border-box;\">\n" +
"            <tr>\n" +
"            </tr>\n" +
"            <tr>\n" +
"                <td style=\"word-break: break-word; text-align:left\\\">\n" +
"                    <h1 style=\"color: #2f3133; font-size: 19px; font-weight: bold;\"> Hi " + recipient.getFullName() +",\n" +
"                    </h1>\n" +
"                </td>\n" +
"                \n" +
"            </tr>\n" +
"            <tr>\n" +
"                <td style=\"text-align:left; font-size: 16px;\">\n" +
"                    <p style=\"color:#74787e;line-height:1.5em;margin-top:20\">"+ nameReporter +" has a dispute with you in the following project:</p>\n" +
"                    <p style=\"color:#ee8c03;line-height:1.5em;margin-top:20\">"+jobTitle+"</p>\n" +
"                    <p style=\"color:#74787e;line-height:1.5em;margin-top:20\">With message: </p>\n" +
"                    <p style=\"color:#74787e;line-height:1.5em;margin-top:20\">\""+messageDispute+"\"</p>\n" +
"                    <p style=\"color:#74787e;line-height:1.5em;margin-top:20\">We will give you 3 days to reconcile yourself. If no consensus is reached, we will deal with the terms of the website!</p>\n" +
"                    <p style=\"color:#74787e;line-height:1.5em;margin-top:0\"> Regards, <br> The FuJob<sup>®</sup>\n" +
"                        Team </p>\n" +
"                </td>\n" +
"            </tr>\n" +
"            <tr>\n" +
"                <td style=\"text-align:left; font-size: 16px; ;padding:0px 35px; word-break:break-word\">\n" +
"                    <table width=\"100%\" cellpadding=\"20\" cellspacing=\"0\">\n" +
"                        <tbody>\n" +
"                            <tr>\n" +
"                                <td align=\"center\">\n" +
"                                    <table cellpadding=\"0\" cellspacing=\"0\">\n" +
"                                        <tbody>\n" +
"                                            <tr style=\"font-size:0pt;line-height:0pt;text-align:left\">\n" +
"                                                <td width=\"50\"> <a href=\"https://www.facebook.com\"\n" +
"                                                        target=\"_blank\"> <img\n" +
"                                                            src=\"https://ci6.googleusercontent.com/proxy/ar0u61ZlE5KcjjPLlWpOzNYiIDf6Y36MSanKxMjCvai0-BwHjGNkXysRF_gP1YqGDgHF_nMxBshl_C5TlukDKarwL0RNOnZlo5OpbKV4UUbjzXYXswxScl8=s0-d-e1-ft#https://www.worldhappiness.com/wp-content/uploads/facebook-circled.png\"\n" +
"                                                            width=\"50\" height=\"50\" alt=\"Facebook\"> </a> </td>\n" +
"                                                <td style=\"font-size:0pt;line-height:0pt;text-align:left\"\n" +
"                                                    width=\"50\"> <a href=\"https://twitter.com\" target=\"_blank\">\n" +
"                                                        <img src=\"https://ci4.googleusercontent.com/proxy/H0r_tJCPO4tH_ANsF6XU4f18QYDfcrEjfv9llRzspmeHeaITbYqeTXvSsjVPWhqyHKXmIE-B6Q4GhYY05UVMOJOoaMVcwBt1J3OA2E4touhVvlaCaLqV6w=s0-d-e1-ft#https://www.worldhappiness.com/wp-content/uploads/twitter-circled.png\"\n" +
"                                                            width=\"50\" height=\"50\" alt=\"Twitter\"> </a> </td>\n" +
"                                                <td style=\"font-size:0pt;line-height:0pt;text-align:left;padding:4px\"\n" +
"                                                    width=\"44\"> <a href=\"https://www.youtube.com\" target=\"_blank\">\n" +
"                                                        <img src=\"https://ci3.googleusercontent.com/proxy/WPIeLc6vGeHaODEcjoPxh8kW-7Xg8CRG4DLM36K_2GcrwxP0NpDXuXDBTxviwpOrcaAHJDRs3ELCBrFeXputLUvcnhIIIQI7xQPUHaSrVQ=s0-d-e1-ft#https://img.icons8.com/flat_round/64/000000/youtube-play.png\"\n" +
"                                                            width=\"43\" height=\"43\" alt=\"Youtube\"> </a> </td>\n" +
"                                                <td style=\"font-size:0pt;line-height:0pt;text-align:left\"\n" +
"                                                    width=\"41\"> <a href=\"https://www.instagram.com\"\n" +
"                                                        target=\"_blank\"> <img\n" +
"                                                            src=\"https://ci5.googleusercontent.com/proxy/9TnPMzHVMsv52kwLnEtC7zKWG3euehio24UnVM-kYsK9fqzfZkJVPP1lTBLEDoDcZdK7BsOSbNaU8rQr1bynLkdOwPR5yDDXTGBHqr04AxDLEHnE9z9eS3k=s0-d-e1-ft#https://www.worldhappiness.com/wp-content/uploads/linkedin-circled.png\"\n" +
"                                                            width=\"50\" height=\"50\" alt=\"Instagram\"> </a> </td>\n" +
"                                            </tr>\n" +
"                                        </tbody>\n" +
"                                    </table>\n" +
"                                </td>\n" +
"                            </tr>\n" +
"                        </tbody>\n" +
"                    </table>\n" +
"                    <p style=\"color:#bbbfc3;font-size:12px;line-height:1.5em;margin-top:0; text-align: center;\">© 2022\n" +
"                        FuJob. All rights reserved.</p>\n" +
"                    <p style=\"color:#bbbfc3;font-size:12px;line-height:1.5em;margin-top:0; text-align: center;\">\n" +
"                        District 9, HCM City. </p>\n" +
"                </td>\n" +
"            </tr>\n" +
"        </table>\n" +
"    </center>";
            EmailUtils emailUtils= new EmailUtils();
            emailUtils.sendEmail(host, port, user, pass, recipient.getEmail(), subject, content);
        } catch (Exception e) {};
    }
    
    @Override
    public void sendEmailCancelDispute(ServletContext context, User recipient, String nameReporter, String subject, String messageDispute, String jobTitle) {
        String host = context.getInitParameter("host");
        String port = context.getInitParameter("port");
        String user = context.getInitParameter("user");
        String pass = context.getInitParameter("pass");
        try {
            String content ="<center>\n" +
"        <table style=\"max-width:570px; font-family:Arial,sans-serif; box-sizing: border-box;\">\n" +
"            <tr>\n" +
"            </tr>\n" +
"            <tr>\n" +
"                <td style=\"word-break: break-word; text-align:left\\\">\n" +
"                    <h1 style=\"color: #2f3133; font-size: 19px; font-weight: bold;\"> Hi " + recipient.getFullName() +",\n" +
"                    </h1>\n" +
"                </td>\n" +
"                \n" +
"            </tr>\n" +
"            <tr>\n" +
"                <td style=\"text-align:left; font-size: 16px;\">\n" +
"                    <p style=\"color:#74787e;line-height:1.5em;margin-top:20\">"+ nameReporter +" has canceled a dispute with you in the following project:</p>\n" +
"                    <p style=\"color:#ee8c03;line-height:1.5em;margin-top:20\">"+jobTitle+"</p>\n" +
"                    <p style=\"color:#74787e;line-height:1.5em;margin-top:20\">With message: </p>\n" +
"                    <p style=\"color:#74787e;line-height:1.5em;margin-top:20\">\""+messageDispute+"\"</p>\n" +
"                    <p style=\"color:#74787e;line-height:1.5em;margin-top:0\"> Regards, <br> The FuJob<sup>®</sup>\n" +
"                        Team </p>\n" +
"                </td>\n" +
"            </tr>\n" +
"            <tr>\n" +
"                <td style=\"text-align:left; font-size: 16px; ;padding:0px 35px; word-break:break-word\">\n" +
"                    <table width=\"100%\" cellpadding=\"20\" cellspacing=\"0\">\n" +
"                        <tbody>\n" +
"                            <tr>\n" +
"                                <td align=\"center\">\n" +
"                                    <table cellpadding=\"0\" cellspacing=\"0\">\n" +
"                                        <tbody>\n" +
"                                            <tr style=\"font-size:0pt;line-height:0pt;text-align:left\">\n" +
"                                                <td width=\"50\"> <a href=\"https://www.facebook.com\"\n" +
"                                                        target=\"_blank\"> <img\n" +
"                                                            src=\"https://ci6.googleusercontent.com/proxy/ar0u61ZlE5KcjjPLlWpOzNYiIDf6Y36MSanKxMjCvai0-BwHjGNkXysRF_gP1YqGDgHF_nMxBshl_C5TlukDKarwL0RNOnZlo5OpbKV4UUbjzXYXswxScl8=s0-d-e1-ft#https://www.worldhappiness.com/wp-content/uploads/facebook-circled.png\"\n" +
"                                                            width=\"50\" height=\"50\" alt=\"Facebook\"> </a> </td>\n" +
"                                                <td style=\"font-size:0pt;line-height:0pt;text-align:left\"\n" +
"                                                    width=\"50\"> <a href=\"https://twitter.com\" target=\"_blank\">\n" +
"                                                        <img src=\"https://ci4.googleusercontent.com/proxy/H0r_tJCPO4tH_ANsF6XU4f18QYDfcrEjfv9llRzspmeHeaITbYqeTXvSsjVPWhqyHKXmIE-B6Q4GhYY05UVMOJOoaMVcwBt1J3OA2E4touhVvlaCaLqV6w=s0-d-e1-ft#https://www.worldhappiness.com/wp-content/uploads/twitter-circled.png\"\n" +
"                                                            width=\"50\" height=\"50\" alt=\"Twitter\"> </a> </td>\n" +
"                                                <td style=\"font-size:0pt;line-height:0pt;text-align:left;padding:4px\"\n" +
"                                                    width=\"44\"> <a href=\"https://www.youtube.com\" target=\"_blank\">\n" +
"                                                        <img src=\"https://ci3.googleusercontent.com/proxy/WPIeLc6vGeHaODEcjoPxh8kW-7Xg8CRG4DLM36K_2GcrwxP0NpDXuXDBTxviwpOrcaAHJDRs3ELCBrFeXputLUvcnhIIIQI7xQPUHaSrVQ=s0-d-e1-ft#https://img.icons8.com/flat_round/64/000000/youtube-play.png\"\n" +
"                                                            width=\"43\" height=\"43\" alt=\"Youtube\"> </a> </td>\n" +
"                                                <td style=\"font-size:0pt;line-height:0pt;text-align:left\"\n" +
"                                                    width=\"41\"> <a href=\"https://www.instagram.com\"\n" +
"                                                        target=\"_blank\"> <img\n" +
"                                                            src=\"https://ci5.googleusercontent.com/proxy/9TnPMzHVMsv52kwLnEtC7zKWG3euehio24UnVM-kYsK9fqzfZkJVPP1lTBLEDoDcZdK7BsOSbNaU8rQr1bynLkdOwPR5yDDXTGBHqr04AxDLEHnE9z9eS3k=s0-d-e1-ft#https://www.worldhappiness.com/wp-content/uploads/linkedin-circled.png\"\n" +
"                                                            width=\"50\" height=\"50\" alt=\"Instagram\"> </a> </td>\n" +
"                                            </tr>\n" +
"                                        </tbody>\n" +
"                                    </table>\n" +
"                                </td>\n" +
"                            </tr>\n" +
"                        </tbody>\n" +
"                    </table>\n" +
"                    <p style=\"color:#bbbfc3;font-size:12px;line-height:1.5em;margin-top:0; text-align: center;\">© 2022\n" +
"                        FuJob. All rights reserved.</p>\n" +
"                    <p style=\"color:#bbbfc3;font-size:12px;line-height:1.5em;margin-top:0; text-align: center;\">\n" +
"                        District 9, HCM City. </p>\n" +
"                </td>\n" +
"            </tr>\n" +
"        </table>\n" +
"    </center>";
            EmailUtils emailUtils= new EmailUtils();
            emailUtils.sendEmail(host, port, user, pass, recipient.getEmail(), subject, content);
        } catch (Exception e) {};
    }
}
