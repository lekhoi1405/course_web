package vn.web.courseShop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.web.courseShop.domain.Role;

public interface RoleRepository extends JpaRepository<Role,Long>{
    Role findByName(String name);
}
