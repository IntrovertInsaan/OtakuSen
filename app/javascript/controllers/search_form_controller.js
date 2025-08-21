import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.form = this.element
  }

  search() {
    clearTimeout(this.timeout)

    this.timeout = setTimeout(() => {
      this.form.requestSubmit()
    }, 300)
  }
}