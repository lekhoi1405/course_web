package vn.web.courseShop.domain;

import java.time.LocalDate;
import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "courses")
public class Course {
    @Id 
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @OneToMany(mappedBy = "course")
    private List<InvoiceDetail> invoiceDetails;

    @OneToMany(mappedBy = "course")
    private List<CartDetail> cartDetails;

    @OneToMany(mappedBy = "course")
    private List<Enrollment> enrollments;

    @OneToMany(mappedBy = "course")
    private List<Section> sections;

    @OneToMany(mappedBy = "course")
    private List<Review> reviews;

    @OneToMany(mappedBy = "course")
    private List<Report> reports;

    @ManyToOne
    @JoinColumn(name = "instructor_id")
    private Account account;

    @ManyToOne
    @JoinColumn(name = "level_id")
    private Level level;

    @ManyToOne
    @JoinColumn(name ="category_id")
    private Category category;
    
    private String courseTitle;
    private String thumbnailUrl;
    private Float originalPrice;
    private String courseDesc;
    private long duration;
    private long status;
    private String language;
    private LocalDate submitDate;
    private LocalDate lastUpdate; 
}
