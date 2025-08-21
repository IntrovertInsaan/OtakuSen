import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener("trix-initialize", () => {
      this.fixHeight()
    })
  }

  fixHeight() {
    const editor = this.element.querySelector("trix-editor")
    if (editor) {
      editor.style.minHeight = "150px"
      editor.style.height = "auto"
    }
  }
}
