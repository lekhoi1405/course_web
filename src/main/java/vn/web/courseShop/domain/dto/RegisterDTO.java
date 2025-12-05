package vn.web.courseShop.domain.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import vn.web.courseShop.service.validator.RegisterChecked;

@RegisterChecked
public class RegisterDTO {

    @NotNull(message = "Full name can not be null")
    @Size(min = 3 , message = "Full name must be at least 3 characters long")
    private String fullname;

    @NotNull(message = "Email can not be null")
    @Email(message = "Email is not valid", regexp = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$") 
    private String email;

    @NotNull(message = "Password can not be null")
    @Size(min = 3 , message = "Password must be at least 3 characters long")
    private String password;

    private String confirmPassword;

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    
}
