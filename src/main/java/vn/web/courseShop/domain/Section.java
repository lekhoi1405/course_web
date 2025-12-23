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
@Table(name = "sections")
public class Section {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @ManyToOne
    @JoinColumn(name ="course_id")
    private Course course;

    @OneToMany(mappedBy = "section", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Lesson> lessons = new ArrayList<Lesson>();

    @Column(name = "`index`")
    private long index;

    @Column(length = 500)
    private String sectionTitle;
    public long getId() {
        return id;
    }
    public Course getCourse() {
        return course;
    }
    public List<Lesson> getLessons() {
        return lessons;
    }
    public void setId(long id) {
        this.id = id;
    }
    public void setCourse(Course course) {
        this.course = course;
    }
    public void setLessons(List<Lesson> lessons) {
        this.lessons = lessons;
    }
    public void setIndex(long index) {
        this.index = index;
    }
    public void setSectionTitle(String sectionTitle) {
        this.sectionTitle = sectionTitle;
    }
    public void setSectionDuration(long sectionDuration) {
        this.sectionDuration = sectionDuration;
    }
    public long getIndex() {
        return index;
    }
    public String getSectionTitle() {
        return sectionTitle;
    }
    public long getSectionDuration() {
        return sectionDuration;
    }
    private long sectionDuration;
}
