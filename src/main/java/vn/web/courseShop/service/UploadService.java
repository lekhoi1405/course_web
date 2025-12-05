package vn.web.courseShop.service;

import java.io.File;
import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.ServletContext;

@Service
public class UploadService {
    private final ServletContext servletContext;

    public UploadService( ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    public String handleUploadFile(MultipartFile file, String folder,String targetFolder){

        String rootPath = this.servletContext.getRealPath("/resources/"+folder); 
        String finalName= "";
        try {
            File dir = new File(rootPath + File.separator + targetFolder); 
            if (!dir.exists()) dir.mkdirs(); 
  
            finalName = System.currentTimeMillis() + "-" + file.getOriginalFilename();
            File serverFile = new File(dir.getAbsolutePath() + File.separator + finalName); 

            file.transferTo(serverFile); 

            } catch (IOException e) {
                e.printStackTrace();
        }
        return finalName;
    }
}
