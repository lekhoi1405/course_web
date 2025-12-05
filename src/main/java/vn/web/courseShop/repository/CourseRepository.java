package vn.web.courseShop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.web.courseShop.domain.Account;
import vn.web.courseShop.domain.Course;
@Repository
public interface CourseRepository extends JpaRepository<Course,Long>{
    List<Course> findAllByAccount(Account account);    
}