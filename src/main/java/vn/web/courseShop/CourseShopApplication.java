package vn.web.courseShop;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(exclude = { org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration.class}) 
public class CourseShopApplication {

	public static void main(String[] args) {
		SpringApplication.run(CourseShopApplication.class, args);
	}

}
