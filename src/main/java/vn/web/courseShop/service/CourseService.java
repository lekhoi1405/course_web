package vn.web.courseShop.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import org.springframework.security.access.method.P;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import vn.web.courseShop.domain.Account;
import vn.web.courseShop.domain.Category;
import vn.web.courseShop.domain.Course;
import vn.web.courseShop.domain.CoursePrerequisites;
import vn.web.courseShop.domain.CourseTarget;
import vn.web.courseShop.domain.Lesson;
import vn.web.courseShop.domain.Level;
import vn.web.courseShop.domain.Resource;
import vn.web.courseShop.domain.Section;
import vn.web.courseShop.domain.dto.CourseDTO;
import vn.web.courseShop.domain.dto.LessonDTO;
import vn.web.courseShop.domain.dto.SectionDTO;
import vn.web.courseShop.repository.AccountRepository;
import vn.web.courseShop.repository.CategoryRepository;
import vn.web.courseShop.repository.CourseRepository;
import vn.web.courseShop.repository.LevelRepository;

@Service
public class CourseService {

    private final AccountRepository accountRepository;
    private final LevelRepository levelRepository;
    private final CategoryRepository categoryRepository;
    private final CourseRepository courseRepository;
    private final UploadService uploadService;


    public CourseService (CourseRepository courseRepository,UploadService uploadService, CategoryRepository categoryRepository, LevelRepository levelRepository, AccountRepository accountRepository){
        this.courseRepository = courseRepository;
        this.uploadService = uploadService;
        this.categoryRepository = categoryRepository;
        this.levelRepository = levelRepository;
        this.accountRepository = accountRepository;
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

    public void handleCreateCourseBasic(MultipartFile file, Course course, CourseDTO courseDTO){
        if(!file.isEmpty()) course.setThumbnailUrl(uploadService.handleUploadFile(file, "images","courseThumbnail"));
        course.setCourseTitle(courseDTO.getCourseTitle());
        course.setCourseDesc(courseDTO.getCourseDesc());

        if(courseDTO.getPrerequisites()!=null){
            course.setCoursePrerequisites(new ArrayList<>());
            for (String prerequisites : courseDTO.getPrerequisites() ) {
                if(prerequisites!=null && !prerequisites.trim().isEmpty()){
                    CoursePrerequisites coursePrerequisites = new CoursePrerequisites();
                    coursePrerequisites.setContent(prerequisites);
                    coursePrerequisites.setCourse(course);
                    course.getCoursePrerequisites().add(coursePrerequisites);
                }
            }
        }
        if(courseDTO.getTargets()!=null){
            course.setTargets(new ArrayList<>());
            for (String target : courseDTO.getTargets() ) {
                if(target!=null && !target.trim().isEmpty()){
                    CourseTarget courseTarget = new CourseTarget();
                    courseTarget.setContent(target);
                    courseTarget.setCourse(course);
                    course.getTargets().add(courseTarget);
                }
            }
        }
        courseRepository.save(course);
    }

    public CourseDTO handleConvertCourseCurriculumToCourseDTO(CourseDTO courseDTO, Course course){
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

    public void handleCreateCourseCurriculum(CourseDTO courseDTO, Course course ) {
        courseDTO.getSectionDTOs().removeIf(Objects::isNull);
        for (SectionDTO sectionDTO : courseDTO.getSectionDTOs()) {
            Section section = new Section();
            section.setSectionTitle(sectionDTO.getTitle());
            section.setCourse(course);
            
            if (sectionDTO.getLessons() != null) {
                sectionDTO.getLessons().removeIf(Objects::isNull);
            }
            
            for (LessonDTO lessonDTO : sectionDTO.getLessons()) {

                Lesson lesson = new Lesson();
                lesson.setLessonTitle(lessonDTO.getTitle());

                MultipartFile video = lessonDTO.getVideoFile();
                MultipartFile document = lessonDTO.getDocFile();
                if((video != null && !video.isEmpty())||document != null && !document.isEmpty()){
                    Resource resource = new Resource();
                    if(video != null&& !video.isEmpty()){
                        resource.setVideo(this.uploadService.handleUploadFile(video, "videos", "video"));
                    }
                    if(document != null&& !document.isEmpty()){
                        resource.setDocument(this.uploadService.handleUploadFile(document, "documents", "document"));
                    }
                    resource.setLesson(lesson);
                    lesson.getResources().add(resource);
                }
                lesson.setSection(section);
                section.getLessons().add(lesson);
            }

            course.getSections().add(section);   
        }
        this.courseRepository.save(course);
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

    public CourseDTO handleConvertCourseSettingToCourseDTO(Course course, CourseDTO courseDTO){
        courseDTO.setPrice(course.getOriginalPrice());
        courseDTO.setCurrency(course.getCurrency());
        courseDTO.setLevel(course.getLevel().getLevelName());
        courseDTO.setCategory(course.getCategory().getDescription());
        courseDTO.setLanguage(course.getLanguage());
        return courseDTO;
    }

    public CourseDTO handleConvertCourseToCourseDTO(Course course, CourseDTO courseDTO){
        courseDTO = this.handleConvertCourseBasicToCourseDTO(course, courseDTO);
        courseDTO = this.handleConvertCourseCurriculumToCourseDTO(courseDTO, course);
        courseDTO = this.handleConvertCourseSettingToCourseDTO(course, courseDTO);
        return courseDTO;
    }
}

