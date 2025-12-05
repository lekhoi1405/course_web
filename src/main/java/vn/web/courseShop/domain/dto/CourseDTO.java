package vn.web.courseShop.domain.dto;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class CourseDTO {
    private String courseTitle;
    private Double originalPrice;
    private String courseDesc;    
    private long courseId;
    private List<String> targets; 
    private List<String> prerequisites;
    private List<SectionDTO> sectionDTOs = new ArrayList<>();
    private String level;
    private String thumbnailUrl;
    private String category;
    private String currency;
    private String language;
    private BigDecimal price;

    public BigDecimal getPrice() {
        return price;
    }
    public String getThumbnailUrl() {
        return thumbnailUrl;
    }
    public void setThumbnailUrl(String thumbnailUrl) {
        this.thumbnailUrl = thumbnailUrl;
    }
    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getCourseTitle() {
        return courseTitle;
    }
    public String getLevel() {
        return level;
    }
    public String getCurrency() {
        return currency;
    }
    public void setCurrency(String currency) {
        this.currency = currency;
    }
    public String getLanguage() {
        return language;
    }
    public void setLanguage(String language) {
        this.language = language;
    }
    public void setLevel(String level) {
        this.level = level;
    }
    public String getCategory() {
        return category;
    }
    public void setCategory(String category) {
        this.category = category;
    }
    public long getCourseId() {
        return courseId;
    }
    public void setCourseId(long courseId) {
        this.courseId = courseId;
    }
    public void setCourseTitle(String courseTitle) {
        this.courseTitle = courseTitle;
    }
    public Double getOriginalPrice() {
        return originalPrice;
    }
    public void setOriginalPrice(Double originalPrice) {
        this.originalPrice = originalPrice;
    }
    public String getCourseDesc() {
        return courseDesc;
    }
    public void setCourseDesc(String courseDesc) {
        this.courseDesc = courseDesc;
    }
    public List<String> getTargets() {
        return targets;
    }
    public void setTargets(List<String> targets) {
        this.targets = targets;
    }
    public List<String> getPrerequisites() {
        return prerequisites;
    }
    public void setPrerequisites(List<String> prerequisites) {
        this.prerequisites = prerequisites;
    }
    public List<SectionDTO> getSectionDTOs() {
        return sectionDTOs;
    }
    public void setSectionDTOs(List<SectionDTO> sectionDTOs) {
        this.sectionDTOs = sectionDTOs;
    }

}
