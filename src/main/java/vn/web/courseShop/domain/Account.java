package vn.web.courseShop.domain;
import java.time.LocalDate;
import java.util.List;

import jakarta.persistence.Column;
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

    @OneToOne(mappedBy ="account")
    private Cart cart;

    @ManyToOne
    @JoinColumn(name = "role_id")
    private Role role;

    @Column(length = 50)
    private String email;

    private String password;

    @Column(length = 50)
    private String fullname;

    @Column(length = 5000)
    private String aboutme;

    @Column(length = 1000)
    private String media_link;

    private LocalDate created_date;
    private boolean status;
    
    public long getId() {
        return id;
    }
    public void setId(long id) {
        this.id = id;
    }

    public List<Invoice> getInvoices() {
        return invoices;
    }
    public void setInvoices(List<Invoice> invoices) {
        this.invoices = invoices;
    }
    public List<Enrollment> getEnrollments() {
        return enrollments;
    }
    public void setEnrollments(List<Enrollment> enrollments) {
        this.enrollments = enrollments;
    }
    public List<Course> getCourses() {
        return courses;
    }
    public void setCourses(List<Course> courses) {
        this.courses = courses;
    }
    public List<UserLessonProgress> getLessonProgresses() {
        return lessonProgresses;
    }
    public void setLessonProgresses(List<UserLessonProgress> lessonProgresses) {
        this.lessonProgresses = lessonProgresses;
    }
    public List<Review> getReviews() {
        return reviews;
    }
    public void setReviews(List<Review> reviews) {
        this.reviews = reviews;
    }
    public List<Report> getReports() {
        return reports;
    }
    public void setReports(List<Report> reports) {
        this.reports = reports;
    }
    public Cart getCart() {
        return cart;
    }
    public void setCart(Cart cart) {
        this.cart = cart;
    }
    public Role getRole() {
        return role;
    }
    public void setRole(Role role) {
        this.role = role;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getFullname() {
        return fullname;
    }
    public void setFullname(String fullname) {
        this.fullname = fullname;
    }
    public String getAboutme() {
        return aboutme;
    }
    public void setAboutme(String aboutme) {
        this.aboutme = aboutme;
    }
    public String getMedia_link() {
        return media_link;
    }
    public void setMedia_link(String media_link) {
        this.media_link = media_link;
    }
    public LocalDate getCreated_date() {
        return created_date;
    }
    public void setCreated_date(LocalDate created_date) {
        this.created_date = created_date;
    }
    public boolean isStatus() {
        return status;
    }
    public void setStatus(boolean status) {
        this.status = status;
    }
    @Override
    public String toString() {
        return "Account [id=" + id + ", invoices=" + invoices + ", enrollments=" + enrollments + ", courses=" + courses
                + ", lessonProgresses=" + lessonProgresses + ", reviews=" + reviews + ", reports=" + reports + ", cart="
                + cart + ", role=" + role + ", email=" + email + ", password=" + password + ", fullname=" + fullname
                + ", aboutme=" + aboutme + ", media_link=" + media_link + ", created_date=" + created_date + ", status="
                + status + "]";
    }

    
}
