package vn.web.courseShop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.web.courseShop.domain.Account;
import vn.web.courseShop.domain.Course;
import vn.web.courseShop.domain.Enrollment;
import java.util.List;


public interface EnrollmentRepository extends JpaRepository<Enrollment,Long>{
    boolean existsByAccountAndCourse(Account account, Course course);
    List<Enrollment> findAllByAccount(Account account);
}
