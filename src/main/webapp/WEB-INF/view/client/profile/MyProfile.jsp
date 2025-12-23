<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form"%><%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>My Profile - EduLearn</title>
    <link rel="stylesheet" href="/css/style.css" />
  </head>
  <body>
    <!-- header start -->
    <jsp:include page="../layout/header.jsp" />
    <!-- header end -->

    <div class="main-content">
      <div class="my-profile-page">
        <div class="content">
          <!-- Page Header -->
          <div class="profile-page-header">
            <h1 class="profile-page-title">My Profile</h1>
            <a href="/client/profile/edit" class="btn-edit-profile">
              <img src="/images/myProfile/icon_edit.svg" alt="Edit" />
              <span>Edit Profile</span>
            </a>
          </div>

          <!-- Profile Content -->
          <div class="profile-content">
            <!-- Profile Card - Avatar & Basic Info -->
            <div class="profile-card profile-card--main">
              <div class="profile-avatar-section">
                <div class="profile-avatar">
                  <span class="profile-avatar-letter">N</span>
                </div>
              </div>
              <div class="profile-basic-info">
                <div class="profile-info-group">
                  <label class="profile-label">Full name</label>
                  <p class="profile-value">${account.fullname}</p>
                </div>
                <div class="profile-info-group">
                  <label class="profile-label">Email Address</label>
                  <p class="profile-value">${account.email}</p>
                </div>
              </div>
            </div>

            <!-- About Me Card -->
            <c:if test="${not empty account.aboutme}">
              <div class="profile-card">
                <h3 class="profile-card-title">About Me</h3>
                <p class="profile-card-text">${account.aboutme}</p>
              </div>
            </c:if>
            <!-- Date of Birth Card -->
            <div class="profile-card">
              <h3 class="profile-card-title">Date of Birth</h3>
              <p class="profile-card-text">15 tháng 5, 1995</p>
              <p class="profile-card-note">
                This information is private and not visible to others
              </p>
            </div>

            <!-- Social Links Card -->
            <c:if test="${not empty account.media_link}">
              <div class="profile-card">
                <h3 class="profile-card-title">Social Link</h3>
                <div class="profile-social-links">
                  <div class="profile-social-item">
                    <span class="profile-social-label">Facebook</span>

                    <a
                      href="${account.media_link}"
                      class="profile-social-link"
                      target="_blank"
                      >${account.media_link}</a
                    >
                  </div>
                </div>
              </div>
            </c:if>
          </div>
        </div>
      </div>
    </div>

    <!-- footer start -->
    <jsp:include page="../layout/footer.jsp" />
    <!-- footer end -->
  </body>
</html>
