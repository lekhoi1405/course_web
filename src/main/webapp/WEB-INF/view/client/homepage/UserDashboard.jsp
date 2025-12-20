<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form"%><%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>My Dashboard - EduLearn</title>
    <link rel="stylesheet" href="/css/style.css" />
  </head>
  <body>
    <!-- header start -->
    <jsp:include page="../layout/header.jsp" />
    <!-- header end -->

    <div class="main-content">
      <div class="dashboard-page">
        <div class="content">
          <!-- Welcome Section -->
          <section class="dashboard-welcome">
            <div class="welcome-content">
              <h1 class="heading">Welcome back, ${sessionScope.fullName}</h1>
              <p class="desc">Ready to continue your learning journey?</p>
            </div>
          </section>

          <!-- Continue Learning Section -->
          <section class="dashboard-section">
            <div class="section-header">
              <h2 class="section-title">Continue Learning</h2>
              <a href="#" class="view-all">
                View All
                <svg
                  width="16"
                  height="16"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                >
                  <path d="M5 12h14M12 5l7 7-7 7" />
                </svg>
              </a>
            </div>

            <div class="home-featured__grid">
              <!-- Course Card 1 -->
              <article class="course-card continue-card">
                <div class="course-card__image-wrapper">
                  <div class="course-card__image-placeholder"></div>
                  <div class="course-card__badges">
                    <span class="badge badge--quiz">Quiz 3 - 2d left</span>
                  </div>
                </div>

                <div class="course-card__body">
                  <h3 class="course-card__title">React for Beginners</h3>
                  <p class="course-card__instructor">by John Doe</p>

                  <div class="course-progress">
                    <span class="progress-label">Progress</span>
                    <div class="progress-bar">
                      <div class="progress-fill" style="width: 45%"></div>
                    </div>
                    <span class="progress-text">45%</span>
                  </div>

                  <div class="course-next-resume">
                    <p class="course-next">Next: State & Props</p>
                    <button class="btn-resume">
                      <svg
                        width="14"
                        height="14"
                        viewBox="0 0 24 24"
                        fill="currentColor"
                      >
                        <polygon points="5 3 19 12 5 21 5 3"></polygon>
                      </svg>
                      Resume
                    </button>
                  </div>
                </div>
              </article>
            </div>
          </section>

          <!-- Recommended For You Section -->
          <section class="dashboard-section">
            <div class="section-header">
              <h2 class="section-title">Recommended for You</h2>
              <a href="#" class="view-all">
                View All
                <svg
                  width="16"
                  height="16"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                >
                  <path d="M5 12h14M12 5l7 7-7 7" />
                </svg>
              </a>
            </div>

            <div class="home-featured__grid home-featured__grid--4">
              <!-- Recommended Course 1 -->
              <c:forEach var="courseRecommend" items="${recommendList}">
                <article class="course-card recommend-card">
                  <div class="course-card__image-wrapper">
                    <div class="course-card__image-placeholder">
                      <a href="/course/${courseRecommend.id}">
                        <img
                          src="/images/courseThumbnail/${courseRecommend.thumbnailUrl}"
                          alt=""
                        />
                      </a>
                    </div>
                  </div>

                  <div class="course-card__body">
                    <h3 class="course-card__title">
                      ${courseRecommend.courseTitle}
                    </h3>
                    <p class="course-card__instructor">
                      by ${courseRecommend.account.fullname}
                    </p>

                    <div class="course-card__rating">
                      <span class="star-icon">★</span>
                      <span class="rating-score">4.8</span>
                      <span class="rating-count">(12,450 students)</span>
                    </div>

                    <div class="course-card__footer">
                      <span class="course-card__price"
                        ><fmt:formatNumber
                          value="${courseRecommend.originalPrice}"
                          type="number"
                        />đ</span
                      >
                      <button class="btn-add-cart">
                        <svg
                          width="14"
                          height="14"
                          viewBox="0 0 24 24"
                          fill="none"
                          stroke="currentColor"
                          stroke-width="2"
                        >
                          <circle cx="9" cy="21" r="1"></circle>
                          <circle cx="20" cy="21" r="1"></circle>
                          <path
                            d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"
                          ></path>
                        </svg>
                        Add to Cart
                      </button>
                    </div>
                  </div>
                </article>
              </c:forEach>
            </div>
          </section>
        </div>
      </div>
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
    </script>
  </body>
</html>
