<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form"%><%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Edit Profile - EduLearn</title>
    <link rel="stylesheet" href="/css/style.css" />
  </head>
  <body>
    <!-- header start -->
    <jsp:include page="../layout/header.jsp" />
    <!-- header end -->

    <form:form
      class="profile-form"
      id="profileForm"
      action="/client/profile/edit"
      method="POST"
      modelAttribute="account"
      enctype="multipart/form-data"
    >
      <form:hidden path="id" />
      <div class="main-content">
        <div class="edit-profile-page">
          <div class="content">
            <div class="container">
              <!-- Page Header with Cancel and Save buttons -->
              <div class="profile-page-header">
                <h1 class="profile-page-title">My Profile</h1>
                <div class="edit-profile-actions">
                  <button
                    href="/client/profile"
                    class="btn-cancel-profile"
                    name="action"
                    value="curriculum"
                  >
                    <img src="/images/myProfile/icon_cancel.svg" alt="Cancel" />
                    Cancel
                  </button>
                  <button type="submit" class="btn-save-profile">
                    <img src="/images/myProfile/icon_save.svg" alt="Save" />
                    Save
                  </button>
                </div>
              </div>

              <!-- Profile Form -->

              <!-- Avatar, Name, Email Card -->
              <div class="profile-card profile-card--main-edit">
                <div class="profile-avatar-edit">
                  <div class="avatar-wrapper-edit">
                    <div class="profile-avatar-letter-edit">N</div>
                    <button type="button" class="btn-change-avatar">
                      <img
                        src="/images/myProfile/button_avatar.svg"
                        alt="Change Avatar"
                      />
                    </button>
                  </div>
                </div>
                <div class="profile-info-edit">
                  <div class="form-group">
                    <label for="fullName" class="form-label">Full Name</label>
                    <form:input
                      type="text"
                      id="fullName"
                      name="fullName"
                      class="form-input form-input--dark"
                      placeholder="Enter your full name"
                      path="fullname"
                    />
                  </div>
                  <div class="form-group">
                    <label for="email" class="form-label">Email Address</label>
                    <form:input
                      type="email"
                      id="email"
                      path="email"
                      class="form-input form-input--dark"
                      placeholder="Enter your email address"
                      disabled="true"
                    />
                  </div>
                </div>
              </div>

              <!-- About Me Card -->
              <div class="profile-card">
                <h3 class="profile-card-title">About Me</h3>
                <div class="form-group">
                  <form:textarea
                    id="aboutMe"
                    path="aboutme"
                    class="form-textarea form-textarea--dark"
                    rows="4"
                    placeholder="Tell us about yourself..."
                  />
                </div>
              </div>

              <!-- Date of Birth Card -->
              <div class="profile-card">
                <h3 class="profile-card-title">Date of Birth</h3>
                <div class="form-group">
                  <form:input
                    type="date"
                    id="dateOfBirth"
                    path="dob"
                    class="form-input form-input--dark form-input--date-edit"
                  />
                  <p class="form-hint">
                    This information is private and not visible to others
                  </p>
                </div>
              </div>

              <!-- Social Links Card -->
              <div class="profile-card">
                <div class="profile-card-header">
                  <h3 class="profile-card-title">Social Links</h3>
                </div>
                <div class="social-links-edit-list" id="socialLinksList">
                  <div class="social-link-edit-item">
                    <form:input
                      type="url"
                      class="form-input form-input--dark social-link-url"
                      path="media_link"
                      placeholder="https://..."
                    />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </form:form>
    <!-- footer start -->
    <jsp:include page="../layout/footer.jsp" />
    <!-- footer end -->
  </body>
</html>
