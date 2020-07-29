import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "place", "confurl", "address" ]

  connect() {

  }

  handle_change_place() {
    console.log('this.placeTarget.value:', this.placeTarget.value)
    console.log('this.confurlTarget.classList:', this.confurlTarget.classList)
    if(this.placeTarget.value === 'offline') {
      this.confurlTarget.classList.add("d-none")
      this.addressTarget.classList.remove("d-none")
    }
    else {
      this.confurlTarget.classList.remove("d-none")
      this.addressTarget.classList.add("d-none")
    }
  }
}
