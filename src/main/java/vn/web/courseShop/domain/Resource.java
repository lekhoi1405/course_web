package vn.web.courseShop.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "resources")
public class Resource {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @ManyToOne
    @JoinColumn(name = "lesson_id")
    private Lesson lesson;

    @Column(name = "`index`")
    private Long index;
    
    private String video;
    private String document;
    public long getId() {
        return id;
    }
    public void setId(long id) {
        this.id = id;
    }
    public Lesson getLesson() {
        return lesson;
    }
    public void setLesson(Lesson lesson) {
        this.lesson = lesson;
    }
    public Long getIndex() {
        return index;
    }
    public void setIndex(Long index) {
        this.index = index;
    }
    public String getVideo() {
        return video;
    }
    public void setVideo(String video) {
        this.video = video;
    }
    public String getDocument() {
        return document;
    }
    public void setDocument(String document) {
        this.document = document;
    }

    

    
}
