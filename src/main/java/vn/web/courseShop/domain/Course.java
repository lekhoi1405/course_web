package vn.web.courseShop.domain;

import java.math.BigDecimal;
import java.time.LocalDate;
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

    @OneToMany(mappedBy = "course", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Section> sections = new ArrayList<Section>();

    @OneToMany(mappedBy = "course")
    private List<Review> reviews;

    @OneToMany(mappedBy = "course", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<CoursePrerequisites> coursePrerequisites;

    @OneToMany(mappedBy = "course", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<CourseTarget> targets;

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
    
    @Column(length = 50)
    private String courseTitle;

    @Column(length = 500)
    private String thumbnailUrl;

    @Column(precision = 12, scale = 2)
    private BigDecimal originalPrice;

    @Column(length = 5000)
    private String courseDesc;
    
    @Column(length = 50)
    private String language;

    @Column(length = 50)
    private String status;

    private long duration;
    private LocalDate submitDate;
    private LocalDate lastUpdate;
    private String currency;

    public List<CoursePrerequisites> getCoursePrerequisites() {
        return coursePrerequisites;
    }
    public void setCoursePrerequisites(List<CoursePrerequisites> newPrerequisites) {
        if (this.coursePrerequisites == null) {
            this.coursePrerequisites = newPrerequisites;
        } else {
            this.coursePrerequisites.clear();
            if (newPrerequisites != null) {
                this.coursePrerequisites.addAll(newPrerequisites); 
            }
        }
    }
    public List<CourseTarget> getTargets() {
        return targets;
    }
    public void setTargets(List<CourseTarget> newTargets) {
        if (this.targets == null) {
            this.targets = newTargets;
        } else {
            this.targets.clear(); 
            if (newTargets != null) {
                this.targets.addAll(newTargets); 
            }
        }
    }
    public List<InvoiceDetail> getInvoiceDetails() {
        return invoiceDetails;
    }
    public void setInvoiceDetails(List<InvoiceDetail> invoiceDetails) {
        this.invoiceDetails = invoiceDetails;
    }
    public List<CartDetail> getCartDetails() {
        return cartDetails;
    }
    public void setCartDetails(List<CartDetail> cartDetails) {
        this.cartDetails = cartDetails;
    }
    public List<Enrollment> getEnrollments() {
        return enrollments;
    }
    public void setEnrollments(List<Enrollment> enrollments) {
        this.enrollments = enrollments;
    }
    public List<Section> getSections() {
        return sections;
    }
    public void setSections(List<Section> newSections) {
        if (this.sections == null) {
            this.sections = newSections;
        } else {
            this.sections.clear();
            if (newSections != null) {
                this.sections.addAll(newSections);
            }
        }
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
    public Account getAccount() {
        return account;
    }
    public void setAccount(Account account) {
        this.account = account;
    }
    public Level getLevel() {
        return level;
    }
    public void setLevel(Level level) {
        this.level = level;
    }
    public Category getCategory() {
        return category;
    }
    public void setCategory(Category category) {
        this.category = category;
    }
    public String getCourseTitle() {
        return courseTitle;
    }
    public void setCourseTitle(String courseTitle) {
        this.courseTitle = courseTitle;
    }
    public String getThumbnailUrl() {
        return thumbnailUrl;
    }
    public void setThumbnailUrl(String thumbnailUrl) {
        this.thumbnailUrl = thumbnailUrl;
    }
    public BigDecimal getOriginalPrice() {
        return originalPrice;
    }
    public void setOriginalPrice(BigDecimal originalPrice) {
        this.originalPrice = originalPrice;
    }
    public String getCourseDesc() {
        return courseDesc;
    }
    public void setCourseDesc(String courseDesc) {
        this.courseDesc = courseDesc;
    }
    public String getLanguage() {
        return language;
    }
    public void setLanguage(String language) {
        this.language = language;
    }
    public long getDuration() {
        return duration;
    }
    public void setDuration(long duration) {
        this.duration = duration;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public LocalDate getSubmitDate() {
        return submitDate;
    }
    public void setSubmitDate(LocalDate submitDate) {
        this.submitDate = submitDate;
    }
    public LocalDate getLastUpdate() {
        return lastUpdate;
    }
    public void setLastUpdate(LocalDate lastUpdate) {
        this.lastUpdate = lastUpdate;
    } 
    public long getId() {
        return id;
    }
    public void setId(long id) {
        this.id = id;
    }
    public String getCurrency() {
        return currency;
    }
    public void setCurrency(String currency) {
        this.currency = currency;
    }
}
