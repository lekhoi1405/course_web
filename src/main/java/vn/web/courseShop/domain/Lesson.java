package vn.web.courseShop.domain;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "lessons")
public class Lesson {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    
    @ManyToOne
    @JoinColumn(name = "section_id")
    private Section section;

    @OneToMany(mappedBy = "lesson")
    private List<UserLessonProgress> userLessonProgresses;

    @OneToMany(mappedBy = "lesson", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Resource> resources = new ArrayList<Resource>();

    @Column(name = "`index`")
    private long index;

    @Column(length = 500)
    private String lessonTitle;
    private long duration;

     public long getId() {
        return id;
    }
    public void setId(long id) {
        this.id = id;
    }
    public Section getSection() {
        return section;
    }
    public void setSection(Section section) {
        this.section = section;
    }
    public List<UserLessonProgress> getUserLessonProgresses() {
        return userLessonProgresses;
    }
    public void setUserLessonProgresses(List<UserLessonProgress> userLessonProgresses) {
        this.userLessonProgresses = userLessonProgresses;
    }
    public List<Resource> getResources() {
        return resources;
    }
    public void setResource(List<Resource> resources) {
        this.resources = resources;
    }
    public long getIndex() {
        return index;
    }
    public void setIndex(long index) {
        this.index = index;
    }
    public String getLessonTitle() {
        return lessonTitle;
    }
    public void setLessonTitle(String lessonTitle) {
        this.lessonTitle = lessonTitle;
    }
    public long getDuration() {
        return duration;
    }
    public void setDuration(long duration) {
        this.duration = duration;
    }
}
