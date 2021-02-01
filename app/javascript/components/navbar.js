const makeNavbarItemActiveOnClick = () => {
  const navItems = document.querySelectorAll(".custom-navbar .nav-item");
  const url = window.location.href;

  navItems.forEach((category) => {
    if (url.includes(category.id)) {
      category.classList.add("active");
    };
  });
}

export { makeNavbarItemActiveOnClick };
