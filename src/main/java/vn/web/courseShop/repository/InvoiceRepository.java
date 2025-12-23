package vn.web.courseShop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.web.courseShop.domain.Account;
import vn.web.courseShop.domain.Invoice;

public interface InvoiceRepository extends JpaRepository<Invoice,Long>{
    List<Invoice>findAllByAccount(Account account);
}
