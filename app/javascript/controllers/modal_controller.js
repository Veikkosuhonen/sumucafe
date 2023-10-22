import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "modal", "modalContainer" ]

    connect() {
        console.log("Hello from menuItemModalController")
    }

    open() {
        this.modalTarget.show()
        this.modalTarget.classList.remove("opacity-0")
        this.modalContainerTarget.classList.remove("-translate-y-full")
    }

    close() {
        setTimeout(() => {
            this.modalTarget.close()
        }, 200)
        this.modalTarget.classList.add("opacity-0")
        this.modalContainerTarget.classList.add("-translate-y-full")
    }
}
