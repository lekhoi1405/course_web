<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Home Page</title>
    <link rel="stylesheet" href="/css/style.css" />
  </head>
  <body>
    <!-- header start -->
    <jsp:include page="../layout/header.jsp" />
    <!-- header end -->
    <div class="main-content">
      <main class="auth-page">
        <div class="auth-card">
          <h1 class="auth-title">Log In</h1>
          <form action="/login" method="post">
            <c:if test="${param.error != null}">
              <div class="my-2" style="color: red">
                Invalid email or password.
              </div>
            </c:if>
            <c:if test="${param.logout != null}">
              <div class="my-2" style="color: green">Logout successful.</div>
            </c:if>
            <c:if test="${param.expired == 'session_expired'}">
              <div class="my-2" style="color: red">
                Phiên đăng nhập của bạn đã hết hạn. Vui lòng đăng nhập lại!
              </div>
            </c:if>

            <c:if test="${param.expired == 'account_in_use'}">
              <div class="my-2" style="color: red">
                Tài khoản này đã được đăng nhập ở nơi khác!
              </div>
            </c:if>

            <!-- Email -->
            <div class="auth-field">
              <label for="email">Email</label>
              <input
                id="email"
                type="email"
                placeholder="Enter your email"
                name="username"
              />
            </div>

            <!-- Password -->
            <div class="auth-field">
              <label for="password">Password</label>
              <div class="auth-input-with-icon">
                <input
                  id="password"
                  type="password"
                  placeholder="Enter your password"
                  class="password"
                  name="password"
                />
                <button
                  class="auth-eye-btn"
                  type="button"
                  aria-label="Toggle password"
                >
                  👁
                </button>
              </div>
            </div>
            <input
              type="hidden"
              name="${_csrf.parameterName}"
              value="${_csrf.token}"
            />
            <!-- Login button -->
            <button class="auth-submit-btn" type="submit">Log In</button>
          </form>
          <!-- Divider -->
          <div class="auth-divider">
            <span></span>
            <p>or</p>
            <span></span>
          </div>

          <!-- Google button -->
          <button class="auth-google-btn" type="button">
            Continue with Google
          </button>

          <!-- Links -->
          <div class="auth-extra">
            <a href="#" class="auth-link">Forgot password?</a>
          </div>

          <p class="auth-bottom-text">
            Don’t have an account?
            <a href="/register" class="auth-link">Sign up</a>
          </p>
        </div>
      </main>
    </div>
    <!-- footer start -->
    <jsp:include page="../layout/footer.jsp" />
    <!-- footer end -->
  </body>
</html>
