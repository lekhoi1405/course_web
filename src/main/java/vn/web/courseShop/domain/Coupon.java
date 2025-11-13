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
@Table(name = "coupons")
public class Coupon {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @OneToMany(mappedBy = "coupon")
    private List<CouponDetail> couponDetails;

    private long discountPercent;
    private long minPurchase;
    private long maxDiscount;
    private String coupon_des;
    private LocalDate start_date;
    private LocalDate end_date;
    private String status; 
}
