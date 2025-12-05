package vn.web.courseShop.domain;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name ="invoices")
public class Invoice {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
      private long id;
    
    @ManyToOne
    @JoinColumn(name = "account_id")
    private Account account;

    @ManyToOne
    @JoinColumn(name = "coupon_code")
    private CouponDetail couponDetail;

    @OneToMany(mappedBy = "invoice")
    private List<InvoiceDetail> invoiceDetails;

    @Column(precision = 12, scale = 2)
    private BigDecimal purchaseTotalPrice;
    
    @Column(precision = 12, scale = 2)
    private BigDecimal priceDiscounted;

    @Column(length = 30)
    private String status;

    public long getId() {
      return id;
    }

    public void setId(long id) {
      this.id = id;
    }

    public Account getAccount() {
      return account;
    }

    public void setAccount(Account account) {
      this.account = account;
    }

    public CouponDetail getCouponDetail() {
      return couponDetail;
    }

    public void setCouponDetail(CouponDetail couponDetail) {
      this.couponDetail = couponDetail;
    }

    public List<InvoiceDetail> getInvoiceDetails() {
      return invoiceDetails;
    }

    public void setInvoiceDetails(List<InvoiceDetail> invoiceDetails) {
      this.invoiceDetails = invoiceDetails;
    }

    public BigDecimal getPurchaseTotalPrice() {
      return purchaseTotalPrice;
    }

    public void setPurchaseTotalPrice(BigDecimal purchaseTotalPrice) {
      this.purchaseTotalPrice = purchaseTotalPrice;
    }

    public BigDecimal getPriceDiscounted() {
      return priceDiscounted;
    }

    public void setPriceDiscounted(BigDecimal priceDiscounted) {
      this.priceDiscounted = priceDiscounted;
    }

    public String getStatus() {
      return status;
    }

    public void setStatus(String status) {
      this.status = status;
    }

    public LocalDate getPurchaseDate() {
      return purchaseDate;
    }

    public void setPurchaseDate(LocalDate purchaseDate) {
      this.purchaseDate = purchaseDate;
    }

    private LocalDate purchaseDate; 
}
