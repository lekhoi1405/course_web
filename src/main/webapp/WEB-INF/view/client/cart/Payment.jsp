<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form"%><%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Thanh toán - EduLearn</title>
    <link rel="stylesheet" href="/css/style.css" />
  </head>
  <body>
    <!-- header start -->
    <jsp:include page="../layout/header.jsp" />
    <!-- header end -->

    <div class="main-content">
      <div class="checkout-page">
        <!-- Header -->
        <div class="checkout-header-wrapper">
          <div class="checkout-header">
            <a href="MyCart.html" class="back-link">
              <img src="/images/myCart/icon_back.svg" alt="Back" />
            </a>
            <h1 class="checkout-title">Thanh toán</h1>
          </div>
        </div>

        <div class="checkout-container">
          <div class="checkout-content">
            <!-- Left Column -->
            <div class="checkout-left">
              <!-- Selected Courses -->
              <div class="checkout-courses-card">
                <h3 class="checkout-section-title">Khóa học đã chọn</h3>

                <c:forEach var="tutor" items="${list}">
                  <!-- Instructor Group -->
                  <div class="instructor-group">
                    <div class="instructor-info">
                      <img
                        src="/images/myCart/container_avt.svg"
                        alt="Avatar"
                        class="instructor-avatar"
                      />
                      <span class="instructor-name">${tutor.key}</span>
                    </div>
                    <c:forEach var="course" items="${tutor.value}">
                      <div class="checkout-course-item">
                        <div class="checkout-course-thumbnail">
                          <div class="checkout-thumbnail-placeholder">
                            <img style="width: 100%;height: 100%; object-fit: fill;
                            display:block;border-radius: 6px;"
                            src="/images/courseThumbnail/${course.thumbnailUrl}"
                            alt="">
                          </div>
                        </div>
                        <div class="checkout-course-info">
                          <h4 class="checkout-course-title">
                            ${course.courseTitle}
                          </h4>
                          <div class="checkout-course-price">
                            <span class="checkout-original-price">$49.99</span>
                            <span class="checkout-current-price"
                              ><fmt:formatNumber
                                value="${course.originalPrice}"
                                type="number"
                              />đ</span
                            >
                          </div>
                        </div>
                      </div>
                    </c:forEach>
                  </div>
                </c:forEach>
                <!-- Subtotal -->
                <div class="checkout-subtotal">
                  <span class="subtotal-label">Tạm tính:</span>
                  <span class="subtotal-value"
                    ><fmt:formatNumber value="${total}" type="number" />đ</span
                  >
                </div>
              </div>

              <!-- Voucher Section -->
              <div class="checkout-voucher-card">
                <div class="voucher-header">
                  <img
                    src="/images/myCart/container_voucher.svg"
                    alt="Voucher"
                    class="voucher-icon"
                  />
                  <span class="voucher-title">Mã giảm giá</span>
                </div>

                <!-- Voucher Input -->
                <div class="voucher-input-group" id="voucherInputGroup">
                  <input
                    type="text"
                    class="voucher-input"
                    id="voucherInput"
                    placeholder="Nhập mã voucher"
                  />
                  <button class="voucher-apply-btn" id="voucherApplyBtn">
                    Áp dụng
                  </button>
                </div>

                <!-- Voucher Applied (hidden by default) -->
                <div
                  class="voucher-applied"
                  id="voucherApplied"
                  style="display: none"
                >
                  <div class="voucher-applied-header">
                    <div class="voucher-applied-info">
                      <span class="voucher-code" id="appliedVoucherCode"
                        >WELCOME20</span
                      >
                      <span class="voucher-status">
                        <svg
                          class="voucher-status-icon"
                          viewBox="0 0 24 24"
                          fill="none"
                          stroke="currentColor"
                          stroke-width="2"
                        >
                          <path d="M20 6L9 17l-5-5" />
                        </svg>
                        Đã áp dụng
                      </span>
                    </div>
                    <button class="voucher-remove-btn" id="voucherRemoveBtn">
                      Xóa
                    </button>
                  </div>
                  <p class="voucher-applied-desc" id="appliedVoucherDesc">
                    Giảm 20% cho đơn hàng đầu tiên
                  </p>
                  <p
                    class="voucher-applied-discount"
                    id="appliedVoucherDiscount"
                  >
                    Giảm $26.99
                  </p>
                </div>
              </div>

              <!-- Payment Methods -->
              <div class="checkout-payment-card">
                <h3 class="checkout-section-title">Phương thức thanh toán</h3>

                <div class="payment-methods">
                  <label class="payment-method selected">
                    <input type="radio" name="payment" value="momo" checked />
                    <div class="payment-method-content">
                      <div class="payment-icon momo-icon">
                        <img src="/images/myCart/icon_momo.svg" alt="MoMo" />
                      </div>
                      <div class="payment-info">
                        <span class="payment-name">Ví điện tử MoMo</span>
                        <span class="payment-desc"
                          >Thanh toán qua ứng dụng MoMo</span
                        >
                      </div>
                    </div>
                  </label>

                  <label class="payment-method">
                    <input type="radio" name="payment" value="bank" />
                    <div class="payment-method-content">
                      <div class="payment-icon bank-icon">
                        <img src="/images/myCart/icon_bank.svg" alt="Bank" />
                      </div>
                      <div class="payment-info">
                        <span class="payment-name">Chuyển khoản ngân hàng</span>
                        <span class="payment-desc"
                          >Chuyển khoản qua tài khoản ngân hàng</span
                        >
                      </div>
                    </div>
                  </label>
                </div>
              </div>
            </div>

            <!-- Right Column - Payment Summary -->
            <div class="checkout-right">
              <div class="checkout-summary-card">
                <h3 class="summary-title">Chi tiết thanh toán</h3>

                <div class="summary-row">
                  <span class="summary-label">Tổng tiền:</span>
                  <span class="summary-value" id="summarySubtotal"><fmt:formatNumber value="${total}" type="number" />đ</span>
                </div>

                <div class="summary-row">
                  <span class="summary-label">Giảm giá:</span>
                  <span class="summary-value discount" id="summaryDiscount"
                    >-$0.00</span
                  >
                </div>

                <div class="summary-divider"></div>

                <div class="summary-row total">
                  <span class="summary-label">Tổng thanh toán:</span>
                  <span class="summary-value total-price" id="summaryTotal"
                    >$0.00</span
                  >
                </div>

              <form action="/client/payment/pay" method="POST">
              <button class="btn-pay">Thanh toán</button>
              <input
                  type="hidden"
                  name="${_csrf.parameterName}"
                  value="${_csrf.token}"
                />
              </form>
                <p class="checkout-terms">
                  Bằng việc thanh toán, bạn đồng ý với<br />
                  <a href="#">Điều khoản sử dụng</a>
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- footer start -->
    <jsp:include page="../layout/footer.jsp" />
    <!-- footer end -->
  </body>
</html>
