import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.scrollToBottom()
        this.observer = new MutationObserver(mutations => {
            if (mutations.some(m => m.addedNodes.length > 0)) {
                this.scrollToBottom()
            }
        })
        this.observer.observe(this.element, {
            childList: true,
            subtree: true
        })
    }

    disconnect() {
        if (this.observer) {
            this.observer.disconnect()
        }
    }

    scrollToBottom() {
        setTimeout(() => {
            this.element.scrollTop = this.element.scrollHeight
        }, 100)
    }
}