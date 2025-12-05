package vn.web.courseShop.domain.dto;

import java.util.ArrayList;
import java.util.List;

public class SectionDTO {
    private String title;
    private List<LessonDTO> lessons= new ArrayList<>();
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public List<LessonDTO> getLessons() {
        return lessons;
    }
    public void setLessons(List<LessonDTO> lessons) {
        this.lessons = lessons;
    }
}
