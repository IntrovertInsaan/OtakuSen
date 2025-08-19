import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Fix stretched Trix by forcing re-render height
    this.element.addEventListener("trix-initialize", () => {
      this.fixHeight()
    })
  }

  fixHeight() {
    // Reset editor height after Turbo renders
    const editor = this.element.querySelector("trix-editor")
    if (editor) {
      editor.style.minHeight = "150px" // adjust as you like
      editor.style.height = "auto"
    }
  }
}
