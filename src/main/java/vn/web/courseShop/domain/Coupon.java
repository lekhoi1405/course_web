package vn.web.courseShop.domain;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
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

    @Column(precision = 12, scale = 2)
    private BigDecimal minPurchase;

    @Column(precision = 12, scale = 2)
    private BigDecimal maxDiscount;

    @Column(length = 200)
    private String coupon_des;

    @Column(length = 30)
    private String status; 
    private long discountPercent;
    private LocalDate start_date;
    private LocalDate end_date;

    
    public List<CouponDetail> getCouponDetails() {
        return couponDetails;
    }
    public void setCouponDetails(List<CouponDetail> couponDetails) {
        this.couponDetails = couponDetails;
    }
    public BigDecimal getMinPurchase() {
        return minPurchase;
    }
    public void setMinPurchase(BigDecimal minPurchase) {
        this.minPurchase = minPurchase;
    }
    public BigDecimal getMaxDiscount() {
        return maxDiscount;
    }
    public void setMaxDiscount(BigDecimal maxDiscount) {
        this.maxDiscount = maxDiscount;
    }
    public String getCoupon_des() {
        return coupon_des;
    }
    public void setCoupon_des(String coupon_des) {
        this.coupon_des = coupon_des;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public long getDiscountPercent() {
        return discountPercent;
    }
    public void setDiscountPercent(long discountPercent) {
        this.discountPercent = discountPercent;
    }
    public LocalDate getStart_date() {
        return start_date;
    }
    public void setStart_date(LocalDate start_date) {
        this.start_date = start_date;
    }
    public LocalDate getEnd_date() {
        return end_date;
    }
    public void setEnd_date(LocalDate end_date) {
        this.end_date = end_date;
    }
    public long getId() {
        return id;
    }
    public void setId(long id) {
        this.id = id;
    }

    
}
