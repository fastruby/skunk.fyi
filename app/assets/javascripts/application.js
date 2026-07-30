// The whole client-side behaviour of this app: collapse the mobile navbar.
//
// Bootstrap 3's collapse CSS (`.collapse { display: none }` / `.collapse.in`)
// already compiles in through the styleguide, so the only missing piece is the
// class toggle that its jQuery plugin used to do.
document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll('[data-toggle="collapse"]').forEach(function (toggler) {
    toggler.addEventListener("click", function () {
      var selector = toggler.getAttribute("data-target") || toggler.getAttribute("href");
      var target = selector && document.querySelector(selector);
      if (!target) return;

      var expanded = target.classList.toggle("in");
      toggler.setAttribute("aria-expanded", expanded ? "true" : "false");
    });
  });
});
