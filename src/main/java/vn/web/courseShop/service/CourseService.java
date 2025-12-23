package vn.web.courseShop.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.security.access.method.P;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;
import vn.web.courseShop.domain.Account;
import vn.web.courseShop.domain.Cart;
import vn.web.courseShop.domain.CartDetail;
import vn.web.courseShop.domain.Category;
import vn.web.courseShop.domain.Course;
import vn.web.courseShop.domain.CoursePrerequisites;
import vn.web.courseShop.domain.CourseTarget;
import vn.web.courseShop.domain.Enrollment;
import vn.web.courseShop.domain.Invoice;
import vn.web.courseShop.domain.InvoiceDetail;
import vn.web.courseShop.domain.Lesson;
import vn.web.courseShop.domain.Level;
import vn.web.courseShop.domain.Resource;
import vn.web.courseShop.domain.Section;
import vn.web.courseShop.domain.dto.CourseDTO;
import vn.web.courseShop.domain.dto.LessonDTO;
import vn.web.courseShop.domain.dto.SectionDTO;
import vn.web.courseShop.repository.*;

@Service
public class CourseService {

    private final AccountService accountService;

    private final InvoiceRepository invoiceRepository;

    private final InvoiceDetailRepository invoiceDetailRepository;

    private final EnrollmentRepository enrollmentRepository;

    private final CartDetailRepository cartDetailRepository;

    private final CartRepository cartRepository;

    private final AccountRepository accountRepository;
    private final LevelRepository levelRepository;
    private final CategoryRepository categoryRepository;
    private final CourseRepository courseRepository;
    private final UploadService uploadService;


    public CourseService (CourseRepository courseRepository,UploadService uploadService, CategoryRepository categoryRepository, LevelRepository levelRepository, AccountRepository accountRepository, CartRepository cartRepository, CartDetailRepository cartDetailRepository, EnrollmentRepository enrollmentRepository, InvoiceDetailRepository invoiceDetailRepository, InvoiceRepository invoiceRepository, AccountService accountService){
        this.courseRepository = courseRepository;
        this.uploadService = uploadService;
        this.categoryRepository = categoryRepository;
        this.levelRepository = levelRepository;
        this.accountRepository = accountRepository;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.enrollmentRepository = enrollmentRepository;
        this.invoiceDetailRepository = invoiceDetailRepository;
        this.invoiceRepository = invoiceRepository;
        this.accountService = accountService;
    }

    public List<Course> handleGetAllCourses(){
        return this.courseRepository.findAll();
    }

    public List<Course> handleGetCourseByTutorEmail(String email){
        Account account = this.accountRepository.findByEmail(email);
        List<Course> courses = this.courseRepository.findAllByAccount(account);
        if(!courses.isEmpty()) return courses;
        else return null;
    }

    public Course handleSaveCourse(Course course){
        return this.courseRepository.save(course);
    }

    public Course handleFindCourseById(long id){
        if(this.courseRepository.findById(id).isPresent())return this.courseRepository.findById(id).get();
        else return null;
    }

    public CourseDTO handleConvertCourseBasicToCourseDTO(Course course, CourseDTO courseDTO){
        courseDTO.setCourseId(course.getId());
        courseDTO.setCourseTitle(course.getCourseTitle());
        courseDTO.setThumbnailUrl(course.getThumbnailUrl());
        courseDTO.setCourseDesc(course.getCourseDesc());
        List<CourseTarget> courseTargets = course.getTargets();
        List<CoursePrerequisites> coursePrerequisites = course.getCoursePrerequisites();
        
        if(courseTargets!=null){
            List<String> courseDTOTargets = new ArrayList<String>();
            for (CourseTarget courseTarget : courseTargets){
                courseDTOTargets.add(courseTarget.getContent());
            }
            courseDTO.setTargets(courseDTOTargets);
        }

        if(coursePrerequisites!=null){
            List<String> courseDTOPrerequisites = new ArrayList<String>();
            for (CoursePrerequisites courseTarget : coursePrerequisites) {
                courseDTOPrerequisites.add(courseTarget.getContent());
            }
            courseDTO.setPrerequisites(courseDTOPrerequisites);
        }

        return courseDTO;

    }   

    @Transactional 
    public void handleCreateCourseBasic(MultipartFile file, Course course, CourseDTO courseDTO) {
        
        if (file != null && !file.isEmpty()) {
            String thumbName = uploadService.handleUploadFile(file, "images", "courseThumbnail");
            course.setThumbnailUrl(thumbName);
        }

        course.setCourseTitle(courseDTO.getCourseTitle());
        course.setCourseDesc(courseDTO.getCourseDesc());

        if (courseDTO.getPrerequisites() != null) {
            List<CoursePrerequisites> newPrerequisites = new ArrayList<>();
            
            for (String content : courseDTO.getPrerequisites()) {
                if (content != null && !content.trim().isEmpty()) {
                    CoursePrerequisites req = new CoursePrerequisites();
                    req.setContent(content);
                    req.setCourse(course); 
                    newPrerequisites.add(req);
                }
            }
            
            course.setCoursePrerequisites(newPrerequisites);
        }

        if (courseDTO.getTargets() != null) {
            List<CourseTarget> newTargets = new ArrayList<>();
            
            for (String content : courseDTO.getTargets()) {
                if (content != null && !content.trim().isEmpty()) {
                    CourseTarget target = new CourseTarget();
                    target.setContent(content);
                    target.setCourse(course);
                    newTargets.add(target);
                }
            }
            course.setTargets(newTargets);
        }

        courseRepository.save(course);
    }

    public CourseDTO handleConvertCourseCurriculumToCourseDTO(CourseDTO courseDTO, Course course){
        courseDTO.setCourseId(course.getId());
        List<Section> sections = course.getSections();
        List<SectionDTO> sectionDTOs = new ArrayList<SectionDTO>();
        if(sections!=null){
            for (Section section : sections) {
                SectionDTO sectionDTO = new SectionDTO();
                sectionDTO.setTitle(section.getSectionTitle());
                List<Lesson> lessons = section.getLessons();
                if(lessons!=null){
                    List<LessonDTO> lessonDTOs = new ArrayList<LessonDTO>();
                    for (Lesson lesson : lessons) {
                        LessonDTO lessonDTO = new LessonDTO();
                        lessonDTO.setTitle(lesson.getLessonTitle());
                        List<Resource> resources = lesson.getResources();
                        for(Resource resource : resources){
                            String docFileUrl = resource.getDocument();                          
                            if(docFileUrl!=null && !docFileUrl.isEmpty())lessonDTO.setDocFileUrl(resource.getDocument());
                        
                            String videoFileUrl = resource.getVideo();
                            if(videoFileUrl!=null && !videoFileUrl.isEmpty())lessonDTO.setVideoFileUrl(resource.getVideo());
                        }
                        lessonDTOs.add(lessonDTO);
                    }
                    sectionDTO.setLessons(lessonDTOs);
                }
                sectionDTOs.add(sectionDTO);
            }
            courseDTO.setSectionDTOs(sectionDTOs);
        }
        return courseDTO;
    }

    @Transactional 
    public void handleCreateCourseCurriculum(CourseDTO courseDTO, Course course) {
    if (course.getSections() != null && !course.getSections().isEmpty()) {
        course.getSections().clear();
    }
    
    if (courseDTO.getSectionDTOs() != null) {
        courseDTO.getSectionDTOs().removeIf(Objects::isNull);

        for (SectionDTO sectionDTO : courseDTO.getSectionDTOs()) {
            Section section = new Section();
            section.setSectionTitle(sectionDTO.getTitle());
            section.setCourse(course);

            if (sectionDTO.getLessons() != null) {
                sectionDTO.getLessons().removeIf(Objects::isNull);

                for (LessonDTO lessonDTO : sectionDTO.getLessons()) {
                    Lesson lesson = new Lesson();
                    lesson.setLessonTitle(lessonDTO.getTitle());
                    
                    String currentVideoUrl = lessonDTO.getVideoFileUrl(); 
                    String currentDocUrl = lessonDTO.getDocFileUrl();     
                    
                    MultipartFile newVideoFile = lessonDTO.getVideoFile(); 
                    MultipartFile newDocFile = lessonDTO.getDocFile();     
                    String finalVideoUrl = null;
                    if (newVideoFile != null && !newVideoFile.isEmpty()) {
                        finalVideoUrl = this.uploadService.handleUploadFile(newVideoFile, "videos", "video");
                    } else {
                        finalVideoUrl = currentVideoUrl;
                    }

                    String finalDocUrl = null;
                    if (newDocFile != null && !newDocFile.isEmpty()) {
                        finalDocUrl = this.uploadService.handleUploadFile(newDocFile, "documents", "document");
                    } else {
                        finalDocUrl = currentDocUrl;
                    }

                    if ( (finalVideoUrl != null && !finalVideoUrl.isEmpty()) || 
                         (finalDocUrl != null && !finalDocUrl.isEmpty()) ) {
                        
                        Resource resource = new Resource();
                        resource.setVideo(finalVideoUrl);
                        resource.setDocument(finalDocUrl);
                        
                        resource.setLesson(lesson);
                        lesson.getResources().add(resource);
                    }

                    lesson.setSection(section);
                    section.getLessons().add(lesson);
                    }
                }
                course.getSections().add(section);
            }
        }
        this.courseRepository.save(course);
    }

    public CourseDTO handleConvertCourseSettingToCourseDTO(Course course, CourseDTO courseDTO){
        if(course.getOriginalPrice()!=null)courseDTO.setPrice(course.getOriginalPrice());
        if(course.getCurrency()!=null)courseDTO.setCurrency(course.getCurrency());
        if(course.getLevel()!=null)courseDTO.setLevel(course.getLevel().getLevelName());
        if(course.getCategory()!=null)courseDTO.setCategory(course.getCategory().getDescription());
        if(course.getLanguage()!=null)courseDTO.setLanguage(course.getLanguage());
        courseDTO.setCourseId(course.getId());
        return courseDTO;
    }

    public void handleCreateCourseSetting(Course course, CourseDTO courseDTO){
        Category category = this.categoryRepository.findByDescription(courseDTO.getCategory());
        Level level = this.levelRepository.findByLevelName(courseDTO.getLevel());
        course.setLevel(level);
        course.setCategory(category);
        course.setLanguage(courseDTO.getLanguage());
        course.setOriginalPrice(courseDTO.getPrice());
        course.setCurrency(courseDTO.getCurrency());
        this.courseRepository.save(course);
    }

    public CourseDTO handleConvertCourseToCourseDTO(Course course, CourseDTO courseDTO){
        courseDTO = this.handleConvertCourseBasicToCourseDTO(course, courseDTO);
        courseDTO = this.handleConvertCourseCurriculumToCourseDTO(courseDTO, course);
        courseDTO = this.handleConvertCourseSettingToCourseDTO(course, courseDTO);
        return courseDTO;
    }

    public void handleAddCourseToCart(long courseId, HttpSession session, Account account){
        Course course = this.handleFindCourseById(courseId);

        if (this.enrollmentRepository.existsByAccountAndCourse(account, course)) {
            throw new RuntimeException("Bạn đã sở hữu khóa học này rồi, vào học ngay!");
        }

        Cart cart = account.getCart();
        if (cart == null) {
            cart = new Cart();
            cart.setAccount(account);
            cart = this.cartRepository.save(cart); 
        }

        if (this.cartDetailRepository.existsByCartAndCourse(cart, course)) {
            throw new RuntimeException("Khóa học này đã nằm trong giỏ hàng của bạn!");
        }
        CartDetail cartDetail = new CartDetail();
        cartDetail.setCart(cart);
        cartDetail.setCourse(course);
        
        this.cartDetailRepository.save(cartDetail);
        int sum = (int)session.getAttribute("cart");
        session.setAttribute("cart", ++sum);
    }

    public List<Course> handleGetCourseAddedByAccount(Account account){
        List<Course> courses = new ArrayList<>();
        if(account.getCart()!=null){
            List<CartDetail> cartDetails = account.getCart().getCartDetails();
            for (CartDetail cartDetail : cartDetails) {
                Course course = cartDetail.getCourse();
                if(this.enrollmentRepository.existsByAccountAndCourse(account, course)==false){
                    courses.add(course);
                }
            }
        }
        return courses;
    }

    public List<Long> handleGetAllCourseByAccountAndInvoice(Account account){
        List<Long> courseIds = new ArrayList<>();
        List<Invoice> invoices = this.invoiceRepository.findAllByAccount(account);
        for (Invoice invoice : invoices) {
            if(invoice.getStatus().equals("pending")){
                for (InvoiceDetail invoiceDetail : invoice.getInvoiceDetails()) {
                    courseIds.add(invoiceDetail.getCourse().getId());
                }
            }
        }
        return courseIds;
    }

    public void handleAddCourseToInvoice(Account account, Course course){
        if(account.getInvoices()!=null){
            List<Invoice> invoices = this.invoiceRepository.findAllByAccount(account);
            for (Invoice temp : invoices) {
                if(temp.getStatus().equals("pending")){
                    if(this.invoiceDetailRepository.existsByInvoiceAndCourse(temp, course)==true){
                        InvoiceDetail invoiceDetail = this.invoiceDetailRepository.findByInvoiceAndCourse(temp, course);
                        invoiceDetail.setCourse(null);
                        invoiceDetail.setInvoice(null);
                        this.invoiceDetailRepository.delete(invoiceDetail);
                        temp.setPurchaseTotalPrice(temp.getPurchaseTotalPrice().subtract(course.getOriginalPrice()));
                        this.invoiceRepository.save(temp);
                    }else{
                        InvoiceDetail invoiceDetail = new InvoiceDetail();
                        invoiceDetail.setCourse(course);
                        invoiceDetail.setInvoice(temp);
                        temp.setPurchaseTotalPrice(temp.getPurchaseTotalPrice().add(course.getOriginalPrice()));
                        this.invoiceDetailRepository.save(invoiceDetail);
                        this.invoiceRepository.save(temp);
                    }
                    return;
                }
            } 
        }
        Invoice invoice = new Invoice();
        invoice.setAccount(account);
        invoice.setPurchaseTotalPrice(course.getOriginalPrice());
        invoice.setStatus("pending");
        invoice = this.invoiceRepository.save(invoice);

        InvoiceDetail invoiceDetail = new InvoiceDetail();
        invoiceDetail.setCourse(course);
        invoiceDetail.setInvoice(invoice);
        this.invoiceDetailRepository.save(invoiceDetail);
    }

    public void handleDeleteCourseFromCart(Account account, Course course,HttpSession session){
        if(account.getInvoices()!=null){
            List<Invoice> invoices = this.invoiceRepository.findAllByAccount(account);
            for (Invoice temp : invoices) {
                if(temp.getStatus().equals("pending")){
                    if(this.invoiceDetailRepository.existsByInvoiceAndCourse(temp, course)==true){
                        InvoiceDetail invoiceDetail = this.invoiceDetailRepository.findByInvoiceAndCourse(temp, course);
                        invoiceDetail.setCourse(null);
                        invoiceDetail.setInvoice(null);
                        this.invoiceDetailRepository.delete(invoiceDetail);
                        temp.setPurchaseTotalPrice(temp.getPurchaseTotalPrice().subtract(course.getOriginalPrice()));
                        this.invoiceRepository.save(temp);
                        Cart cart = account.getCart();
                        List<CartDetail> cartDetails = cart.getCartDetails();
                        CartDetail cartDetailTemp = new CartDetail();
                        for (CartDetail cartDetail : cartDetails) {
                            if(cartDetail.getCourse().getId()==course.getId()){
                                cartDetailTemp = cartDetail;
                                break;
                            }
                        }
                        cartDetailTemp.setCart(null);
                        cartDetailTemp.setCourse(null);
                        cart.getCartDetails().remove(cartDetailTemp);
                        this.cartDetailRepository.delete(cartDetailTemp);
                        this.cartRepository.save(cart);                            
                        session.setAttribute("cart", this.accountService.countCartByAccount(session));
                        return;
                    }
                }
            }
        }

        Cart cart = account.getCart();
        List<CartDetail> cartDetails = cart.getCartDetails();
        CartDetail cartDetailTemp = new CartDetail();
        for (CartDetail cartDetail : cartDetails) {
            if(cartDetail.getCourse().getId()==course.getId()){
                cartDetailTemp = cartDetail;
                break;
            }
        }
        cartDetailTemp.setCart(null);
        cartDetailTemp.setCourse(null);
        cart.getCartDetails().remove(cartDetailTemp);
        this.cartDetailRepository.delete(cartDetailTemp);
        this.cartRepository.save(cart);                            
        session.setAttribute("cart", this.accountService.countCartByAccount(session));
        return;
    }

    public BigDecimal handleCourseTotal(Account account){
        List<Invoice> invoices = this.invoiceRepository.findAllByAccount(account);
        for (Invoice invoice : invoices) {
            if(invoice.getStatus().equals("pending")){
                return invoice.getPurchaseTotalPrice();
            }
        }
        return null;   
    }

    public Map<String, List<Course>> handleGetCourseInvoice(Account account){
        List<Course> courses = new ArrayList<>();
        List<Invoice> invoices = this.invoiceRepository.findAllByAccount(account);
        for (Invoice invoice : invoices) {
            if(invoice.getStatus().equals("pending")){
                for (InvoiceDetail invoiceDetail : invoice.getInvoiceDetails()) {
                    courses.add(invoiceDetail.getCourse());
                }
                break;
            }
        }
        Map<String, List<Course>> coursesByTeacher = new HashMap<>();

        for (Course course : courses) {
            String teacherName = course.getAccount().getFullname();
            if (!coursesByTeacher.containsKey(teacherName)) {
                coursesByTeacher.put(teacherName, new ArrayList<>());
            }

            coursesByTeacher.get(teacherName).add(course);
        }

        return coursesByTeacher;
    }

    public void handlePaymentSuccessfully(Account account){
        List<Invoice> invoices = this.invoiceRepository.findAllByAccount(account);
        for (Invoice invoice : invoices) {
            if(invoice.getStatus().equals("pending")){
                for (InvoiceDetail invoiceDetail : invoice.getInvoiceDetails()) {Enrollment enrollment = new Enrollment();
                    enrollment.setAccount(account);
                    enrollment.setCourse(invoiceDetail.getCourse());
                    this.enrollmentRepository.save(enrollment);
                }
            }
            invoice.setStatus("success");                 
            return;
        }
    }

    public List<Course> handleShowAllCourseEnrollByAccount(Account account){
        List<Enrollment> enrollments = this.enrollmentRepository.findAllByAccount(account);
        List<Course> courses = new ArrayList<>();
        for (Enrollment enrollment : enrollments) {
            courses.add(enrollment.getCourse());
        }
        return courses;
    }

    public void deleteCourse(long courseId) {
        Course course = courseRepository.findById(courseId)
                .orElseThrow(() -> new RuntimeException("Can not find course with id: " + courseId));
        if (!course.getEnrollments().isEmpty() || !course.getInvoiceDetails().isEmpty()) {
            throw new RuntimeException("This course cannot be deleted because it has already been registered by a student or linked to an invoice!");
        }
        if (!course.getCartDetails().isEmpty()) {
            cartDetailRepository.deleteAllByCourse(course);
        }
        courseRepository.delete(course);
    }
    public List<Course> handleFindAllPublicCourse(){
        return this.courseRepository.findAll();
    }   

    public List<Course> findCourseByTitle(String titleString){
        List<Course> courseResults = new ArrayList<>();
        List<Course> courses = this.handleFindAllPublicCourse();
        for (Course course : courses) {
            if(course.getCourseTitle().toLowerCase().contains(titleString.toLowerCase()))courseResults.add(course);
        }
        return courseResults;
    }
}