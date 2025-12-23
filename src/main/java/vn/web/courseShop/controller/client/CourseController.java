package vn.web.courseShop.controller.client;

import java.math.BigDecimal;
import java.net.http.HttpRequest;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.web.courseShop.domain.Account;
import vn.web.courseShop.domain.Course;
import vn.web.courseShop.domain.dto.CourseDTO;
import vn.web.courseShop.service.AccountService;
import vn.web.courseShop.service.CourseService;

@Controller
public class CourseController {

    private final AccountService accountService;

    private final CourseService courseService;
    public CourseController(CourseService courseService, AccountService accountService){
        this.courseService = courseService;
        this.accountService = accountService;
    }   

    //handle tutor now page

    //Get tutor now page
    @GetMapping("/client/tutor/course")
    public String getTutorPage(Model model, HttpServletRequest httpServletRequest){
        HttpSession session = httpServletRequest.getSession();
        String email = (String)session.getAttribute("email");
        List<Course> courses = this.courseService.handleGetCourseByTutorEmail(email);
        model.addAttribute("courses", courses);
        return "client/tutor/TutorCourses";
    }

    //Get add course page
    @GetMapping("/client/tutor/course/add")
    public String getAddCoursePage(Model model, HttpServletRequest httpServletRequest){
        HttpSession session = httpServletRequest.getSession();
        String email = (String)session.getAttribute("email");
        Course course = new Course();
        course.setAccount(accountService.handleGetAccountByEmail(email));
        course.setStatus("draft");
        course = courseService.handleSaveCourse(course);
        CourseDTO courseDTO = new CourseDTO();
        courseDTO.setCourseId(course.getId());
        model.addAttribute("courseDTO", courseDTO);
        return "client/tutor/AddCourse_Basic";
    }
    

    //Course basic

    //Get add course basic with param
    @GetMapping("/client/tutor/course/add/basic")
    public String addCourseBasic(@RequestParam long courseId, Model model){
        Course course = this.courseService.handleFindCourseById(courseId);
        CourseDTO courseDTO = new CourseDTO();
        courseDTO = this.courseService.handleConvertCourseBasicToCourseDTO(course,courseDTO);
        model.addAttribute("courseDTO", courseDTO);
        return "client/tutor/AddCourse_Basic";
    }

    //Handle add basic infor

    @PostMapping("/client/tutor/course/add/basicInfor")
    public String addCourseBasic(@ModelAttribute CourseDTO courseDTO, @RequestParam("thumbnail")MultipartFile file, 
            @RequestParam("action")String action,RedirectAttributes redirectAttributes){

        if(action.equals("cancel"))return "redirect:/client/tutor/course";
        else if(action.equals("save")){
            Course course = this.courseService.handleFindCourseById(courseDTO.getCourseId());
            courseService.handleCreateCourseBasic(file, course, courseDTO);
            return "redirect:/client/tutor/course";
        }
        else if(action.equals("submitReview")){
            //handle for submit review button
            return "redirect:/client/tutor/course";
        }
        Course course = this.courseService.handleFindCourseById(courseDTO.getCourseId());
        courseService.handleCreateCourseBasic(file, course, courseDTO);
        
        //prepare data to redirect url?courseId=
        redirectAttributes.addAttribute("courseId",courseDTO.getCourseId());
        if(action.equals("curriculum"))return "redirect:/client/tutor/course/add/curriculum";
        else if(action.equals("settings"))return "redirect:/client/tutor/course/add/settings";
        else return "redirect:/client/tutor/course/add/basic";
    }


    //Course curriculum

    //Get add curriculum course page
    @GetMapping("/client/tutor/course/add/curriculum")
    public String getCourseCurriculum(@RequestParam long courseId, Model model){
        Course course = this.courseService.handleFindCourseById(courseId);
        CourseDTO courseDTO = new CourseDTO();
        courseDTO = this.courseService.handleConvertCourseCurriculumToCourseDTO(courseDTO, course);
        model.addAttribute("courseDTO", courseDTO);
        return "client/tutor/AddCourse_Curriculum";
    }

    //handle add curriculum
    @PostMapping("/client/tutor/course/add/curriculum")
    public String addCourseCurriculum(@ModelAttribute CourseDTO courseDTO ,@RequestParam String action,RedirectAttributes redirectAttributes){

        if(action.equals("cancel"))return "redirect:/client/tutor/course";
        else if(action.equals("save")){
            Course course = this.courseService.handleFindCourseById(courseDTO.getCourseId());
            this.courseService.handleCreateCourseCurriculum(courseDTO,course);
            return "redirect:/client/tutor/course";
        }
        else if(action.equals("submitReview")){
            //handle for submit review button
            return "redirect:/client/tutor/course";
        }

        Course course = this.courseService.handleFindCourseById(courseDTO.getCourseId());
        this.courseService.handleCreateCourseCurriculum(courseDTO,course);

        //prepare data to redirect url?courseId=
        redirectAttributes.addAttribute("courseId",courseDTO.getCourseId());
        if(action.equals("curriculum"))return "redirect:/client/tutor/course/add/curriculum";
        else if(action.equals("settings"))return "redirect:/client/tutor/course/add/settings";
        else return "redirect:/client/tutor/course/add/basic";
    }


    //Course settings

    //Get add settings course page
    @GetMapping("/client/tutor/course/add/settings")
    public String getCourseSetting(@RequestParam long courseId, Model model){
        Course course = this.courseService.handleFindCourseById(courseId);
        CourseDTO courseDTO = new CourseDTO();
        courseDTO = this.courseService.handleConvertCourseSettingToCourseDTO(course,courseDTO);
        model.addAttribute("courseDTO", courseDTO);
        return "client/tutor/AddCourse_Settings";
    }

    //handle add settings
    @PostMapping("/client/tutor/course/add/settings")
    public String addCourseSetting(@ModelAttribute CourseDTO courseDTO ,@RequestParam String action,RedirectAttributes redirectAttributes){

        if(action.equals("cancel"))return "redirect:/client/tutor/course";
        else if(action.equals("save")){
            Course course = courseService.handleFindCourseById(courseDTO.getCourseId());
            this.courseService.handleCreateCourseSetting(course,courseDTO);
            return "redirect:/client/tutor/course";
        }
        else if(action.equals("submitReview")){
            //handle for submit review button
            return "redirect:/client/tutor/course";
        }
        
        Course course = courseService.handleFindCourseById(courseDTO.getCourseId());
        this.courseService.handleCreateCourseSetting(course,courseDTO);

        //prepare data to redirect url?courseId=
        redirectAttributes.addAttribute("courseId",courseDTO.getCourseId());
        if(action.equals("curriculum"))return "redirect:/client/tutor/course/add/curriculum";
        else if(action.equals("settings"))return "redirect:/client/tutor/course/add/settings";
        else return "redirect:/client/tutor/course/add/basic";
    }

    @PostMapping("/client/tutorCourses/deleteCourse")
    public String deleteCourse(@RequestParam long courseId,RedirectAttributes redirectAttributes){
        try {
            this.courseService.deleteCourse(courseId);
            redirectAttributes.addFlashAttribute("message", "Delete course successfully");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }

        return "redirect:/client/tutor/course";
    }

    @GetMapping("/course/{id}")
    public String getCourseDetailPage(Model model, @PathVariable long id){
        Course course = this.courseService.handleFindCourseById(id);
        CourseDTO courseDTO = new CourseDTO();
        courseDTO = this.courseService.handleConvertCourseToCourseDTO(course, courseDTO);
        model.addAttribute("courseDTO", courseDTO);
        return "client/course/View-Course";
    }

    @PostMapping("/client/add-to-cart/{id}")
    public String addCourseToCard(@PathVariable long id, HttpServletRequest request,RedirectAttributes redirectAttributes){
        HttpSession session = request.getSession(false);
        String email = (String)session.getAttribute("email");
        Account account = this.accountService.handleGetAccountByEmail(email);
        try {
            this.courseService.handleAddCourseToCart(id, session, account);
            redirectAttributes.addFlashAttribute("message", "Thêm vào giỏ thành công!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
    
        return "redirect:/course/" + id;
    }

    @GetMapping("/client/cart")
    public String getCartPage(Model model,HttpServletRequest request){
        HttpSession session = request.getSession(false);
        String email = (String)session.getAttribute("email");
        Account account = this.accountService.handleGetAccountByEmail(email);
        List<Course> courses = this.courseService.handleGetCourseAddedByAccount(account);
        List<Long> courseIds = this.courseService.handleGetAllCourseByAccountAndInvoice(account);
        BigDecimal total = this.courseService.handleCourseTotal(account);
        model.addAttribute("countCart", account.getCart().getCartDetails().size());
        model.addAttribute("count", courseIds.size());
        model.addAttribute("total", total);
        model.addAttribute("listId", courseIds);
        model.addAttribute("list", courses);
        return "client/cart/MyCart";
    }

    @PostMapping("/client/invoice/add-course")
    public String addCourseToInvoice(@RequestParam long courseId, HttpServletRequest request, Model model){
        HttpSession session = request.getSession(false);
        String email = (String)session.getAttribute("email");
        Account account = this.accountService.handleGetAccountByEmail(email);
        Course course = this.courseService.handleFindCourseById(courseId);
        this.courseService.handleAddCourseToInvoice(account, course);
        return "redirect:/client/cart";
    }

    @PostMapping("/client/invoice/delete-course")
    public String deleteCourseFromCart(@RequestParam long courseId, HttpServletRequest request, Model model){
        HttpSession session = request.getSession(false);
        String email = (String)session.getAttribute("email");
        Account account = this.accountService.handleGetAccountByEmail(email);
        Course course = this.courseService.handleFindCourseById(courseId);
        this.courseService.handleDeleteCourseFromCart(account, course, session);
        return "redirect:/client/cart";
    }

    @PostMapping("/client/payment")
    public String getPaymentPage(HttpServletRequest request, Model model){
        HttpSession session = request.getSession(false);
        String email = (String)session.getAttribute("email");
        Account account = this.accountService.handleGetAccountByEmail(email);
        Map<String, List<Course>> courses = this.courseService.handleGetCourseInvoice(account);
        BigDecimal total = this.courseService.handleCourseTotal(account);
        model.addAttribute("total", total);
        model.addAttribute("list", courses);
        return "client/cart/Payment";
    }
    
    @PostMapping("/client/payment/pay")
    public String handlePaySuccessfully(HttpServletRequest request,RedirectAttributes redirectAttributes){
        HttpSession session = request.getSession(false);
        String email = (String)session.getAttribute("email");
        Account account = this.accountService.handleGetAccountByEmail(email);
        this.courseService.handlePaymentSuccessfully(account);
        redirectAttributes.addFlashAttribute("message", "Thanh toán thành công!");
        return "redirect:/client/enrollment";
    }

    @GetMapping("/client/enrollment")
    public String handleGetEnrollmentPage(HttpServletRequest request, Model model){
        HttpSession session = request.getSession(false);
        String email = (String)session.getAttribute("email");
        Account account = this.accountService.handleGetAccountByEmail(email);
        List<Course> courses = this.courseService.handleShowAllCourseEnrollByAccount(account);
        model.addAttribute("list", courses);
        return "client/enrollment/Enrollments";
    }

    @PostMapping("/client/enrollment/continue")
    public String handleContinueLearn(@RequestParam long courseId, HttpServletRequest request, Model model){
        HttpSession session = request.getSession(false);
        String email = (String)session.getAttribute("email");
        Account account = this.accountService.handleGetAccountByEmail(email);
        Course course = this.courseService.handleFindCourseById(courseId);
        model.addAttribute("course", course);
        return "client/enrollment/LessonVideo";
    }

}
