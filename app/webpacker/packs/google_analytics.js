document.addEventListener("turbolinks:load", function (event) {
  if (typeof gtag === "function") {
    gtag("set", "location", event.data.url);
    gtag("send", "pageview");
  }
});
