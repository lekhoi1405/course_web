
package vn.web.courseShop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.web.courseShop.domain.Account;
import vn.web.courseShop.service.AccountService;

@Controller
public class AccountController {

    private final AccountService accountService;

    public AccountController(AccountService accountService) {
        this.accountService = accountService;
    }

    @GetMapping("/client/profile")
    public String handleContinueLearn(HttpServletRequest request, Model model){
        HttpSession session = request.getSession(false);
        String email = (String)session.getAttribute("email");
        Account account = this.accountService.handleGetAccountByEmail(email);
        model.addAttribute("account", account);
        return "client/profile/MyProfile";
    }

    @GetMapping("/client/profile/edit")
    public String handleEditProfile(HttpServletRequest request, Model model){
         HttpSession session = request.getSession(false);
        String email = (String)session.getAttribute("email");
        Account account = this.accountService.handleGetAccountByEmail(email);
        model.addAttribute("account", account);
        return "client/profile/EditProfile";
    }

    @PostMapping("/client/profile/edit")
    public String updateProfile(@ModelAttribute Account account, HttpServletRequest httpServletRequest){
        HttpSession session = httpServletRequest.getSession(false);
        String email = (String)session.getAttribute("email");
        Account accountOrigin = this.accountService.handleGetAccountByEmail(email);
        accountOrigin.setFullname(account.getFullname());
        accountOrigin.setAboutme(account.getAboutme());
        accountOrigin.setDob(account.getDob());
        accountOrigin.setMedia_link(account.getMedia_link());
        this.accountService.handleSaveAccount(accountOrigin);
        return "redirect:/client/profile";
    }
}
