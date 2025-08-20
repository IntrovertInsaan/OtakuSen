import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.scrollToBottom()

        // Watch for any changes to messages
        this.observer = new MutationObserver(mutations => {
            // Only scroll if content was added
            if (mutations.some(m => m.addedNodes.length > 0)) {
                this.scrollToBottom()
            }
        })

        // Start observing
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
        // Use setTimeout to ensure DOM is updated
        setTimeout(() => {
            this.element.scrollTop = this.element.scrollHeight
        }, 100)
    }
}