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
      <div class="explore-page">
        <div class="content">
          <!-- Hero -->
          <section class="explore-hero">
            <h1 class="heading">Explore Courses</h1>
            <p class="desc">
              Discover thousands of courses from expert instructors around the
              world
            </p>
            <form action="/explore/search" method="POST">
            <div class="explore-search">
              <input
                type="text"
                placeholder="Search for courses, instructors, or topics..."
                name="search"
              />
              <button>Search</button>
              <input
                  type="hidden"
                  name="${_csrf.parameterName}"
                  value="${_csrf.token}"
                />
            </div>
            </form>
          </section>

          <hr class="explore-divider" />

          <!-- Popular Courses -->
          <section class="explore-popular">
            <div class="explore-popular__header">
              <div>
                <h2 class="heading no-textAlign" style="font-size: 24px">
                  Popular Courses
                </h2>
                <p class="desc no-textAlign">
                  Join millions of learners with these trending courses
                </p>
              </div>
            </div>

            <div class="explore-popular__grid">
              <c:forEach var="course" items="${list}">
              <article class="course-card recommend-card">
                <div class="course-card__image-wrapper">
                  <!-- Dùng ảnh thật nếu có -->
                  <div class="course-card__image-placeholder"><img style="width: 100%;height: 100%; object-fit: fill;
                      display:block;border-radius: 6px;"
                      src="/images/courseThumbnail/${course.thumbnailUrl}"
                      alt=""></div>

                  <div class="course-card__badges">
                    <span class="badge badge--dark">${course.level.levelName}</span>
                  </div>
                </div>

                <div class="course-card__body">
                  <div class="course-card__category">${course.category.description}</div>
                  <h3 class="course-card__title">
                    ${course.courseTitle}
                  </h3>
                  <p class="course-card__instructor">by ${course.account.fullname}</p>

                  <div class="course-card__meta">
                    <span>42h 30m</span>
                    <span>•</span>
                    <span>89,234 students</span>
                  </div>

                  <div class="course-card__rating">
                    ⭐ 4.8 <span>(1,234)</span>
                  </div>

                  <div class="course-card__footer">
                      <span class="course-card__price"
                        ><fmt:formatNumber
                          value="${course.originalPrice}"
                          type="number"
                        />đ</span
                      >
                      <a href="/course/${course.id}" style="text-decoration: none;" class="course-card__view-btn">
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
                        View Course
                      </a>
                    </div>
                </div>
              </article>
              </c:forEach>
            </div>

            <!-- Pagination -->
            <div class="explore-pagination">
              <button class="page-btn" disabled>&lt; Previous</button>
              <button class="page-btn page-btn--active">1</button>
              <button class="page-btn">2</button>
              <button class="page-btn">Next &gt;</button>
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
