<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form"%><%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Create New Course - EduLearn</title>
    <link rel="stylesheet" href="/css/style.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  </head>
  <body>
    <!-- header start -->
    <jsp:include page="../layout/header.jsp" />
    <!-- header end -->

    <main class="create-course-page">
      <div class="content">
        <!-- Page Header -->
        <div class="create-course-form">
          <form:form
            method="post"
            action="/client/tutor/course/add/basicInfor"
            modelAttribute="courseDTO"
            enctype="multipart/form-data"
          >
            <jsp:include page="../layout/banner.jsp" />
            <!-- Tab Navigation -->
            <div class="create-course-tabs">
              <button class="create-tab active" type="submit" name="action" value="basicInfor" >Basic Info</button>
              <button class="create-tab " type="submit" name="action" value="curriculum">
                Curriculum
              </button>
              <button class="create-tab " type="submit" name="action" value="settings">
                Settings
            </div>

            <!-- Form Content -->
            <form:hidden path="courseId" />
            <!-- Course Information Section -->
            <div class="form-section">
              <h2 class="section-title">Course Information</h2>

              <!-- Course Title -->

              <div class="form-group">
                <label for="courseTitle" class="form-label"
                  >Course Title *</label
                >
                <form:input
                  type="text"
                  id="courseTitle"
                  class="form-input"
                  placeholder="e.g., Complete React Developer Course 2024"
                  path="courseTitle"
                />
              </div>

              <!-- Description -->
              <div class="form-group">
                <label for="courseDescription" class="form-label"
                  >Description *</label
                >
                <form:textarea
                  id="courseDescription"
                  class="form-textarea"
                  rows="4"
                  placeholder="Write a comprehensive description of your course..."
                  path="courseDesc"
                />
              </div>

              <!-- Thumbnail Upload -->
              <div class="form-group">
                <label class="form-label">Thumbnail *</label>

                <div class="upload-area" id="uploadAreaClickable">
                  
                  <c:choose>
                      <c:when test="${not empty courseDTO.thumbnailUrl}">
                          <img src="/images/courseThumbnail/${courseDTO.thumbnailUrl}" 
                              alt="Upload" class="upload-icon" id="previewImage"
                              style="width: 100%; height: auto; max-height: 300px; object-fit: contain; border-radius: 8px;" />
                          
                          <p class="upload-text" style="display: none;">
                              <span>Click to upload image</span>
                          </p>
                          <p class="upload-info" style="display: none;">
                              PNG, JPG up to 10MB (Recommended: 1280x720px)
                          </p>
                      </c:when>
                      
                      <c:otherwise>
                          <img src="/images/addCourse/icon_upload.svg" 
                              alt="Upload" class="upload-icon" width="48" height="48" id="previewImage" />
                          
                          <p class="upload-text">
                              <span>Click to upload image</span>
                          </p>
                          <p class="upload-info">
                              PNG, JPG up to 10MB (Recommended: 1280x720px)
                          </p>
                      </c:otherwise>
                  </c:choose>

                  <input type="file" class="form-control" id="imageInput"
                        accept=".png,.jpg,.jpeg" style="display: none" name="thumbnail" />
                        
                </div>
              </div>
            </div>

            <!-- What You'll Learn Section -->
            <div class="form-section">
              <h2 class="section-title">What You'll Learn</h2>

              <div class="learning-objectives">
                  <c:if test="${not empty courseDTO.targets}">
                    <c:forEach var="target" items="${courseDTO.targets}" varStatus="status">
                        <div class="form-group ">
                            <input type="text" class="form-input" 
                                  name="targets" value="${target}" 
                                  placeholder="e.g., Build modern React applications from scratch" />
                            
                            <c:if test="${status.index > 0}">
                                <button type="button" class="btn-remove-item" style="background-color:transparent; border:none; margin-top:5px;">
                                    <img src="/images/addCourse/button_delete.svg" alt="Delete" width="28" height="28" />
                                </button>
                            </c:if>
                        </div>
                    </c:forEach>
                </c:if>

                <c:if test="${empty courseDTO.targets}">
                    <div class="form-group">
                        <input type="text" class="form-input" name="targets"
                              placeholder="e.g., Build modern React applications from scratch" />
                    </div>
                </c:if>

                <button class="btn-add-objective" type="button">
                  <img src="/images/addCourse/icon_whiteadd.svg" alt="Add" width="20" height="20" />
                  Add Learning Objective
                </button>
              </div>
            </div>

            <!-- Prerequisites Section -->
            <div class="form-section">
              <h2 class="section-title">Prerequisites</h2>

              <div class="prerequisites">
                <c:if test="${not empty courseDTO.prerequisites}">
                    <c:forEach var="pre" items="${courseDTO.prerequisites}" varStatus="status">
                        <div class="form-group">
                            <input type="text" class="form-input" 
                                  name="prerequisites" value="${pre}" 
                                  placeholder="e.g., Basic knowledge of HTML, CSS, and JavaScript" />
                            
                            <c:if test="${status.index > 0}">
                                <button type="button" class="btn-remove-item" style="background-color:transparent; border:none; margin-top:5px;">
                                    <img src="/images/addCourse/button_delete.svg" alt="Delete" width="28" height="28" />
                                </button>
                            </c:if>
                        </div>
                    </c:forEach>
                </c:if>

                <c:if test="${empty courseDTO.prerequisites}">
                    <div class="form-group">
                        <input type="text" class="form-input" name="prerequisites"
                              placeholder="e.g., Basic knowledge of HTML, CSS, and JavaScript" />
                    </div>
                </c:if>

                <button class="btn-add-prerequisite" type="button">
                  <img src="/images/addCourse/icon_whiteadd.svg" alt="Add" width="20" height="20" />
                  Add Prerequisite
                </button>
              </div>
            </div>
          </form:form>
        </div>
      </div>
    </main>

    <!-- footer start -->
    <jsp:include page="../layout/footer.jsp" />
    <!-- footer end -->
  </body>
  <script>
    $(document).ready(function () {
      $("#uploadAreaClickable").click(function () {
        $("#imageInput").click();
      });

      $("#imageInput").click(function (e) {
        e.stopPropagation();
      });

      $("#imageInput").change(function (e) {
        const file = e.target.files[0];
        if (file) {
          const reader = new FileReader();
          reader.onload = function (e) {
            $("#previewImage").attr("src", e.target.result);
            $("#previewImage").css({
              width: "100%",
              height: "auto",
              "max-height": "300px",
              "object-fit": "contain",
              "border-radius": "8px",
            });
            $(".upload-text, .upload-info").hide();
          };
          reader.readAsDataURL(file);
        }
      });
    });
    function addNewInput(buttonElement) {
      const $container = $(buttonElement).parent();
      const $template = $container.find(".form-group").first();
      const $newField = $template.clone();
      $newField.find("input").val("");
      $newField.addClass("d-flex align-items-center mt-2");
      if ($newField.find(".btn-remove-item").length === 0) {
        $newField.append(
          '<button type="button" class = "btn-remove-item" style ="background-color:transparent; border:none; margin-top:5px;"><img src="/images/addCourse/button_delete.svg" alt="Delete" width="28" height="28" /></button>'
        );
      }
      $(buttonElement).before($newField);
    }

    $(".btn-add-objective").click(function (e) {
      e.preventDefault();
      addNewInput(this);
    });

    $(".btn-add-prerequisite").click(function (e) {
      e.preventDefault();
      addNewInput(this);
    });

    $(document).on("click", ".btn-remove-item", function () {
      $(this).parent().remove();
    });
  </script>
</html>
