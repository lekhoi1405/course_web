package vn.web.courseShop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.web.courseShop.domain.Account;

public interface AccountRepository extends JpaRepository<Account, Long> {
    
}
