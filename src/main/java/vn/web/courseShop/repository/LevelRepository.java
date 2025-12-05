package vn.web.courseShop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.web.courseShop.domain.Level;

public interface LevelRepository extends JpaRepository<Level,Long>{
    Level findByLevelName(String levelName);
    
} 