<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form"%><%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>My Courses - EduLearn</title>
    <link rel="stylesheet" href="/css/style.css" />
  </head>
  <body>
    <!-- header start -->
    <jsp:include page="../layout/header.jsp" />
    <!-- header end -->

    <main class="tutor-courses-page">
      <div class="content">
        <!-- Page Title & Add Button -->
        <div class="tutor-header">
          <div class="tutor-title-section">
            <h1 class="tutor-page-title">My Courses</h1>
            <p class="tutor-page-subtitle">
              Create and manage your course content
            </p>
          </div>
          <a href="/client/tutor/course/add" class="btn-add-course">
            <img
              src="/images/tutorCourses/icon_add.svg"
              alt="Add"
              width="20"
              height="20"
            />
            <span>Add Course</span>
          </a>
        </div>

        <!-- Statistics Cards -->
        <div class="tutor-stats">
          <div class="tutor-stat-card">
            <img
              src="/images/tutorCourses/container_student.svg"
              alt="Students"
              class="stat-icon"
            />
            <div class="stat-content">
              <p class="stat-label">Total Students</p>
              <p class="stat-value">1,234</p>
            </div>
          </div>

          <div class="tutor-stat-card">
            <img
              src="/images/tutorCourses/container_revenue.svg"
              alt="Revenue"
              class="stat-icon"
            />
            <div class="stat-content">
              <p class="stat-label">Total Revenue</p>
              <p class="stat-value">$45,678</p>
            </div>
          </div>

          <div class="tutor-stat-card">
            <img
              src="/images/tutorCourses/container_star.svg"
              alt="Rating"
              class="stat-icon"
            />
            <div class="stat-content">
              <p class="stat-label">Average Rating</p>
              <div class="stat-rating">
                <span class="stat-value">4.8</span>
                <div class="stat-stars">
                  <img
                    src="/images/tutorCourses/icon_star.svg"
                    alt="Star"
                    width="16"
                    height="16"
                  />
                  <img
                    src="/images/tutorCourses/icon_star.svg"
                    alt="Star"
                    width="16"
                    height="16"
                  />
                  <img
                    src="/images/tutorCourses/icon_star.svg"
                    alt="Star"
                    width="16"
                    height="16"
                  />
                  <img
                    src="/images/tutorCourses/icon_star.svg"
                    alt="Star"
                    width="16"
                    height="16"
                  />
                  <img
                    src="/images/tutorCourses/icon_star.svg"
                    alt="Star"
                    width="16"
                    height="16"
                  />
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Search & Filter -->
        <div class="tutor-controls">
          <div class="tutor-search-wrapper">
            <img
              src="/images/tutorCourses/icon_search.svg"
              alt="Search"
              class="search-icon"
              width="20"
              height="20"
            />
            <input
              type="text"
              class="tutor-search-input"
              placeholder="Search courses..."
            />
          </div>
          <button class="tutor-filter-btn">
            <img
              src="/images/tutorCourses/icon_filter.svg"
              alt="Filter"
              width="20"
              height="20"
            />
            <span>All Courses (8)</span>
            <img
              src="/images/tutorCourses/icon_down.svg"
              alt="Dropdown"
              width="16"
              height="16"
            />
          </button>
        </div>

        <!-- Courses Table -->
        <div class="tutor-table-wrapper">
          <table class="tutor-courses-table">
            <thead>
              <tr>
                <th class="col-course">Course</th>
                <th class="col-date">Last Updated</th>
                <th class="col-price">Price</th>
                <th class="col-status">Status</th>
                <th class="col-actions">Actions</th>
              </tr>
            </thead>
            <tbody>
              <!-- Course Row 1 -->
              <c:forEach var="course" items="${courses}">
                <tr class="course-row">
                  <td class="course-info">
                    <h3 class="course-name">${course.courseTitle}</h3>
                    <p class="course-desc">${course.courseDesc}</p>
                  </td>
                  <td class="course-date">${course.lastUpdate}</td>
                  <td class="course-price">
                    <fmt:formatNumber
                      value="${course.originalPrice}"
                      type="number"
                    />đ
                  </td>
                  <td class="course-status">
                    <span class="status-badge status-${course.status}">
                      ${course.status}
                    </span>
                  </td>
                  <td class="course-actions">
                    <a
                      href="/client/tutor/course/add/basic?courseId=${course.id}"
                      class="action-btn edit-btn"
                    >
                      <img
                        src="/images/tutorCourses/button_edit.svg"
                        alt="Edit"
                        width="32"
                        height="32"
                      />
                    </a>
                    <form
                      action="/client/tutorCourses/deleteCourse"
                      method="POST"
                    >
                      <input
                        type="hidden"
                        name="courseId"
                        value="${course.id}"
                      />
                      <button class="action-btn delete-btn">
                        <img
                          src="/images/tutorCourses/button_delete.svg"
                          alt="Delete"
                          width="32"
                          height="32"
                        />
                      </button>
                      <input
                        type="hidden"
                        name="${_csrf.parameterName}"
                        value="${_csrf.token}"
                      />
                    </form>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>

        <!-- Pagination -->
        <div class="tutor-pagination">
          <button class="page-btn" disabled>Previous</button>
          <div class="page-info">Page 1 of 2</div>
          <button class="page-btn">Next</button>
        </div>
      </div>
    </main>

    <!-- footer start -->
    <jsp:include page="../layout/footer.jsp" />
    <!-- footer end -->
  </body>
</html>
<c:if test="${not empty message}">
  <script>
    alert("${message}");
  </script>
</c:if>
