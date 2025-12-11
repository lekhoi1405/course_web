<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <a href="/" class="nav-link">Home</a>
        <a href="UserExplore.html" class="nav-link">Explore</a>
        <a href="TutorCourses.html" class="nav-link active">Tutor Now</a>
        <a href="Enrollments.html" class="nav-link">Enrollments</a>
      </nav>
      <div class="actions">
        <div class="user-menu">
          <a href="MyCart.html" class="cart-btn">
            <img
              src="/images/userHeader/icon_cart.svg"
              alt="Cart"
              width="20"
              height="20"
            />
          </a>
          <button class="message-btn">
            <img
              src="/images/userHeader/icon_mess.svg"
              alt="Messages"
              width="20"
              height="20"
            />
          </button>
          <form action="/logout" method="post">
            <input
              type="hidden"
              name="${_csrf.parameterName}"
              value="${_csrf.token}"
            />
            <button class="notification-btn">
              <img
                src="/images/userHeader/icon_noti.svg"
                alt="Notifications"
                width="20"
                height="20"
              />
            </button>
          </form>

          <div class="user-profile">
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
          </div>
        </div>
      </div>
    </div>
  </header>
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
        <a href="/" class="nav-link">Home</a>
        <a href="explore.html" class="nav-link">Explore</a>
      </nav>
      <div class="actions">
        <a class="btn" href="/login">Log in</a>
        <a class="btn primary" href="/signUp">Sign up</a>
      </div>
    </div>
  </header>
</c:if>
