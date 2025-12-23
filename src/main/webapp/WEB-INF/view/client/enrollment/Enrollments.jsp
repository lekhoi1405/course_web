<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form"%><%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>My Learning - EduLearn</title>
    <link rel="stylesheet" href="/css/style.css" />
  </head>
  <body>
    <!-- header start -->
    <jsp:include page="../layout/header.jsp" />
    <!-- header end -->

    <div class="main-content">
      <div class="enrollments-page">
        <div class="content">
          <!-- Page Header -->
          <div class="enrollments-header">
            <h1 class="enrollments-title">My Learning</h1>
            <p class="enrollments-subtitle">
              Continue your learning journey and track your progress
            </p>
          </div>

          <!-- Filter Tabs -->
          <div class="enrollments-tabs">
            <button class="enroll-tab active">All (3)</button>
            <button class="enroll-tab">In Progress (1)</button>
            <button class="enroll-tab">Completed (2)</button>
          </div>

          <!-- Course List -->
          <div class="enrollments-list">
            <!-- Course 1: In Progress -->
            <c:forEach var="course" items="${list}">
              <div class="enrollment-card">
                <div class="enrollment-thumbnail">
                  <div class="enrollment-thumbnail-placeholder">
                    <img style="width: 100%;height: 100%; object-fit: fill;
                      display:block;border-radius: 6px;"
                      src="/images/courseThumbnail/${course.thumbnailUrl}"
                      alt="">
                    </div>
                </div>
                <div class="enrollment-content">
                  <h3 class="enrollment-course-title">${course.courseTitle}</h3>
                  <p class="enrollment-instructor">
                    by ${course.account.fullname}
                  </p>
                  <p class="enrollment-description">${course.courseDesc}</p>

                  <div class="enrollment-progress-section">
                    <div class="progress-header">
                      <span class="progress-label">Progress</span>
                      <span class="progress-percent">35%</span>
                    </div>
                    <div class="progress-bar">
                      <div class="progress-fill" style="width: 35%"></div>
                    </div>
                  </div>

                  <div class="enrollment-meta">
                    <span class="meta-item">
                      <img
                        src="/images/enrollments/icon_time.svg"
                        alt="Time"
                        width="14"
                        height="14"
                      />
                      Last watched 2023-10-01
                    </span>
                    <span class="meta-dot">•</span>
                    <span class="meta-item">42 lessons</span>
                  </div>

                  <form action="/client/enrollment/continue" method="POST">
                  <input type="hidden" name="courseId" value="${course.id}" />
                  <div class="enrollment-actions">
                    <button class="btn-continue-learning"
                      >Continue Learning</button
                    >
                  </div>
                  <input
                      type="hidden"
                      name="${_csrf.parameterName}"
                      value="${_csrf.token}"
                    />
                  </form>

                  
                </div>
              </div>
            </c:forEach>
          </div>

          <!-- Pagination -->
          <div class="enrollments-pagination">
            <button class="pagination-btn prev" disabled>
              <span>‹</span> Previous
            </button>
            <div class="pagination-numbers">
              <span class="page-num active">1</span>
              <span class="page-num">2</span>
            </div>
            <button class="pagination-btn next">Next <span>›</span></button>
          </div>
        </div>
      </div>
    </div>

    <!-- footer start -->
    <jsp:include page="../layout/footer.jsp" />
    <!-- footer end -->

    <script>
      // Notification Panel Logic
      const openBtn = document.getElementById("openNotiBtn");
      const closeBtn = document.getElementById("closeNotiBtn");
      const overlay = document.getElementById("notiOverlay");
      const panel = document.getElementById("notiPanel");

      function openPanel() {
        panel.classList.add("show");
        overlay.classList.add("show");
        openBtn.setAttribute("aria-expanded", "true");
      }

      function closePanel() {
        panel.classList.remove("show");
        overlay.classList.remove("show");
        openBtn.setAttribute("aria-expanded", "false");
      }

      if (openBtn) {
        openBtn.addEventListener("click", (e) => {
          e.stopPropagation();
          panel.classList.contains("show") ? closePanel() : openPanel();
        });
      }
      if (closeBtn) closeBtn.addEventListener("click", closePanel);
      if (overlay) overlay.addEventListener("click", closePanel);
      document.addEventListener(
        "keydown",
        (e) => e.key === "Escape" && closePanel()
      );

      if (panel) {
        panel.addEventListener("click", (e) => {
          const item = e.target.closest(".noti-item.unread");
          if (!item) return;
          item.classList.remove("unread");
          item.querySelector(".noti-dot")?.remove();
        });
      }
    </script>
  </body>
</html>
<c:if test="${not empty message}">
  <script>
    alert("${message}");
  </script>
</c:if>
