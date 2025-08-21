import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.classList.add("opacity-0")
    }, 3000)

    setTimeout(() => {
      this.element.remove()
    }, 3400)
  }

  close() {
    this.element.remove()
  }
}
