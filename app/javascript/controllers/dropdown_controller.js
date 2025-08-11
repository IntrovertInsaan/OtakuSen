import { Controller } from "@hotwired/stimulus"

// This controller toggles a menu when a button is clicked.
// It also handles closing the menu if you click anywhere else on the page.
export default class extends Controller {
  static targets = ["menu"]

  connect() {
    // A helper to detect clicks outside the dropdown
    this.boundHide = this.hide.bind(this)
  }

  toggle() {
    if (this.menuTarget.classList.contains("hidden")) {
      this.show()
    } else {
      this.hide()
    }
  }

  show() {
    this.menuTarget.classList.remove("hidden")
    // Start listening for clicks outside the dropdown
    document.addEventListener("click", this.boundHide)
  }

  hide(event) {
    // If the click is inside the dropdown, do nothing
    if (event && this.element.contains(event.target)) {
      return
    }

    this.menuTarget.classList.add("hidden")
    // Stop listening for clicks outside
    document.removeEventListener("click", this.boundHide)
  }
}
