package vn.web.courseShop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.web.courseShop.domain.Cart;

public interface CartRepository extends JpaRepository<Cart,Long>{
    
}
