package vn.web.courseShop.controller.client;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.validation.Valid;
import vn.web.courseShop.domain.Account;
import vn.web.courseShop.domain.dto.RegisterDTO;
import vn.web.courseShop.service.AccountService;

@Controller
public class HomePageController {
    
    private final AccountService accountService;
    private final PasswordEncoder passwordEncoder;

    public HomePageController(AccountService accountService,PasswordEncoder passwordEncoder){
        this.accountService = accountService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/register")
    public String getSignUpAccountPage(Model model) {
        model.addAttribute("registerDTO", new RegisterDTO());
        return "client/auth/register";
    }

    @PostMapping("/register")
    public String signUpAccount(@ModelAttribute @Valid RegisterDTO registerDTO, BindingResult bindingResult) {
        if(bindingResult.hasErrors())return "client/auth/register";
        Account account = accountService.registerDTOToAccount(registerDTO);
        account.setRole(accountService.handleGetRoleByName("User"));
        account.setPassword(passwordEncoder.encode(registerDTO.getPassword()));
        accountService.handleSaveAccount(account);
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String getLoginPage(){
        return "client/auth/login";
    }
}
