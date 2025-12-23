<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form"%><%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>My Cart - EduLearn</title>
    <link rel="stylesheet" href="/css/style.css" />
  </head>
  <body>
    <!-- header start -->
    <jsp:include page="../layout/header.jsp" />
    <!-- header end -->

    <div class="main-content">
      <div class="cart-page">
        <div class="cart-container">
          <!-- Cart Header -->
          <div class="cart-header">
            <h1 class="cart-title">My Cart</h1>
            <p class="cart-count">${countCart} courses in your cart</p>
          </div>

          <div class="cart-content">
            <!-- Cart Items -->
            <div class="cart-items">
              <!-- Cart Item -->
              <c:forEach var="course" items="${list}">
                <div class="cart-item">
                  <form action="/client/invoice/delete-course" method="POST">
                  <input type="hidden" name="courseId" value="${course.id}" />
                  <button class="cart-delete-btn">
                    <img src="/images/myCart/button_delete.svg" alt="Delete" />
                  </button>
                    <input
                      type="hidden"
                      name="${_csrf.parameterName}"
                      value="${_csrf.token}"
                    />
                  </form>

                  <div class="cart-item-checkbox">
                    <c:set var="isChecked" value="false" />
                      <c:if test="${not empty listId}">
                          <c:forEach var="selectedId" items="${listId}">
                              <c:if test="${selectedId == course.id}">
                                  <c:set var="isChecked" value="true" />
                              </c:if>
                          </c:forEach>
                      </c:if>
                  <form action="/client/invoice/add-course" method="POST">
                  <input type="hidden" name="courseId" value="${course.id}" />
                    <input
                      type="checkbox"
                      id="item_${course.id}"
                      class="item-checkbox"
                      onchange="this.form.submit()"
                      ${isChecked ? 'checked' : ''}
                    />
                    <label for="item_${course.id}"></label>
                    <input
                      type="hidden"
                      name="${_csrf.parameterName}"
                      value="${_csrf.token}"
                    />
                   </form>
                  </div>


                  <div class="cart-item-thumbnail">
                    <div class="cart-thumbnail-placeholder">
                      <img style="width: 100%;height: 100%; object-fit: fill;
                      display:block;border-radius: 6px;"
                      src="/images/courseThumbnail/${course.thumbnailUrl}"
                      alt="">
                    </div>
                  </div>
                  <div class="cart-item-info">
                    <h3 class="cart-item-title">${course.courseTitle}</h3>
                    <p class="cart-item-instructor">
                      ${course.account.fullname}
                    </p>
                    <div class="cart-item-rating">
                      <span class="rating-score">4.8</span>
                      <img
                        src="/images/myCart/icon_star.svg"
                        alt="Star"
                        class="rating-star"
                      />
                      <span class="rating-count">(15,420)</span>
                    </div>
                    <p class="cart-item-duration">42 hours</p>
                  </div>
                  <div class="cart-item-price">
                    <span class="current-price"
                      ><fmt:formatNumber
                        value="${course.originalPrice}"
                        type="number"
                      />đ</span
                    >
                    <span class="original-price"></span>
                  </div>
                </div>
              </c:forEach>
            </div>

            <!-- Order Summary -->
            <div class="cart-summary">
              <h3 class="summary-title">Tóm tắt đơn hàng</h3>

              <div class="summary-row">
                <span class="summary-label">Giá gốc:</span>
                <span class="summary-value">
                  <fmt:formatNumber
                    value="${total}"
                     type="number"
                  />đ</span>
              </div>

              <div class="summary-row">
                <span class="summary-label">Giảm giá:</span>
                <span class="summary-value discount" id="discountPrice"
                  >-$0.00</span
                >
              </div>

              <div class="summary-divider"></div>

              <div class="summary-row total">
                <span class="summary-label">Tổng cộng:</span>
                <span class="summary-value total-price"
                  ><fmt:formatNumber
                        value="${total}"
                        type="number"
                  />đ</span
                >
              </div>
              <c:if test="${empty listId}">     
                  <div class="summary-notice" id="summaryNotice">
                    <p>Vui lòng chọn ít nhất 1 khóa học để thanh toán</p>
                  </div>
              </c:if>
              <c:if test="${not empty listId}">  
              <form action="/client/payment" method="POST">
              <button class="btn-checkout">
                Thanh toán (<span>${count}</span>)
              </button>
              <input
                  type="hidden"
                  name="${_csrf.parameterName}"
                  value="${_csrf.token}"
                />
              </form>
              </c:if>
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
