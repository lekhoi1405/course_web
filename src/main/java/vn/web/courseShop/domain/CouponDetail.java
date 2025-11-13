package vn.web.courseShop.domain;

import java.time.LocalDate;
import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "couponDetails")
public class CouponDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @OneToMany(mappedBy = "couponDetail")
    private List<Invoice> invoices;

    @ManyToOne
    @JoinColumn(name = "coupon_id")
    private Coupon coupon;

    private boolean isUsed;
    private LocalDate useDate;

}   
