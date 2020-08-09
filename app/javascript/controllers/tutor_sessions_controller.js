import { Controller } from "stimulus"
import axios from 'axios';

export default class extends Controller {
  static targets = ["place","wrappedWithContainer", "entireLayout", "confUrlWrapper", "addressWrapper", "mapWrapper",
                    "category", "headerImg", "imageShown",
                    "address", "map", "latitude", "longitude",
                    "searchString", "imgList1", "imgList2", "imgList3", "imgList4", "imgList5"
                  ]

  connect() {
    this.handle_change_place()
    this.handle_change_category()
    if (typeof (google) != "undefined") {
      this.initializeMap()
    }
  }

  handle_search(e) {
    if (e.key == "Enter") {
      e.preventDefault()
    }

    const name = this.searchStringTarget.value.replace(" ", "%20");
    if (name === "")
      return
    const url = `https://api.unsplash.com/search/photos?page=1&query=${name}&client_id=uqXZu7wXziL89doiBnoz0yUFShlmZY4rnvn4VMHWx0s&orientation=landscape`;

    axios.get(url)
      .then(res => {
        const { results, total } = res.data;
        this.imgList1Target.src = results[0].urls.small;
        this.imgList2Target.src = results[1].urls.small;
        this.imgList3Target.src = results[2].urls.small;
        this.imgList4Target.src = results[3].urls.small;
        this.imgList5Target.src = results[4].urls.small;
    });
  }

  handle_select_img(e, element) {
    e.preventDefault()
    this.headerImgTarget.value = element.src
    this.imageShownTarget.src = element.src
  }

  handle_select_img_1(e) {
    this.handle_select_img(e, this.imgList1Target)
  }
  handle_select_img_2(e) {
    this.handle_select_img(e, this.imgList2Target)
  }
  handle_select_img_3(e) {
    this.handle_select_img(e, this.imgList3Target)
  }
  handle_select_img_4(e) {
    this.handle_select_img(e, this.imgList4Target)
  }
  handle_select_img_5(e) {
    this.handle_select_img(e, this.imgList5Target)
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
    let strImg = this.headerImgTarget.value
    if (strImg !== null && strImg != "" && strImg.startsWith("http")) {
      this.imageShownTarget.src = this.headerImgTarget.value
      return
    }

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
