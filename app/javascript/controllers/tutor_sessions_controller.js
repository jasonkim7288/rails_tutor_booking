import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["place","wrappedWithContainer", "entireLayout", "confUrlWrapper", "addressWrapper", "mapWrapper",
                    "category", "headerImg", "imageShown",
                    "address", "map", "latitude", "longitude"
                  ]

  connect() {
    this.handle_change_place()
    this.handle_change_category()
    if (typeof (google) != "undefined") {
      this.initializeMap()
    }
  }

  // when place value is changed, the existence of video conference element and address element should switched, and map should be also on and off
  handle_change_place() {
    if (this.placeTarget.value === 'offline') {
      this.confUrlWrapperTarget.classList.add("d-none")
      this.addressWrapperTarget.classList.remove("d-none")
      this.mapWrapperTarget.classList.remove("d-none")
      this.wrappedWithContainerTarget.classList.remove("container")
      this.entireLayoutTarget.classList.add("col-md-6")
    }
    else {
      this.confUrlWrapperTarget.classList.remove("d-none")
      this.addressWrapperTarget.classList.add("d-none")
      this.mapWrapperTarget.classList.add("d-none")
      this.wrappedWithContainerTarget.classList.add("container")
      this.entireLayoutTarget.classList.remove("col-md-6")
    }
  }

  // when category is changed, a default header image will be changed
  handle_change_category() {
    switch(this.categoryTarget.value) {
      case 'web_app':
        this.headerImgTarget.value = "header_img_web_app.png"
        this.imageShownTarget.src = this.element.getAttribute("data-tutor-sessions-webIcon")
        break
      case 'mobile_app':
        this.headerImgTarget.value = "header_img_mobile_app.png"
        this.imageShownTarget.src = this.element.getAttribute("data-tutor-sessions-mobileIcon")
        break
      case 'prog_lang':
        this.headerImgTarget.value = "header_img_language.png"
        this.imageShownTarget.src = this.element.getAttribute("data-tutor-sessions-languageIcon")
        break
      default:
        break
    }
  }

  // get all the instance of class for Maps
  initializeMap() {
    this.getMap()
    this.getMarker()
    this.getAutocomplete()
  }

  // create or get an instance of Map class
  getMap() {
    if (this.map == undefined) {
      this.map = new google.maps.Map(this.mapTarget, {
        center: new google.maps.LatLng(
          parseFloat(this.latitudeTarget.value),
          parseFloat(this.longitudeTarget.value)
        ),
        zoom: 17
      })
    }
    return this.map
  }

  // create or get an instance of Marker class which shows the actual location with the red teardrop-shaped icon
  getMarker() {
    if (this.marker == undefined) {
      this.marker = new google.maps.Marker({
        map: this.getMap(),
        anchorPoint: new google.maps.Point(0, 0)
      })

      let mapLocation = {
        lat: parseFloat(this.latitudeTarget.value),
        lng: parseFloat(this.longitudeTarget.value)
      }
      this.marker.setPosition(mapLocation)
      this.marker.setVisible(true)
    }
    return this.marker
  }

  // create an instanace of Autocomplete class and link to the input text,
  getAutocomplete() {
    if (this.autocomplete == undefined) {
      this.autocomplete = new google.maps.places.Autocomplete(this.addressTarget)
      this.autocomplete.bindTo('bounds', this.getMap())
      this.autocomplete.setFields(['address_components', 'geometry', 'icon', 'name'])
      this.autocomplete.addListener('place_changed', this.locationChanged.bind(this))
    }
    return this.autocomplete
  }

  // Whenever the input text value changes, this locationChange() method is called
  locationChanged() {
    let place = this.getAutocomplete().getPlace()

    if (!place.geometry) {
      window.alert("No details available for input: '" + place.name + "'")
      return
    }

    this.getMap().fitBounds(place.geometry.viewport)
    this.getMap().setCenter(place.geometry.location)
    this.getMarker().setPosition(place.geometry.location)
    this.getMarker().setVisible(true)

    this.latitudeTarget.value = place.geometry.location.lat()
    this.longitudeTarget.value = place.geometry.location.lng()

    console.log('this.getMap().getCenter():', this.getMap().getCenter().toString())
  }

  // prevent submit when the user hits the enter key after inputting text in the address
  preventSubmit(e) {
    if (e.key == "Enter") {
      e.preventDefault()
    }
  }
}
