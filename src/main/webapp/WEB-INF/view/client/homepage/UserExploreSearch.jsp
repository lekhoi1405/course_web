<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form"%><%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Explore Courses - EduLearn</title>
    <link rel="stylesheet" href="/css/style.css" />
  </head>
  <body>
    <!-- header start -->
    <jsp:include page="../layout/header.jsp" />
    <!-- header end -->

    <div class="main-content">
      <div class="user-explore-page">
        <div class="content">
          <!-- Hero Section -->
          <section class="explore-hero">
            <h1 class="explore-title">Explore Courses</h1>
            <p class="explore-subtitle">
              Discover thousands of courses from expert instructors around the
              world
            </p>

            <!-- Search Bar -->
            <div class="explore-search-wrapper">
              <form action="/explore/search" method="POST">
                <div class="explore-search">
                  <svg
                    class="search-icon"
                    width="20"
                    height="20"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                  >
                    <circle cx="11" cy="11" r="8"></circle>
                    <path d="m21 21-4.35-4.35"></path>
                  </svg>

                  <input
                    type="text"
                    placeholder="Search for courses, instructors, or topics..."
                    name="search"
                  />
                  <button class="search-btn">Search</button>
                </div>
                <input
                  type="hidden"
                  name="${_csrf.parameterName}"
                  value="${_csrf.token}"
                />
              </form>
            </div>
          </section>

          <!-- Popular Courses Section -->
          <section class="popular-courses-section">
            <div class="section-header">
              <div>
                <h2 class="section-title">Search Results for "${title}"</h2>
                <p class="section-desc">Found ${count} course</p>
              </div>
            </div>

            <div class="explore-course-grid">
              <c:forEach var="course" items="${list}">
                <!-- Course Card -->
                <article class="explore-course-card">
                  <div class="explore-course-image">
                    <div class="course-card__image-placeholder">
                      <a
                        href="/course/${course.id}"
                        style="
                          display: block;
                          width: 100%;
                          height: 100%;
                          text-decoration: none;
                        "
                      >
                        <img
                          style="
                            width: 100%;
                            height: 100%;
                            object-fit: fill;
                            display: block;
                            border-radius: 6px;
                          "
                          src="/images/courseThumbnail/${course.thumbnailUrl}"
                          alt=""
                        />
                      </a>
                    </div>
                    <div class="explore-course-badges">
                      <span class="badge badge--dark"
                        >${course.level.levelName}</span
                      >
                    </div>
                  </div>

                  <div class="explore-course-body">
                    <div class="course-category">
                      ${course.category.description}
                    </div>
                    <h3 class="explore-course-title">${course.courseTitle}</h3>
                    <p class="explore-course-instructor">
                      ${course.account.fullname}
                    </p>

                    <div class="explore-course-meta">
                      <div class="students-count">
                        <img
                          src="/images/userDashboard/icon_pp.svg"
                          alt="Students"
                          width="16"
                          height="16"
                        />
                        <span>89,234</span>
                      </div>
                      <div class="rating">
                        <img
                          src="/images/userDashboard/icon_star.svg"
                          alt="Star"
                          width="16"
                          height="16"
                        />
                        <span class="rating-score">4.8</span>
                        <span class="rating-count">(12,543)</span>
                      </div>
                    </div>

                    <div class="explore-course-footer">
                      <div class="price-box">
                        <span class="current-price"
                          ><fmt:formatNumber
                            value="${course.originalPrice}"
                            type="number"
                          />đ</span
                        >
                      </div>
                      <a
                        style="text-decoration: none"
                        href="/course/${course.id}"
                        class="view-course-btn"
                        >View Course</a
                      >
                    </div>
                  </div>
                </article>
              </c:forEach>
            </div>

            <!-- Pagination -->
            <div class="pagination">
              <button class="page-btn" disabled>
                <svg
                  width="16"
                  height="16"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                >
                  <path d="M15 18l-6-6 6-6" />
                </svg>
                Previous
              </button>
              <div class="page-numbers">
                <button class="page-num active">1</button>
                <button class="page-num">2</button>
              </div>
              <button class="page-btn">
                Next
                <svg
                  width="16"
                  height="16"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                >
                  <path d="M9 18l6-6-6-6" />
                </svg>
              </button>
            </div>
          </section>
        </div>
      </div>
    </div>

    <!-- footer start -->
    <jsp:include page="../layout/footer.jsp" />
    <!-- footer end -->
  </body>
</html>
