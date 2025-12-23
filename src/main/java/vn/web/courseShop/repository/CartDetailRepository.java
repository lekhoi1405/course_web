package vn.web.courseShop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.web.courseShop.domain.Cart;
import vn.web.courseShop.domain.CartDetail;
import vn.web.courseShop.domain.Course;

public interface CartDetailRepository extends JpaRepository<CartDetail,Long>{
    boolean existsByCartAndCourse(Cart cart, Course course);
    int countByCart(Cart cart);
    Course deleteAllByCourse(Course course);
}
