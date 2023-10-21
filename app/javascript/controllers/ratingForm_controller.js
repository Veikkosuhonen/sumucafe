import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "scoreField" ]

    connect() {
        console.log("Hello from ratingForm controller")
    }

    setScore(event) {
        console.log(event.currentTarget.dataset)
        const score = event.currentTarget.dataset.score
        this.scoreFieldTarget.value = score
        console.log("Rating set to " + score)
    }
}
