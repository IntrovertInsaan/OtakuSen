import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        const theme = localStorage.getItem("theme") || (window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light")
        this.setTheme(theme)
    }

    switch(e) { e.preventDefault(); this.setTheme(e.currentTarget.dataset.theme) } // from dropdown
    toggle(e) { this.setTheme(e.target.checked ? "dark" : "light") } // from checkbox

    setTheme(theme) {
        document.documentElement.setAttribute("data-theme", theme)
        localStorage.setItem("theme", theme)
        const t = document.querySelector("[data-theme-toggle]") // sync toggle state
        if (t) t.checked = (theme === "dark")
    }
}
