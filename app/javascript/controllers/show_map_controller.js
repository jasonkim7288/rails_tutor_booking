import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ["map"];

    connect() {
        console.log("maps connected")
        if (typeof(google) != "undefined") {
            this.initializeMap();
        }
    }

    // get all the instance of class for Maps
    initializeMap() {
        console.log('this.element.getAttribute("latitude"):', this.element.getAttribute("latitude"))
        console.log('this.mapTarget:', this.mapTarget)
        this.getMap();
        this.getMarker();
    }

    // create or get an instance of Map class
    getMap() {
        if (this.map == undefined) {
            this.map = new google.maps.Map(this.mapTarget, {
                center: new google.maps.LatLng(
                    parseFloat(this.element.getAttribute("latitude")),
                    parseFloat(this.element.getAttribute("longitude"))
                ),
                zoom: 17
            });
        }
        return this.map;
    }

    // create or get an instance of Marker class which shows the actual location with the red teardrop-shaped icon
    getMarker() {
        if (this.marker == undefined) {
            this.marker = new google.maps.Marker({
                map: this.getMap(),
                anchorPoint: new google.maps.Point(0, 0)
            });

            let mapLocation = {
                lat: parseFloat(this.element.getAttribute("latitude")),
                lng: parseFloat(this.element.getAttribute("longitude"))
            }
            this.marker.setPosition(mapLocation);
            this.marker.setVisible(true);
        }
        return this.marker;
    }

}