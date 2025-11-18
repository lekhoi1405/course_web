
package vn.web.courseShop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import vn.web.courseShop.domain.Account;
import vn.web.courseShop.service.AccountService;

@Controller
public class AccountController {

    private final AccountService accountService;

    public AccountController(AccountService accountService) {
        this.accountService = accountService;
    }

    @GetMapping("/signUp")
    public String getSignUpAccountPage(Model model) {
        model.addAttribute("account", new Account());
        return "SignUp";
    }

    @PostMapping("/signUp")
    public String signUpAccount(@ModelAttribute Account account) {
        accountService.handleSaveAccount(account);
        return "redirect:/";
    }

    @GetMapping("/")
    public String getHomePage() {
        return "test";
    }   
}
