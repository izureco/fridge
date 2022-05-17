// TODO : Swiperで縦方向のアニメーション ->https://web-dev.tech/front-end/javascript/swiper-full-screen-vertical-slider/#exp-swiper

// FIXME : 横方向に遷移しちゃってる。縦にしたい
/* アドレスバー・ツールバーを除いた100vhの高さを取得 */
function setHeight() {
  let vh = window.innerHeight * 0.01;
  document.documentElement.style.setProperty("--vh", `${vh}px`);
}
setHeight();
window.addEventListener("resize", setHeight);

/* スライダーの設定 */
const verticalSlider = new Swiper(".vertical-slider", {
  direction: "vertical",
  slidesPerView: 1,
  speed: 600,
  mousewheel: true,
  pagination: {
    el: ".vertical-slider__pagination",
    type: "bullets",
    clickable: true,
  },
});