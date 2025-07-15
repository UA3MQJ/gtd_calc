// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"

// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

let Hooks = {}

Hooks.KatexRenderer = {
  mounted() {
    console.log("[KatexRenderer] mounted hook вызван")
    this.renderKatex()
  },
  update() {
    console.log("[KatexRenderer] updated hook вызван")
    this.renderKatex()
  },
  renderKatex() {
    console.log("[KatexRenderer] Запуск renderKatex renderKatex()")

    if (typeof renderMathInElement !== "function") {
      console.warn("[KatexRenderer] renderMathInElement НЕ найден. Возможно, auto-render.min.js не загружен.")
      return
    }

    const container = document.getElementById("katex-container")

    if (!container) {
      console.warn("[KatexRenderer] Контейнер #katex-container НЕ найден на странице")
      return
    }

    console.log("[KatexRenderer] Найден контейнер:", container)

    // Очистка старых .katex элементов, чтобы избежать дублирования
    const existing = container.querySelectorAll(".katex")
    console.log(`[KatexRenderer] Удалено ${existing.length} старых .katex элементов`)
    existing.forEach(el => el.remove())

    // Рендер формул
    try {
      renderMathInElement(container, {
        delimiters: [
          {left: "$$", right: "$$", display: true },
          {left: "$", right: "$", display: false },
          {left: '\\(', right: '\\)', display: false},
          {left: '\\[', right: '\\]', display: true}
        ]
      })
      console.log("[KatexRenderer] Формулы успешно перерисованы")
    } catch (e) {
      console.error("[KatexRenderer] Ошибка при рендере формул:", e)
    }
  }
}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: {_csrf_token: csrfToken},
  hooks: Hooks
})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()


// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

