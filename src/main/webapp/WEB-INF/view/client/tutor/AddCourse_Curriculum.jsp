<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form"%><%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Create New Course - Curriculum - EduLearn</title>
    <link rel="stylesheet" href="/css/style.css" />
  </head>
  <body>
    <!-- header start -->
    <jsp:include page="../layout/header.jsp" />
    <!-- header end -->

    <main class="create-course-page">
      <div class="content">
        <!-- Page Header -->
        <div class="curriculum-content">
          <form:form
            action="/client/tutor/course/add/curriculum"
            method="post"
            modelAttribute="courseDTO"
            enctype="multipart/form-data"
          >
            <jsp:include page="../layout/banner.jsp" />
          <!-- Tab Navigation -->
            <div class="create-course-tabs">
              <button class="create-tab " type="submit" name="action" value="basicInfor" >Basic Info</button>
              <button class="create-tab active" type="submit" name="action" value="curriculum">
                Curriculum
              </button>
              <button class="create-tab" type="submit" name="action" value="settings">
                Settings
            </div>
            <!-- Curriculum Content -->

            <form:hidden path="courseId" />
            <!-- Section Header -->
            <div class="curriculum-header">
              <div class="curriculum-title-section">
                <h2 class="curriculum-title">Course Curriculum</h2>
                <p class="curriculum-subtitle">
                  Organize your course content into sections and lessons
                </p>
              </div>
              <button
                type="button"
                class="btn-add-section-main"
                onclick="addSection()"
              >
                <img
                  src="/images/addCourse/icon_whiteadd.svg"
                  alt="Add"
                  width="16"
                  height="16"
                />
                Add Section
              </button>
            </div>

            <!-- Empty State (shown by default) -->
            <div class="curriculum-empty-state" id="emptyState">
              <img
                src="/images/addCourse/icon_videosection.svg"
                alt="Video"
                class="empty-icon"
              />
              <h3 class="empty-title">No sections yet</h3>
              <p class="empty-subtitle">
                Get started by adding your first section
              </p>
              <button
                class="btn-add-section-empty"
                onclick="addSection()"
                type="button"
              >
                <img
                  src="/images/addCourse/icon_whiteadd.svg"
                  alt="Add"
                  width="16"
                  height="16"
                />
                Add Section
              </button>
            </div>

            <!-- Sections List (hidden by default, shown after clicking Add Section) -->
            <div
              class="curriculum-sections"
              id="sectionsList"
              style="display: none"
            >
              <!-- Sections will be added here dynamically -->

              <!-- Add Section Button at bottom -->
              <button
                class="btn-add-section-bottom"
                onclick="addSection()"
                type="button"
              >
                <img
                  src="/images/addCourse/icon_whiteadd.svg"
                  alt="Add"
                  width="16"
                  height="16"
                />
                Add Section
              </button>
            </div>
          </form:form>
        </div>
      </div>
    </main>

    <!-- footer start -->
    <jsp:include page="../layout/footer.jsp" />
    <!-- footer end -->

    <script>
      // Dùng biến này để đếm số lượng section đang có trên màn hình
      // Lưu ý: Logic này đơn giản hóa cho đồ án.
      // Thực tế nên dùng hàm re-index trước khi submit để tránh lỗi index gaps.
      let sectionIndex = -1;

      function addSection() {
        // 1. Ẩn Empty state
        document.getElementById("emptyState").style.display = "none";
        document.getElementById("sectionsList").style.display = "flex";

        // 2. Tăng index cho section mới
        sectionIndex++;
        const currentSecIdx = sectionIndex; // Lưu lại index cố định cho section này

        // 3. Tạo HTML (Chú ý thuộc tính name)
        const sectionHTML = `
          <div class="curriculum-section-item" id="section-div-\${currentSecIdx}">
            <div class="section-header-row">
              <div class="section-drag">
                <img src="/images/addCourse/icon_move.svg" alt="Move" width="20" height="20"/>
              </div>
              
              <input type="text" 
                     class="section-title-input" 
                     name="sections[\${currentSecIdx}].title" 
                     placeholder="Enter section title" 
                     value="Section \${currentSecIdx+1}: Enter section title"/>
              
              <div class="section-actions">
                <button type="button" class="btn-add-lesson-header" onclick="addLesson(\${currentSecIdx})">
                  <img src="/images/addCourse/icon_blackadd.svg" alt="Add" width="14" height="14" />
                  Add Lesson
                </button>
                <button type="button" class="section-delete-btn" onclick="deleteSection(\${currentSecIdx})">
                  <img src="/images/addCourse/button_delete.svg" alt="Delete" width="28" height="28" />
                </button>
              </div>
            </div>

            <div class="section-lessons" id="section-\${currentSecIdx}-lessons">
                </div>
            
            <input type="hidden" id="lesson-counter-\${currentSecIdx}" value="-1" />
          </div>
        `;

        // Chèn vào trước nút Add Section ở dưới cùng
        const addSectionBtn = document.querySelector(".btn-add-section-bottom");
        addSectionBtn.insertAdjacentHTML("beforebegin", sectionHTML);
      }

      function addLesson(secIdx) {
        // 1. Lấy bộ đếm lesson của section này
        const counterInput = document.getElementById(
          `lesson-counter-\${secIdx}`
        );
        let lessonIdx = parseInt(counterInput.value);
        lessonIdx++;
        counterInput.value = lessonIdx; // Cập nhật lại bộ đếm

        // 2. Tạo HTML Lesson (Chú ý name lồng nhau)
        // name="sections[0].lessons[0].title"
        const lessonHTML = `
          <div class="lesson-card" id="lesson-div-\${secIdx}-\${lessonIdx}">
            <div class="lesson-header">
              <div class="lesson-drag">
                <img src="/images/addCourse/icon_move.svg" alt="Move" width="16" height="16" />
              </div>
              <input type="text" 
                     class="lesson-title-input" 
                     name="sections[\${secIdx}].lessons[\${lessonIdx}].title" 
                     placeholder="Enter lesson title" value="Lesson \${lessonIdx+1}: Enter lesson title"/>
                     
              <button type="button" class="lesson-delete-btn" onclick="deleteLesson(\${secIdx}, \${lessonIdx})">
                <img src="/images/addCourse/button_delete.svg" alt="Delete" width="24" height="24" />
              </button>
            </div>

            <div class="lesson-content-row">
              <div class="lesson-upload-box">
                <div class="upload-box-header">
                  <img src="/images/addCourse/icon_videolesson.svg" width="16" />
                  <span>Video</span>
                </div>
                
                <div class="upload-box-area" onclick="triggerChildInput(this)">
                  <img src="/images/addCourse/icon_upload.svg" width="24" />
                  <span class="file-name">Upload video</span>
                  
                  <input type="file" 
                        name="sections[\${secIdx}].lessons[\${lessonIdx}].videoFile" 
                        accept="video/*" 
                        style="display: none"
                        onchange="updateFileName(this)" 
                        onclick="event.stopPropagation()" /> 
                </div>
              </div>

              <div class="lesson-upload-box">
              <div class="upload-box-header">
                <img src="/images/addCourse/icon_document.svg" width="16" />
                <span>Document</span>
              </div>
              
              <div class="upload-box-area" onclick="triggerChildInput(this)">
                <img src="/images/addCourse/icon_upload.svg" width="24" />
                <span class="file-name">Upload document</span>
                
                <input type="file" 
                      name="sections[\${secIdx}].lessons[\${lessonIdx}].docFile" 
                      accept=".pdf,.doc,.docx" 
                      style="display: none"
                      onchange="updateFileName(this)"
                      onclick="event.stopPropagation()" />
              </div>
            </div>
            <div class="lesson-quiz-section">
              <div class="quiz-header">
                <img src="/images/addCourse/icon_quizz.svg" alt="Quiz" width="16" height="16" />
                <span>Quiz (Optional)</span>
              </div>
              <div class="quiz-row">
                <input type="text" class="quiz-input" placeholder="No quiz" readonly />
                <button class="btn-create-quiz">
                  <img src="/images/addCourse/icon_blackadd.svg" alt="Add" width="14" height="14" />
                  Create Quiz
                </button>
              </div>
            </div>
          </div>
        `;

        document
          .getElementById(`section-\${secIdx}-lessons`)
          .insertAdjacentHTML("beforeend", lessonHTML);
      }

      function deleteSection(secIdx) {
        const el = document.getElementById(`section-div-\${secIdx}`);
        if (el) el.remove();
        // Lưu ý: Khi xóa, index sẽ bị thủng (0, 2, 3).
        // Spring vẫn map được nhưng list sẽ có phần tử null ở giữa.
        // Bạn cần xử lý ở Backend: courseDTO.getSections().removeAll(Collections.singleton(null));
      }

      function deleteLesson(secIdx, lessonIdx) {
        const el = document.getElementById(
          `lesson-div-\${secIdx}-\${lessonIdx}`
        );
        if (el) el.remove();
      }

      function triggerChildInput(parentElement) {
        const input = parentElement.querySelector('input[type="file"]');
        if (input) {
          input.click();
        }
      }

      /**
       * Hàm này kích hoạt khi người dùng đã chọn file xong
       * Nó sẽ thay đổi dòng chữ "Upload video" thành tên file vừa chọn
       */
      function updateFileName(inputElement) {
        if (inputElement.files && inputElement.files.length > 0) {
          const fileName = inputElement.files[0].name;
          // Tìm thẻ span hiển thị tên nằm cùng cấp
          const span = inputElement.parentElement.querySelector(".file-name");
          if (span) {
            span.innerText = fileName;
            span.style.fontWeight = "bold"; // Làm đậm tên file cho dễ nhìn
            span.style.color = "#28a745"; // Đổi màu xanh lá (tùy chọn)
          }
        }
      }
    </script>
  </body>
</html>
