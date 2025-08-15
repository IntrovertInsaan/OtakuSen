import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // After 3 seconds, add a CSS class to fade the toast out
    setTimeout(() => {
      this.element.classList.add("opacity-0")
    }, 3000)

    // After the fade out animation (400ms), remove the element completely
    setTimeout(() => {
      this.element.remove()
    }, 3400)
  }

  // Action to close the toast immediately if the user clicks it
  close() {
    this.element.remove()
  }
}
