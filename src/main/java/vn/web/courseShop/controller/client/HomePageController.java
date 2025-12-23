package vn.web.courseShop.controller.client;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
        if((String)session.getAttribute("email")==null){
            List<Course> courses = this.courseService.handleFindAllPublicCourse();
            model.addAttribute("list", courses);
            return "client/homepage/HomePage";
        }
        String email = (String)session.getAttribute("email");
        Account account = this.accountService.handleGetAccountByEmail(email);
        List<Course> courseList = this.courseService.handleGetAllCourses();
        List<Course> courses = this.courseService.handleShowAllCourseEnrollByAccount(account);
        model.addAttribute("list", courses);
        model.addAttribute("recommendList", courseList);
        return "client/homepage/UserDashboard";
    }

    @GetMapping("/explore")
    public String getExplorePage(Model model){
        List<Course> courses = this.courseService.handleGetAllCourses();
        model.addAttribute("list", courses);
        return "client/homepage/UserExplore";
    }

    @PostMapping("/explore/search")
    public String handleSearchCourse(@RequestParam String search, Model model){
        List<Course> courses = this.courseService.findCourseByTitle(search);
        model.addAttribute("list", courses);
        model.addAttribute("count", courses.size());
        model.addAttribute("title", search);
        return "client/homepage/UserExploreSearch";
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
