<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form"%><%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Lesson (Video)</title>
    <link rel="stylesheet" href="/css/style.css" />
  </head>
  <body>
    <main class="lesson-page container">
      <div class="lesson-card">
        <div class="lesson-head">
          <a href="/client/enrollment" class="btn-ghost no-textDecoration">
            <span><img src="/images/Vector-smaller.svg" alt="" /></span>
            <span>${course.courseTitle}</span></a
          >
        </div>

        <div class="lesson-layout">
          <!-- Main -->
          <section class="lesson-main">
            <div class="lesson-player"></div>
            <!-- <div class="lesson-text"></div> -->

            <div class="lesson-title no-textAlign">
              Lời khuyên trước khóa học
            </div>

            <div class="lesson-actions">
              <button class="btn-outline">
                <span>BÀI TRƯỚC</span>
              </button>
              <button class="btn-primary">BÀI TIẾP THEO</button>
            </div>
          </section>

          <!-- Curriculum -->
          <aside class="curriculum">
            <div class="curri-head">
              <div class="curri-title">Nội dung khóa học</div>
            </div>
            <c:forEach var="section" items="${course.sections}">
              <div class="curri-sec open">
                <div class="curri-sec__head">${section.sectionTitle}</div>
                <ul class="curri-sec__list">
                  <c:forEach var="lesson" items="${section.lessons}">
                    <c:set var="videoLink" value="" />
                    <c:if test="${not empty lesson.resources}">
                      <c:set
                        var="videoLink"
                        value="${lesson.resources[0].video}"
                      />
                    </c:if>

                    <li
                      class="curri-item"
                      data-type="video"
                      data-src="/videos/video/${videoLink}"
                    >
                      <span class="dot"></span>
                      <span class="name">
                        ${not empty lesson.lessonTitle ? lesson.lessonTitle :
                        'Bài học không tên'}
                      </span>
                      <span class="duration" data-timeVideo="08:30"></span>
                    </li>
                  </c:forEach>
                </ul>
              </div>
            </c:forEach>
          </aside>
        </div>
      </div>
    </main>

    <script>
      // Toggle section
      document.querySelectorAll(".curri-sec__head").forEach((h) => {
        h.addEventListener("click", () =>
          h.parentElement.classList.toggle("open")
        );
      });

      const items = [...document.querySelectorAll(".curri-item")];
      const player = document.querySelector(".lesson-player");
      const titleEl = document.querySelector(".lesson-title");
      const prevBtn = document.querySelector(".btn-outline");
      const nextBtn = document.querySelector(".btn-primary");

      function updateUI(item) {
        // bỏ current cũ
        items.forEach((i) => i.classList.remove("current"));
        item.classList.add("current");

        // đổi tiêu đề
        titleEl.textContent = item.querySelector(".name").textContent.trim();

        // xoá nội dung khung player
        player.innerHTML = "";

        const type = item.dataset.type;

        if (type === "video") {
          // ---- TẠO VIDEO MỚI ----
          const video = document.createElement("video");
          video.controls = true;
          video.autoplay = true;
          video.muted = true;
          video.playsInline = true;
          video.width = "100%";

          video.src = item.dataset.src;
          if (item.dataset.poster) video.poster = item.dataset.poster;

          player.appendChild(video);
        } else if (type === "text") {
          // ---- HIỂN THỊ TEXT ----
          const div = document.createElement("div");
          div.classList.add("lesson-text");
          div.innerHTML = item.dataset.content || "Không có nội dung.";
          player.appendChild(div);
        }

        // trạng thái nút
        const idx = items.indexOf(item);
        prevBtn.disabled = idx === 0;
        nextBtn.disabled = idx === items.length - 1;

        // scroll vào bài
        item.scrollIntoView({ block: "nearest", behavior: "smooth" });
      }

      // click item
      items.forEach((i) => i.addEventListener("click", () => updateUI(i)));

      // prev
      prevBtn.addEventListener("click", () => {
        const cur = document.querySelector(".curri-item.current");
        const idx = items.indexOf(cur);
        if (idx > 0) updateUI(items[idx - 1]);
      });

      // next
      nextBtn.addEventListener("click", () => {
        const cur = document.querySelector(".curri-item.current");
        const idx = items.indexOf(cur);
        if (idx < items.length - 1) updateUI(items[idx + 1]);
      });

      // khởi tạo
      updateUI(document.querySelector(".curri-item.current") || items[0]);
    </script>
  </body>
</html>
