import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // The form element this controller is attached to.
    this.form = this.element
  }

  // This method will be called on every keystroke in the search box.
  search() {
    // Clear any previous timers to reset the waiting period
    clearTimeout(this.timeout)

    // Set a new timer to submit the form after 300ms of inactivity
    this.timeout = setTimeout(() => {
      this.form.requestSubmit()
    }, 300)
  }
}