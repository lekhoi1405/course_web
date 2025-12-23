<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form"%><%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Home Page</title>
    <link rel="stylesheet" href="/css/style.css" />
  </head>
  <body>
    <!-- header start -->
    <jsp:include page="../layout/header.jsp" />
    <!-- header end -->

    <div class="main-content">
      <main class="course-page">
        <!-- Breadcrumb -->
        <div class="breadcrumb">
          <img src="/images/ViewCourse/arrow-left.svg" alt="" />
          <a href="/explore">Back to Explore</a>
        </div>

        <!-- Layout -->
        <div class="course-layout">
          <!-- LEFT COLUMN -->
          <div class="course-main">
            <!-- HEADER CARD -->
            <div class="course-header-card">
              <span class="badge--blue">Best Seller</span>

              <h1 class="course-title">${courseDTO.courseTitle}</h1>

              <p class="course-meta">
                Updated January 2025 • 42 hours • ${courseDTO.level}
              </p>

              <div class="rating-summary__stars no-textAlign">
                <span class="stars" data-rating="4"></span>
              </div>

              <p class="course-short-desc"></p>
            </div>

            <!-- WHAT YOU WILL LEARN -->
            <div class="learn-box">
              <h2 class="section-title">What you’ll learn</h2>
              <c:forEach var="courseTarget" items="${courseDTO.targets}">
                <ul class="learn-list">
                  <li class="learn-list-item">${courseTarget}</li>
                </ul>
              </c:forEach>
            </div>

            <!-- DESCRIPTION -->
            <div class="description-box">
              <h2 class="section-title">Course Description</h2>

              <p>${courseDTO.courseDesc}</p>
            </div>

            <!-- PREREQUISITES -->
            <div class="learn-box">
              <h2 class="section-title">Prerequisites</h2>
              <c:forEach var="courseTarget" items="${courseDTO.prerequisites}">
                <ul class="learn-list">
                  <li class="learn-list-item">${courseTarget}</li>
                </ul>
              </c:forEach>
            </div>

            <!-- CURRICULUM -->
            <div class="curriculum-box">
              <div class="curriculum-box__header">
                <h2 class="section-title">Course Curriculum</h2>
                <span class="curriculum-total">42 lessons</span>
              </div>

              <div class="curriculum-sections">
                <!-- SECTION 1 -->
                <c:forEach var="courseSection" items="${courseDTO.sectionDTOs}">
                  <div class="curriculum-section">
                    <div class="curriculum-section__header">
                      <div class="curriculum-section__title">
                        ${courseSection.title}
                      </div>
                      <div class="curriculum-section__duration">12 min</div>
                    </div>
                    <c:forEach
                      var="courseLesson"
                      items="${courseSection.lessons}"
                    >
                      <ul class="curriculum-lessons">
                        <li class="curriculum-lesson">
                          <div class="curriculum-lesson__left">
                            <span class="curriculum-lesson__title icon-video"
                              >${courseLesson.title}</span
                            >
                          </div>
                          <span class="curriculum-lesson__time">2:10</span>
                        </li>
                      </ul>
                    </c:forEach>
                  </div>
                </c:forEach>
              </div>
            </div>
          </div>

          <!-- RIGHT SIDEBAR -->
          <aside class="course-sidebar">
            <img
              class="course-preview"
              src="/images/courseThumbnail/${courseDTO.thumbnailUrl}"
              alt="Course preview"
            />

            <div class="course-price">
              <fmt:formatNumber value="${courseDTO.price}" type="number" />đ
            </div>

            <button class="buy-btn">Buy Now</button>
            <form
              action="/client/add-to-cart/${courseDTO.courseId}"
              method="post"
            >
              <input
                type="hidden"
                name="${_csrf.parameterName}"
                value="${_csrf.token}"
              />
              <button class="cart-btn">Add to Cart</button>
            </form>
          </aside>
        </div>
      </main>
    </div>
    <!-- footer start -->
    <jsp:include page="../layout/footer.jsp" />
    <!-- footer end -->
    <script>
      const currentPage = window.location.pathname.split("/").pop();
      document.querySelectorAll(".nav-link").forEach((link) => {
        if (link.getAttribute("href") === currentPage) {
          link.classList.add("active");
        }
      });

      // sao động
      document.querySelectorAll(".stars").forEach((el) => {
        const r = parseFloat(el.dataset.rating || "0");
        const clamped = Math.max(0, Math.min(5, r)); // 0–5
        el.style.setProperty("--rating", clamped);
        el.setAttribute("aria-label", `${clamped} out of 5`);
      });
    </script>
  </body>
</html>
<c:if test="${not empty error}">
  <script>
    alert("${error}");
  </script>
</c:if>

<c:if test="${not empty message}">
  <script>
    alert("${message}");
  </script>
</c:if>
