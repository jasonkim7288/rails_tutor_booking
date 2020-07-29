import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["place","wrappedWithContainer", "confUrlWrapper", "addressWrapper", "mapWrapper", "address", "map", "latitude", "longitude"]

  connect() {
    this.handle_change_place()
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
    }
    else {
      this.confUrlWrapperTarget.classList.remove("d-none")
      this.addressWrapperTarget.classList.add("d-none")
      this.mapWrapperTarget.classList.add("d-none")
      this.wrappedWithContainerTarget.classList.add("container")
    }
  }

  initializeMap() {
    this.map()
    this.marker()
    this.autocomplete()
  }

  map() {
    if (this._map == undefined) {
      this._map = new google.maps.Map(this.mapTarget, {
        center: new google.maps.LatLng(
          parseFloat(this.latitudeTarget.value),
          parseFloat(this.longitudeTarget.value)
        ),
        zoom: 17
      })
    }
    return this._map
  }

  marker() {
    if (this._marker == undefined) {
      this._marker = new google.maps.Marker({
        map: this.map(),
        anchorPoint: new google.maps.Point(0, 0)
      })

      let mapLocation = {
        lat: parseFloat(this.latitudeTarget.value),
        lng: parseFloat(this.longitudeTarget.value)
      }
      this._marker.setPosition(mapLocation)
      this._marker.setVisible(true)
    }
    return this._marker
  }

  autocomplete() {
    if (this._autocomplete == undefined) {
      this._autocomplete = new google.maps.places.Autocomplete(this.addressTarget)
      this._autocomplete.bindTo('bounds', this.map())
      this._autocomplete.setFields(['address_components', 'geometry', 'icon', 'name'])
      this._autocomplete.addListener('place_changed', this.locationChanged.bind(this))
    }
    return this._autocomplete
  }

  locationChanged() {
    console.log("here!!!!!")
    let place = this.autocomplete().getPlace()

    if (!place.geometry) {
      window.alert("No details available for input: '" + place.name + "'")
      return
    }

    this.map().fitBounds(place.geometry.viewport)
    this.map().setCenter(place.geometry.location)
    this.marker().setPosition(place.geometry.location)
    this.marker().setVisible(true)

    this.latitudeTarget.value = place.geometry.location.lat()
    this.longitudeTarget.value = place.geometry.location.lng()

    console.log('this.map().getCenter():', this.map().getCenter().toString())
  }

  preventSubmit(e) {
    if (e.key == "Enter") {
      e.preventDefault()
    }
  }
}
