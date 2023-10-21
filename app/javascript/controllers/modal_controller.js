import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "modal" ]

    connect() {
        console.log("Hello from menuItemModalController")
    }

    open() {
        this.modalTarget.show()
    }

    close() {
        this.modalTarget.close()
    }
}
