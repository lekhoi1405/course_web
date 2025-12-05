package vn.web.courseShop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.web.courseShop.domain.Category;

public interface CategoryRepository extends JpaRepository<Category,Long>{
    Category findByDescription(String description);
}
