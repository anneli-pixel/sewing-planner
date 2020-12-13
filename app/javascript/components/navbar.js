const makeNavbarItemActiveOnClick = () => {
  const navItems = document.querySelectorAll(".navbar-nav .nav-link");
  const url = window.location.href;

  navItems.forEach((category) => {
    if (url.includes(category)) {
      category.classList.add("active");
    };
  });
}

export { makeNavbarItemActiveOnClick };
