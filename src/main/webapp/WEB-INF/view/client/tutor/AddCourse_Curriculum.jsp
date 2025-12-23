<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@ taglib
uri="http://www.springframework.org/tags/form" prefix="form"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Create New Course - Curriculum</title>
    <link rel="stylesheet" href="/css/style.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <style>
      .force-hide {
        display: none !important;
      }
      .force-show-flex {
        display: flex !important;
      }
      /* Style cho tên file khi đã upload */
      .file-uploaded {
        color: #28a745;
        font-weight: bold;
      }
    </style>
  </head>
  <body>
    <jsp:include page="../layout/header.jsp" />

    <main class="create-course-page">
      <div class="content">
        <div class="curriculum-content">
          <form:form
            action="/client/tutor/course/add/curriculum"
            method="post"
            modelAttribute="courseDTO"
            enctype="multipart/form-data"
          >
            <button
              type="submit"
              onclick="return false;"
              style="display: none"
            ></button>

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
                class="create-tab active"
                type="submit"
                name="action"
                value="curriculum"
              >
                Curriculum
              </button>
              <button
                class="create-tab"
                type="submit"
                name="action"
                value="settings"
              >
                Settings
              </button>
            </div>

            <form:hidden path="courseId" />

            <div class="curriculum-header">
              <div class="curriculum-title-section">
                <h2 class="curriculum-title">Course Curriculum</h2>
                <p class="curriculum-subtitle">Organize your course content</p>
              </div>
              <button
                type="button"
                class="btn-add-section-main"
                onclick="addSection()"
              >
                <img src="/images/addCourse/icon_whiteadd.svg" width="16" /> Add
                Section
              </button>
            </div>

            <c:choose>
              <c:when test="${not empty courseDTO.sectionDTOs}">
                <c:set var="emptyClass" value="force-hide" />
                <c:set var="listClass" value="force-show-flex" />
              </c:when>
              <c:otherwise>
                <c:set var="emptyClass" value="force-show-flex" />
                <c:set var="listClass" value="force-hide" />
              </c:otherwise>
            </c:choose>

            <div class="curriculum-empty-state ${emptyClass}" id="emptyState">
              <img
                src="/images/addCourse/icon_videosection.svg"
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
                <img src="/images/addCourse/icon_whiteadd.svg" width="16" /> Add
                Section
              </button>
            </div>

            <div class="curriculum-sections ${listClass}" id="sectionsList">
              <c:forEach
                items="${courseDTO.sectionDTOs}"
                var="section"
                varStatus="secStatus"
              >
                <div
                  class="curriculum-section-item"
                  id="section-div-${secStatus.index}"
                >
                  <div class="section-header-row">
                    <div class="section-drag">
                      <img src="/images/addCourse/icon_move.svg" width="20" />
                    </div>

                    <input
                      type="text"
                      class="section-title-input"
                      name="sectionDTOs[${secStatus.index}].title"
                      value="${section.title}"
                      placeholder="Enter section title"
                    />

                    <div class="section-actions">
                      <button
                        type="button"
                        class="btn-add-lesson-header"
                        onclick="addLesson(${secStatus.index})"
                      >
                        <img
                          src="/images/addCourse/icon_blackadd.svg"
                          width="14"
                        />
                        Add Lesson
                      </button>
                      <button
                        type="button"
                        class="section-delete-btn"
                        onclick="deleteSection(${secStatus.index})"
                      >
                        <img
                          src="/images/addCourse/button_delete.svg"
                          width="28"
                        />
                      </button>
                    </div>
                  </div>

                  <div
                    class="section-lessons"
                    id="section-${secStatus.index}-lessons"
                  >
                    <c:forEach
                      items="${section.lessons}"
                      var="lesson"
                      varStatus="lessonStatus"
                    >
                      <div
                        class="lesson-card"
                        id="lesson-div-${secStatus.index}-${lessonStatus.index}"
                      >
                        <div class="lesson-header">
                          <div class="lesson-drag">
                            <img
                              src="/images/addCourse/icon_move.svg"
                              width="16"
                            />
                          </div>

                          <input
                            type="text"
                            class="lesson-title-input"
                            name="sectionDTOs[${secStatus.index}].lessons[${lessonStatus.index}].title"
                            value="${lesson.title}"
                            placeholder="Enter lesson title"
                          />

                          <input
                            type="hidden"
                            name="sectionDTOs[${secStatus.index}].lessons[${lessonStatus.index}].videoFileUrl"
                            value="${lesson.videoFileUrl}"
                          />

                          <input
                            type="hidden"
                            name="sectionDTOs[${secStatus.index}].lessons[${lessonStatus.index}].docFileUrl"
                            value="${lesson.docFileUrl}"
                          />
                          <button
                            type="button"
                            class="lesson-delete-btn"
                            onclick="deleteLesson(${secStatus.index}, ${lessonStatus.index})"
                          >
                            Delete
                          </button>
                        </div>

                        <div class="lesson-content-row">
                          <div class="lesson-upload-box">
                            <div class="upload-box-header">
                              <img
                                src="/images/addCourse/icon_videolesson.svg"
                                width="16"
                              />
                              <span>Video</span>
                            </div>
                            <div
                              class="upload-box-area"
                              onclick="triggerChildInput(this)"
                            >
                              <c:choose>
                                <c:when test="${not empty lesson.videoFileUrl}">
                                  <span class="file-name file-uploaded"
                                    >${lesson.videoFileUrl}</span
                                  >
                                </c:when>
                                <c:otherwise>
                                  <span class="file-name">Upload video</span>
                                </c:otherwise>
                              </c:choose>

                              <input
                                type="file"
                                name="sectionDTOs[${secStatus.index}].lessons[${lessonStatus.index}].videoFile"
                                accept="video/*"
                                style="display: none"
                                onchange="updateFileName(this)"
                                onclick="event.stopPropagation()"
                              />
                            </div>
                          </div>

                          <div class="lesson-upload-box">
                            <div class="upload-box-header">
                              <img
                                src="/images/addCourse/icon_document.svg"
                                width="16"
                              />
                              <span>Document</span>
                            </div>
                            <div
                              class="upload-box-area"
                              onclick="triggerChildInput(this)"
                            >
                              <c:choose>
                                <c:when test="${not empty lesson.docFileUrl}">
                                  <span class="file-name file-uploaded"
                                    >${lesson.docFileUrl}</span
                                  >
                                </c:when>
                                <c:otherwise>
                                  <span class="file-name">Upload document</span>
                                </c:otherwise>
                              </c:choose>

                              <input
                                type="file"
                                name="sectionDTOs[${secStatus.index}].lessons[${lessonStatus.index}].docFile"
                                accept=".pdf,.doc,.docx"
                                style="display: none"
                                onchange="updateFileName(this)"
                                onclick="event.stopPropagation()"
                              />
                            </div>
                          </div>

                          <div class="lesson-quiz-section">
                            <div class="quiz-header">
                              <img
                                src="/images/addCourse/icon_quizz.svg"
                                width="16"
                              />
                              <span>Quiz (Optional)</span>
                            </div>
                            <div class="quiz-row">
                              <input
                                type="text"
                                class="quiz-input"
                                placeholder="No quiz"
                                readonly
                              />
                              <button class="btn-create-quiz" type="button">
                                <img
                                  src="/images/addCourse/icon_blackadd.svg"
                                  width="14"
                                />
                                Create Quiz
                              </button>
                            </div>
                          </div>
                        </div>
                      </div>
                    </c:forEach>
                  </div>

                  <c:choose>
                    <c:when test="${not empty section.lessons}">
                      <c:set
                        var="lessonCount"
                        value="${fn:length(section.lessons)}"
                      />
                    </c:when>
                    <c:otherwise>
                      <c:set var="lessonCount" value="0" />
                    </c:otherwise>
                  </c:choose>
                  <input
                    type="hidden"
                    id="lesson-counter-${secStatus.index}"
                    value="${lessonCount - 1}"
                  />
                </div>
              </c:forEach>

              <button
                class="btn-add-section-bottom"
                onclick="addSection()"
                type="button"
              >
                <img src="/images/addCourse/icon_whiteadd.svg" width="16" /> Add
                Section
              </button>
            </div>
          </form:form>
        </div>
      </div>
    </main>

    <jsp:include page="../layout/footer.jsp" />

    <script>
      // =========================================================
      // 1. KHỞI TẠO BIẾN INDEX TỪ SERVER (AN TOÀN TUYỆT ĐỐI)
      // =========================================================
      // Dùng c:choose để tạo ra code JS thuần, tránh lỗi cú pháp
      <c:choose>
          <c:when test="${not empty courseDTO.sectionDTOs}">
              var initialSectionCount = ${fn:length(courseDTO.sectionDTOs)};
          </c:when>
          <c:otherwise>
              var initialSectionCount = 0;
          </c:otherwise>
      </c:choose>

      // Index bắt đầu từ (số lượng - 1)
      var sectionIndex = initialSectionCount - 1;

      // =========================================================
      // 2. HÀM ADD SECTION
      // =========================================================
      function addSection() {
        const emptyState = document.getElementById("emptyState");
        const sectionsList = document.getElementById("sectionsList");

        // Thay đổi class thay vì style
        emptyState.classList.remove("force-show-flex");
        emptyState.classList.add("force-hide");

        sectionsList.classList.remove("force-hide");
        sectionsList.classList.add("force-show-flex");

        sectionIndex++;
        const currentSecIdx = sectionIndex;

        // Dùng backtick ` và \${} để JSP không parse nhầm
        // [QUAN TRỌNG] Name phải là sectionDTOs[...]
        const sectionHTML = `
          <div class="curriculum-section-item" id="section-div-\${currentSecIdx}">
            <div class="section-header-row">
              <div class="section-drag"><img src="/images/addCourse/icon_move.svg" width="20"/></div>

              <input type="text" class="section-title-input"
                     name="sectionDTOs[\${currentSecIdx}].title"
                     placeholder="Enter section title"
                     value="Section \${currentSecIdx+1}: Enter section title"/>

              <div class="section-actions">
                <button type="button" class="btn-add-lesson-header" onclick="addLesson(\${currentSecIdx})">
                   <img src="/images/addCourse/icon_blackadd.svg" width="14" /> Add Lesson
                </button>
                <button type="button" class="section-delete-btn" onclick="deleteSection(\${currentSecIdx})">
                   <img src="/images/addCourse/button_delete.svg" width="28" />
                </button>
              </div>
            </div>

            <div class="section-lessons" id="section-\${currentSecIdx}-lessons"></div>

            <input type="hidden" id="lesson-counter-\${currentSecIdx}" value="-1" />
          </div>
        `;

        const addSectionBtn = document.querySelector(".btn-add-section-bottom");
        addSectionBtn.insertAdjacentHTML("beforebegin", sectionHTML);
      }

      // =========================================================
      // 3. HÀM ADD LESSON
      // =========================================================
      function addLesson(secIdx) {
        const counterInput = document.getElementById(`lesson-counter-\${secIdx}`);
        let lessonIdx = parseInt(counterInput.value);
        lessonIdx++;
        counterInput.value = lessonIdx;

        // [QUAN TRỌNG] Name phải là sectionDTOs[...]
        const lessonHTML = `
          <div class="lesson-card" id="lesson-div-\${secIdx}-\${lessonIdx}">
            <div class="lesson-header">
              <div class="lesson-drag"><img src="/images/addCourse/icon_move.svg" width="16"/></div>
              <input type="text" class="lesson-title-input"
                     name="sectionDTOs[\${secIdx}].lessons[\${lessonIdx}].title"
                     placeholder="Enter lesson title" value="Lesson \${lessonIdx+1}: Enter lesson title"/>
              <button type="button" class="lesson-delete-btn" onclick="deleteLesson(\${secIdx}, \${lessonIdx})">Delete</button>
            </div>

            <div class="lesson-content-row">
              <div class="lesson-upload-box">
                <div class="upload-box-header"><img src="/images/addCourse/icon_videolesson.svg" width="16" /> <span>Video</span></div>
                <div class="upload-box-area" onclick="triggerChildInput(this)">
                  <span class="file-name">Upload video</span>
                  <input type="file" name="sectionDTOs[\${secIdx}].lessons[\${lessonIdx}].videoFile"
                         accept="video/*" style="display:none" onchange="updateFileName(this)" onclick="event.stopPropagation()"/>
                </div>
              </div>
              <div class="lesson-upload-box">
                <div class="upload-box-header"><img src="/images/addCourse/icon_document.svg" width="16" /> <span>Document</span></div>
                <div class="upload-box-area" onclick="triggerChildInput(this)">
                  <span class="file-name">Upload document</span>
                  <input type="file" name="sectionDTOs[\${secIdx}].lessons[\${lessonIdx}].docFile"
                         accept=".pdf,.doc,.docx" style="display:none" onchange="updateFileName(this)" onclick="event.stopPropagation()"/>
                </div>
              </div>
              <div class="lesson-quiz-section">
                <div class="quiz-header">
                  <img src="/images/addCourse/icon_quizz.svg" width="16" /> <span>Quiz (Optional)</span>
                </div>
                <div class="quiz-row">
                  <input type="text" class="quiz-input" placeholder="No quiz" readonly />
                  <button class="btn-create-quiz" type="button">
                    <img src="/images/addCourse/icon_blackadd.svg" width="14" /> Create Quiz
                  </button>
                </div>
              </div>
            </div>
          </div>
        `;
        document.getElementById(`section-\${secIdx}-lessons`).insertAdjacentHTML("beforeend", lessonHTML);
      }

      // =========================================================
      // 4. CÁC HÀM HELPER
      // =========================================================
      function deleteSection(idx) {
          const el = document.getElementById(`section-div-\${idx}`);
          if(el) el.remove();
      }

      function deleteLesson(sIdx, lIdx) {
          const el = document.getElementById(`lesson-div-\${sIdx}-\${lIdx}`);
          if(el) el.remove();
      }

      function triggerChildInput(el) {
          const input = el.querySelector('input[type="file"]');
          if(input) input.click();
      }

      function updateFileName(input) {
         if(input.files && input.files.length > 0) {
             const span = input.parentElement.querySelector(".file-name");
             if(span) {
                 span.innerText = input.files[0].name;
                 span.classList.add("file-uploaded"); // Thêm class màu xanh
                 span.style.color = "#28a745"; // Backup style
                 span.style.fontWeight = "bold";
             }
         }
      }
    </script>
  </body>
</html>
