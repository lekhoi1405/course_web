package vn.web.courseShop.domain.dto;

import org.springframework.web.multipart.MultipartFile;

public class LessonDTO {
    private String title;
    private MultipartFile videoFile; 
    private MultipartFile docFile;
    private String videoFileUrl;
    private String docFileUrl;
    public String getVideoFileUrl() {
        return videoFileUrl;
    }
    public void setVideoFileUrl(String videoFileUrl) {
        this.videoFileUrl = videoFileUrl;
    }
    public String getDocFileUrl() {
        return docFileUrl;
    }
    public void setDocFileUrl(String docFileUrl) {
        this.docFileUrl = docFileUrl;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public MultipartFile getVideoFile() {
        return videoFile;
    }
    public void setVideoFile(MultipartFile videoFile) {
        this.videoFile = videoFile;
    }
    public MultipartFile getDocFile() {
        return docFile;
    }
    public void setDocFile(MultipartFile docFile) {
        this.docFile = docFile;
    }
}
