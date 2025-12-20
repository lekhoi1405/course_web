package vn.web.courseShop.controller.client;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import vn.web.courseShop.domain.Account;
import vn.web.courseShop.domain.Course;
import vn.web.courseShop.domain.dto.RegisterDTO;
import vn.web.courseShop.service.AccountService;
import vn.web.courseShop.service.CourseService;

@Controller
public class HomePageController {
    
    private final AccountService accountService;
    private final PasswordEncoder passwordEncoder;
    private final CourseService courseService;

    public HomePageController(AccountService accountService,PasswordEncoder passwordEncoder,CourseService courseService){
        this.accountService = accountService;
        this.passwordEncoder = passwordEncoder;
        this.courseService = courseService;
    }

    //Get homepage
    @GetMapping("/")
    public String getHomePage(Model model, HttpServletRequest httpServletRequest){
        HttpSession session = httpServletRequest.getSession();
        if((String)session.getAttribute("email")==null)return "client/homepage/HomePage";
        List<Course> courseList = this.courseService.handleGetAllCourses();
        model.addAttribute("recommendList", courseList);
        return "client/homepage/UserDashboard";
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
