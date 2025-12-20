<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form"%><%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
      <div class="home-page">
        <!-- Hero -->
        <div class="content">
          <section class="home-hero">
            <div class="home-hero__right">
              <img src="/images/HomePage/Container.svg" alt="Hero" />
            </div>
            <div class="home-hero__left">
              <h1 class="heading">Your journey to success starts here</h1>
              <p class="desc">Discover knowledge that transforms your future</p>
            </div>
          </section>

          <!-- How it works -->
          <section class="home-how-it-works">
            <h2 class="heading">How It Works</h2>
            <p class="desc">
              Start your learning journey in just three simple steps
            </p>
            <!-- Steps timeline -->
            <div class="steps-strip">
              <!-- 2 chấm nhỏ trên đường kẻ -->
              <span class="steps-tick" style="left: 33.333%"></span>
              <span class="steps-tick" style="left: 66.666%"></span>

              <ul class="steps" aria-label="How it works">
                <!-- Step 1 -->
                <li class="step">
                  <span class="halo"></span>
                  <span class="badge">1</span>
                  <span class="icon" aria-hidden="true">
                    <!-- search -->
                    <svg
                      viewBox="0 0 24 24"
                      width="22"
                      height="22"
                      fill="none"
                      stroke="currentColor"
                      stroke-width="2"
                    >
                      <circle cx="11" cy="11" r="7"></circle>
                      <line x1="16.65" y1="16.65" x2="21" y2="21"></line>
                    </svg>
                  </span>
                </li>

                <!-- Step 2 -->
                <li class="step">
                  <span class="halo"></span>
                  <span class="badge">2</span>
                  <span class="icon" aria-hidden="true">
                    <!-- book -->
                    <svg
                      viewBox="0 0 24 24"
                      width="22"
                      height="22"
                      fill="none"
                      stroke="currentColor"
                      stroke-width="2"
                    >
                      <path d="M4 19a2 2 0 0 0 2 2h14"></path>
                      <path
                        d="M20 22V6a2 2 0 0 0-2-2H6a2 2 0 0 0-2 2v13"
                      ></path>
                      <path d="M8 6h9"></path>
                    </svg>
                  </span>
                </li>

                <!-- Step 3 -->
                <li class="step">
                  <span class="halo"></span>
                  <span class="badge">3</span>
                  <span class="icon" aria-hidden="true">
                    <!-- user -->
                    <svg
                      viewBox="0 0 24 24"
                      width="22"
                      height="22"
                      fill="none"
                      stroke="currentColor"
                      stroke-width="2"
                    >
                      <path d="M20 21a8 8 0 0 0-16 0"></path>
                      <circle cx="12" cy="7" r="4"></circle>
                    </svg>
                  </span>
                </li>
              </ul>
            </div>

            <div class="home-how-it-works__steps">
              <div class="step-card">
                <h3>Discover &amp; Create</h3>
                <p>
                  Browse thousands of courses across different subjects and
                  skill levels, or upload your own course with lessons, quizzes,
                  and resources.
                </p>
              </div>
              <div class="step-card">
                <h3>Enroll &amp; manage</h3>
                <p>
                  Enroll in your chosen courses to get instant access, or manage
                  your own course content and track learners’ progress.
                </p>
              </div>
              <div class="step-card">
                <h3>Learn &amp; Share</h3>
                <p>
                  Learn at your own pace with interactive lessons and exercises,
                  or share your expertise and grow your teaching community.
                </p>
              </div>
            </div>
          </section>

          <!-- Why choose -->
          <section class="why">
            <div class="why__header">
              <h2 class="why__title heading">Why Choose EduLearn?</h2>
              <p class="why__subtitle desc">
                Join millions of learners who trust us for their professional
                development
              </p>
            </div>

            <div class="why__box why__box--features">
              <div class="why__grid">
                <div class="why-card">
                  <img
                    src="/images/HomePage/Why-icon1.svg"
                    alt=""
                    class="why-card__icon"
                  />
                  <h3 class="why-card__title">Quality Content</h3>
                  <p class="why-card__desc">
                    All courses are created by verified experts and reviewed by
                    our quality team.
                  </p>
                </div>

                <div class="why-card">
                  <img
                    src="/images/HomePage/Why-icon2.svg"
                    style="--item-color: #f0fdf4"
                    alt=""
                    class="why-card__icon"
                  />
                  <h3 class="why-card__title">Flexible Payments</h3>
                  <p class="why-card__desc">
                    Pay with credit card, e-wallet, or cash on delivery for your
                    convenience.
                  </p>
                </div>

                <div class="why-card">
                  <img
                    src="/images/HomePage/Why-icon3.svg"
                    alt=""
                    class="why-card__icon"
                    style="--item-color: #fff7ed"
                  />
                  <h3 class="why-card__title">Lifetime Access</h3>
                  <p class="why-card__desc">
                    Learn at your own pace with unlimited access to course
                    materials forever.
                  </p>
                </div>

                <div class="why-card">
                  <img
                    src="/images/HomePage/Why-icon4.svg"
                    alt=""
                    class="why-card__icon"
                    style="--item-color: #f0fdfa"
                  />
                  <h3 class="why-card__title">24/7 Support</h3>
                  <p class="why-card__desc">
                    Get help whenever you need it with our round-the-clock
                    customer support.
                  </p>
                </div>

                <div class="why-card">
                  <img
                    src="/images/HomePage/Why-icon5.svg"
                    alt=""
                    class="why-card__icon"
                    style="--item-color: #fef2f2"
                  />
                  <h3 class="why-card__title">Global Community</h3>
                  <p class="why-card__desc">
                    Join millions of learners worldwide and connect with peers
                    in your field.
                  </p>
                </div>

                <div class="why-card">
                  <img
                    src="/images/HomePage/Why-icon6.svg"
                    alt=""
                    class="why-card__icon"
                  />
                  <h3 class="why-card__title">Expert Instructors</h3>
                  <p class="why-card__desc">
                    Learn from industry professionals with real-world experience
                    and expertise.
                  </p>
                </div>
              </div>
            </div>

            <div class="why__box why__box--stats">
              <div class="why__stats">
                <div class="why-stat">
                  <div class="why-stat__value">50M+</div>
                  <div class="why-stat__label">Happy Students</div>
                </div>
                <div class="why-stat">
                  <div class="why-stat__value">190K+</div>
                  <div class="why-stat__label">Quality Courses</div>
                </div>
                <div class="why-stat">
                  <div class="why-stat__value">70K+</div>
                  <div class="why-stat__label">Expert Instructors</div>
                </div>
                <div class="why-stat">
                  <div class="why-stat__value">180+</div>
                  <div class="why-stat__label">Countries Reached</div>
                </div>
              </div>
            </div>
          </section>

          <!-- Featured courses -->
          <section class="home-featured">
            <div class="section-header">
              <h2>Popular courses</h2>
            </div>

            <div class="home-featured__grid">
              <article class="course-card">
                <div class="course-card__image-wrapper">
                  <!-- Dùng ảnh thật nếu có -->
                  <div class="course-card__image-placeholder"></div>

                  <div class="course-card__badges">
                    <span class="badge badge--orange">Bestseller</span>
                    <span class="badge badge--dark">Intermediate</span>
                    <span class="badge badge--red">-70%</span>
                  </div>
                </div>

                <div class="course-card__body">
                  <div class="course-card__category">DEVELOPMENT</div>
                  <h3 class="course-card__title">
                    Complete React Developer Course 2024
                  </h3>
                  <p class="course-card__instructor">by John Smith</p>

                  <div class="course-card__meta">
                    <span>42h 30m</span>
                    <span>•</span>
                    <span>89,234 students</span>
                  </div>

                  <div class="course-card__rating">
                    ⭐ 4.8 <span>(1,234)</span>
                  </div>

                  <div class="course-card__footer">
                    <div class="course-card__price-box">
                      <span class="course-card__price">$59.99</span>
                      <span class="course-card__old-price">$199.00</span>
                    </div>
                    <button class="course-card__view-btn">View Course</button>
                  </div>
                </div>
              </article>

              <article class="course-card">
                <div class="course-card__image-wrapper">
                  <div class="course-card__image-placeholder"></div>
                  <div class="course-card__badges">
                    <span class="badge badge--orange">Bestseller</span>
                    <span class="badge badge--dark">Beginner</span>
                    <span class="badge badge--red">-60%</span>
                  </div>
                </div>
                <div class="course-card__body">
                  <div class="course-card__category">DESIGN</div>
                  <h3 class="course-card__title">
                    UI/UX Design Masterclass 2024
                  </h3>
                  <p class="course-card__instructor">by Sarah Johnson</p>
                  <div class="course-card__meta">
                    <span>31h 15m</span>
                    <span>•</span>
                    <span>45,678 students</span>
                  </div>
                  <div class="course-card__rating">
                    ⭐ 4.9 <span>(894)</span>
                  </div>
                  <div class="course-card__footer">
                    <div class="course-card__price-box">
                      <span class="course-card__price">$79.99</span>
                      <span class="course-card__old-price">$199.00</span>
                    </div>
                    <button class="course-card__view-btn">View Course</button>
                  </div>
                </div>
              </article>
              <article class="course-card">
                <div class="course-card__image-wrapper">
                  <div class="course-card__image-placeholder"></div>
                  <div class="course-card__badges">
                    <span class="badge badge--orange">Bestseller</span>
                    <span class="badge badge--dark">Beginner</span>
                    <span class="badge badge--red">-60%</span>
                  </div>
                </div>
                <div class="course-card__body">
                  <div class="course-card__category">DESIGN</div>
                  <h3 class="course-card__title">
                    UI/UX Design Masterclass 2024
                  </h3>
                  <p class="course-card__instructor">by Sarah Johnson</p>
                  <div class="course-card__meta">
                    <span>31h 15m</span>
                    <span>•</span>
                    <span>45,678 students</span>
                  </div>
                  <div class="course-card__rating">
                    ⭐ 4.9 <span>(894)</span>
                  </div>
                  <div class="course-card__footer">
                    <div class="course-card__price-box">
                      <span class="course-card__price">$79.99</span>
                      <span class="course-card__old-price">$199.00</span>
                    </div>
                    <button class="course-card__view-btn">View Course</button>
                  </div>
                </div>
              </article>
              <article class="course-card">
                <div class="course-card__image-wrapper">
                  <div class="course-card__image-placeholder"></div>
                  <div class="course-card__badges">
                    <span class="badge badge--orange">Bestseller</span>
                    <span class="badge badge--dark">Beginner</span>
                    <span class="badge badge--red">-60%</span>
                  </div>
                </div>
                <div class="course-card__body">
                  <div class="course-card__category">DESIGN</div>
                  <h3 class="course-card__title">
                    UI/UX Design Masterclass 2024
                  </h3>
                  <p class="course-card__instructor">by Sarah Johnson</p>
                  <div class="course-card__meta">
                    <span>31h 15m</span>
                    <span>•</span>
                    <span>45,678 students</span>
                  </div>
                  <div class="course-card__rating">
                    ⭐ 4.9 <span>(894)</span>
                  </div>
                  <div class="course-card__footer">
                    <div class="price-box">
                      <span class="current-price">$79.99</span>
                      <span class="old-price">$199.00</span>
                    </div>
                    <button class="view-course-btn">View Course</button>
                  </div>
                </div>
              </article>
            </div>

            <button class="link-button">View all Courses</button>
          </section>
        </div>
      </div>
    </div>

    <!-- footer start -->
    <jsp:include page="../layout/footer.jsp" />
    <!-- footer end -->
    <script>
      const currentPage = window.location.pathname.split("/").pop();
      document.querySelectorAll(".nav-link").forEach((link) => {
        if (link.getAttribute("href") === currentPage) {
          link.classList.add("active");
        }
      });
    </script>
  </body>
</html>
