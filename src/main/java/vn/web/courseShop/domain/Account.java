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
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "accounts")
public class Account {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @OneToMany(mappedBy = "account")
    private List<Invoice> invoices;

    @OneToMany(mappedBy = "account")
    private List<Enrollment> enrollments;

    @OneToMany(mappedBy = "account")
    private List<Course> courses;

    @OneToMany(mappedBy = "account")
    private List<UserLessonProgress> lessonProgresses;

    @OneToMany(mappedBy = "account")
    private List<Review> reviews;

    @OneToMany(mappedBy = "account")
    private List<Report> reports;

    @ManyToOne
    @JoinColumn(name = "role_id")
    private Role role;

    @OneToOne(mappedBy ="account")
    private Cart cart;

    private String email;
    private String password;
    private String fullname;
    private String aboutme;
    private String media_link;

    private LocalDate created_date;
    private boolean status;
    


    // private role long;
}
