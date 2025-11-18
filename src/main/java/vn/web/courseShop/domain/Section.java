package vn.web.courseShop.domain;

import java.util.List;

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

    @OneToMany(mappedBy = "section")
    private List<Lesson> lessons;

    @Column(name = "`index`")
    private long index;

    @Column(length = 500)
    private String sectionTitle;
    private long sectionDuration;
}
