package vn.web.courseShop.service.validator;
import org.springframework.stereotype.Service;

import jakarta.validation.ConstraintValidator;
import vn.web.courseShop.domain.dto.RegisterDTO;
import vn.web.courseShop.service.AccountService;

@Service
public class RegisterValidator implements ConstraintValidator<RegisterChecked, RegisterDTO> {

    private final AccountService accountService;
    
    public RegisterValidator(AccountService accountService){
        this.accountService = accountService;
    }

    @Override
    public boolean isValid( RegisterDTO registerDTO, jakarta.validation.ConstraintValidatorContext context) {
        boolean valid = true;
        if(!registerDTO.getPassword().equals(registerDTO.getConfirmPassword())) {
            context.buildConstraintViolationWithTemplate("Password not match")
                    .addPropertyNode("confirmPassword")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }
        if(accountService.checkEmailExists(registerDTO.getEmail())) {
            context.buildConstraintViolationWithTemplate("Email already exists")
                    .addPropertyNode("email")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }
        return valid;
    }
}