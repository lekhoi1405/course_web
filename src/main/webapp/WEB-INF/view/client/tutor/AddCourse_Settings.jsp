<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Create New Course - Settings - EduLearn</title>
    <link rel="stylesheet" href="/css/style.css" />
  </head>
  <body>
    <jsp:include page="../layout/header.jsp" />
    <main class="create-course-page">
      <div class="content">
        <form:form
          action="/client/tutor/course/add/settings"
          method="post"
          modelAttribute="courseDTO"
        >
          <button
            type="submit"
            onclick="return false;"
            style="display: none"
          ></button>

          <form:input type="hidden" path="courseId" />

          <jsp:include page="../layout/banner.jsp" />

          <div class="create-course-tabs">
            <button
              class="create-tab"
              type="submit"
              name="action"
              value="basicInfor"
            >
              Basic Info
            </button>
            <button
              class="create-tab"
              type="submit"
              name="action"
              value="curriculum"
            >
              Curriculum
            </button>
            <button
              class="create-tab active"
              type="submit"
              name="action"
              value="settings"
            >
              Settings
            </button>
          </div>

          <div class="create-course-form">
            <div class="form-section">
              <h2 class="section-title">Pricing</h2>
              <div class="form-row">
                <div class="form-group">
                  <label class="form-label">Price *</label>
                  <form:input
                    type="text"
                    class="form-input"
                    placeholder="59.99"
                    path="price"
                  />
                </div>
                <div class="form-group">
                  <label class="form-label">Currency *</label>
                  <div class="select-wrapper">
                    <form:select class="form-select" path="currency">
                      <form:option value="vnd">VND (đ)</form:option>
                      <form:option value="usd">USD ($)</form:option>
                      <form:option value="eur">EUR (€)</form:option>
                    </form:select>
                    <img
                      src="/images/addCourse/icon_down.svg"
                      alt="Dropdown"
                      class="select-icon"
                    />
                  </div>
                </div>
              </div>
            </div>

            <div class="form-section">
              <h2 class="section-title">Course Details</h2>
              <div class="form-group">
                <label class="form-label">Level *</label>
                <div class="select-wrapper">
                  <form:select class="form-select" path="level">
                    <option value="" disabled="true">Select level</option>
                    <form:option value="beginner">Beginner</form:option>
                    <form:option value="intermediate">Intermediate</form:option>
                    <form:option value="advanced">Advanced</form:option>
                    <form:option value="all">All Levels</form:option>
                  </form:select>
                  <img
                    src="/images/addCourse/icon_down.svg"
                    alt="Dropdown"
                    class="select-icon"
                  />
                </div>
              </div>
              <div class="form-group">
                <label class="form-label">Category *</label>
                <div class="select-wrapper">
                  <form:select class="form-select" path="category">
                    <option value="" disabled="true">Select category</option>
                    <form:option value="web-development"
                      >Web Development</form:option
                    >
                    <form:option value="mobile-development">
                      Mobile Development
                    </form:option>
                    <form:option value="data-science">Data Science</form:option>
                    <form:option value="machine-learning"
                      >Machine Learning</form:option
                    >
                    <form:option value="ui-ux">UI/UX Design</form:option>
                    <form:option value="business">Business</form:option>
                    <form:option value="marketing">Marketing</form:option>
                  </form:select>
                  <img
                    src="/images/addCourse/icon_down.svg"
                    alt="Dropdown"
                    class="select-icon"
                  />
                </div>
              </div>
              <div class="form-group">
                <label class="form-label">Language *</label>
                <div class="select-wrapper">
                  <form:select class="form-select" path="language">
                    <option value="" disabled="true" selected="true">
                      Select language
                    </option>
                    <form:option value="vietnamese">Vietnamese</form:option>
                    <form:option value="english">English</form:option>
                    <form:option value="japanese">Japanese</form:option>
                    <form:option value="korean">Korean</form:option>
                    <form:option value="chinese">Chinese</form:option>
                  </form:select>
                  <img
                    src="/images/addCourse/icon_down.svg"
                    alt="Dropdown"
                    class="select-icon"
                  />
                </div>
              </div>
            </div>
          </div>
        </form:form>
      </div>
    </main>

    <jsp:include page="../layout/footer.jsp" />
  </body>
</html>
