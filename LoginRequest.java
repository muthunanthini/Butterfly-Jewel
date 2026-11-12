package com.butterflyjewel.dto;

public class LoginRequest {
    private String usernameEmail;
    private String password;

    public LoginRequest() {}

    public String getUsernameEmail() { return usernameEmail; }
    public void setUsernameEmail(String usernameEmail) { this.usernameEmail = usernameEmail; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}
