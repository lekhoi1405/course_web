package vn.web.courseShop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.web.courseShop.domain.Course;
import vn.web.courseShop.domain.Invoice;
import vn.web.courseShop.domain.InvoiceDetail;

public interface InvoiceDetailRepository extends JpaRepository<InvoiceDetail,Long>{
     boolean existsByInvoiceAndCourse(Invoice invoice, Course course);
     void deleteByInvoiceAndCourse(Invoice invoice, Course course);
     InvoiceDetail findByInvoiceAndCourse(Invoice invoice, Course course);
}
