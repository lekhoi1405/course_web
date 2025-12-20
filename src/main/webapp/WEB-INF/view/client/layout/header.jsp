<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@page
contentType="text/html" pageEncoding="UTF-8"%>

<c:if test="${not empty pageContext.request.userPrincipal}">
  <header class="header">
    <div class="container header-inner">
      <div class="brand">
        <div class="logo">
          <img src="/images/logo.svg" alt="EduLearn" />
        </div>
        <div class="name-brand">EduLearn</div>
      </div>

      <nav class="nav">
        <a href="/" class="nav-link ${activePage == 'home' ? 'active' : ''}"
          >Home</a
        >
        <a
          href="/explore"
          class="nav-link ${activePage == 'explore' ? 'active' : ''}"
          >Explore</a
        >
        <a
          href="/client/tutor/course"
          class="nav-link ${activePage == 'tutor' ? 'active' : ''}"
          >Tutor Now</a
        >
        <a
          href="/enrollments"
          class="nav-link ${activePage == 'enrollments' ? 'active' : ''}"
          >Enrollments</a
        >
      </nav>

      <div class="actions">
        <div class="user-menu">
          <a
            href="/cart"
            class="cart-btn"
            style="--color-badge: #1c398e"
            data-count="2"
          >
            <img
              src="/images/userHeader/icon_cart.svg"
              alt="Cart"
              width="20"
              height="20"
            />
          </a>
          <button class="message-btn" data-count="3">
            <img
              src="/images/userHeader/icon_mess.svg"
              alt="Messages"
              width="20"
              height="20"
            />
          </button>

          <button
            class="notification-btn icon-badge"
            id="openNotiBtn"
            aria-haspopup="dialog"
            aria-expanded="false"
            data-count="3"
          >
            <img
              src="/images/userHeader/icon_noti.svg"
              alt="Notifications"
              width="20"
              height="20"
            />
          </button>

          <div class="user-profile-wrapper">
            <button
              class="user-profile"
              id="userMenuBtn"
              aria-expanded="false"
              aria-haspopup="true"
            >
              <img
                src="/images/userHeader/user_avt.svg"
                alt="User Avatar"
                class="user-avatar-img"
              />
              <img
                src="/images/userHeader/icon_down.svg"
                alt="Dropdown"
                class="user-dropdown-icon"
              />
            </button>

            <div class="user-menu-dropdown" id="userMenuDropdown">
              <ul class="user-menu-list">
                <li class="user-menu-item">
                  <a href="/profile" class="user-menu-link">
                    <img
                      src="/images/userMenu/icon_profile.svg"
                      alt="Profile"
                      class="user-menu-icon"
                    />
                    <div class="user-menu-text">
                      <span class="user-menu-label">My Profile</span>
                      <span class="user-menu-desc">View and edit profile</span>
                    </div>
                  </a>
                </li>

                <li class="user-menu-item">
                  <form
                    action="/logout"
                    method="post"
                    style="margin: 0; width: 100%"
                  >
                    <input
                      type="hidden"
                      name="${_csrf.parameterName}"
                      value="${_csrf.token}"
                    />

                    <button
                      type="submit"
                      class="user-menu-link btn-logout-reset"
                      style="
                        width: 100%;
                        text-align: left;
                        background: none;
                        border: none;
                        cursor: pointer;
                      "
                    >
                      <img
                        src="/images/userMenu/icon_logOut.svg"
                        alt="Logout"
                        class="user-menu-icon"
                      />
                      <div class="user-menu-text">
                        <span class="user-menu-label" style="color: #dc3545"
                          >Logout</span
                        >
                        <span class="user-menu-desc"
                          >Sign out of your account</span
                        >
                      </div>
                    </button>
                  </form>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  </header>
  <div class="noti-overlay" id="notiOverlay"></div>
  <div
    class="noti-panel"
    id="notiPanel"
    role="dialog"
    aria-labelledby="notiTitle"
  >
    <div class="noti-header">
      <h3 id="notiTitle">Thông báo</h3>
      <button class="noti-close" id="closeNotiBtn" aria-label="Đóng">
        <img src="images/userDashboard/VectorX.svg" alt="" />
      </button>
    </div>
    <ul class="noti-list">
      <li class="noti-item unread">
        <div class="noti-icon noti-icon--course">
          <img
            src="images/viewNotification/icon_newCourse.svg"
            alt="New Course"
          />
        </div>
        <div class="noti-body">
          <p class="noti-title">Khóa học mới đã được thêm</p>
          <p class="noti-desc">
            Advanced React Patterns đã được thêm vào danh sách của bạn
          </p>
          <div class="noti-meta">5 phút trước</div>
        </div>
        <span class="noti-dot"></span>
      </li>
      <li class="noti-item unread">
        <div class="noti-icon noti-icon--review">
          <img
            src="images/viewNotification/icon_reviewNoti.svg"
            alt="New Review"
          />
        </div>
        <div class="noti-body">
          <p class="noti-title">Đánh giá mới</p>
          <p class="noti-desc">
            Sarah Johnson đã đánh giá 5 sao cho khóa học React Fundamentals
          </p>
          <div class="noti-meta">1 giờ trước</div>
        </div>
        <span class="noti-dot"></span>
      </li>
    </ul>
    <a href="ViewNotification.html" class="noti-viewall"
      >Xem tất cả thông báo</a
    >
  </div>
</c:if>

<c:if test="${empty pageContext.request.userPrincipal}">
  <header class="header">
    <div class="container header-inner">
      <div class="brand">
        <div class="logo">
          <img src="/images/logo.svg" alt="EduLearn" />
        </div>
        <div class="name-brand">EduLearn</div>
      </div>
      <nav class="nav">
        <a href="/" class="nav-link ${activePage == 'home' ? 'active' : ''}"
          >Home</a
        >
        <a
          href="/explore"
          class="nav-link ${activePage == 'explore' ? 'active' : ''}"
          >Explore</a
        >
      </nav>
      <div class="actions">
        <a class="btn" href="/login">Log in</a>
        <a class="btn primary" href="/register">Sign up</a>
      </div>
    </div>
  </header>
</c:if>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    // --- 1. NOTIFICATION LOGIC ---
    const openBtn = document.getElementById("openNotiBtn");
    const closeBtn = document.getElementById("closeNotiBtn");
    const overlay = document.getElementById("notiOverlay");
    const panel = document.getElementById("notiPanel");

    function openPanel() {
      if (panel) panel.classList.add("show");
      if (overlay) overlay.classList.add("show");
      if (openBtn) openBtn.setAttribute("aria-expanded", "true");
    }

    function closePanel() {
      if (panel) panel.classList.remove("show");
      if (overlay) overlay.classList.remove("show");
      if (openBtn) openBtn.setAttribute("aria-expanded", "false");
    }

    // Kiểm tra tồn tại trước khi addEventListener
    if (openBtn && panel) {
      openBtn.addEventListener("click", (e) => {
        e.stopPropagation();
        panel.classList.contains("show") ? closePanel() : openPanel();
      });
    }

    if (closeBtn) closeBtn.addEventListener("click", closePanel);
    if (overlay) overlay.addEventListener("click", closePanel);

    document.addEventListener("keydown", (e) => {
      if (e.key === "Escape") closePanel();
    });

    if (panel) {
      panel.addEventListener("click", (e) => {
        const item = e.target.closest(".noti-item.unread");
        if (!item) return;
        item.classList.remove("unread");
        item.querySelector(".noti-dot")?.remove();
      });
    }

    // --- 2. USER MENU DROPDOWN LOGIC ---
    const userMenuBtn = document.getElementById("userMenuBtn");
    const userMenuDropdown = document.getElementById("userMenuDropdown");

    if (userMenuBtn && userMenuDropdown) {
      userMenuBtn.addEventListener("click", (e) => {
        e.stopPropagation();
        const isOpen = userMenuDropdown.classList.contains("show");
        userMenuDropdown.classList.toggle("show");
        userMenuBtn.setAttribute("aria-expanded", !isOpen);
      });

      document.addEventListener("click", (e) => {
        if (
          !userMenuDropdown.contains(e.target) &&
          !userMenuBtn.contains(e.target)
        ) {
          userMenuDropdown.classList.remove("show");
          userMenuBtn.setAttribute("aria-expanded", "false");
        }
      });

      document.addEventListener("keydown", (e) => {
        if (e.key === "Escape" && userMenuDropdown.classList.contains("show")) {
          userMenuDropdown.classList.remove("show");
          userMenuBtn.setAttribute("aria-expanded", "false");
        }
      });
    }
  });
</script>
