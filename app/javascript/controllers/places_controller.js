import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["field", "map", "latitude", "longitude"];

  connect() {
    console.log("Connected!!!");
    if (typeof google != "undefined") {
      this.initMap();
    }
  }

  initMap() {
    this.map = new google.maps.Map(this.mapTarget, {
      center: new google.maps.LatLng(
        this.data.get("latitude") || 39.5,
        this.data.get("longitude") || -98.35
      ),
      zoom: this.data.get("latitude") == null ? 4 : 15,
    });

    this.autocomplete = new google.maps.places.Autocomplete(this.fieldTarget);
    this.autocomplete.bindTo("bounds", this.map);
    this.autocomplete.setFields([
      "address_components",
      "geometry",
      "icon",
      "name",
    ]);
    this.autocomplete.addListener("place_changed", this.placeChanged.bind(this));

    this.marker = new google.maps.Marker({
      map: this.map,
      anchorPoint: new google.maps.Point(0, -29),
    });
  }

  placeChanged() {
    console.log("Place changed!!!");
    let place = this.autocomplete.getPlace();

    if (!place.geometry) {
      window.alert(`No details available for input: ${place.name}`);
      return;
    }

    if (place.geometry.viewport) {
      this.map.fitBounds(place.geometry.viewport);
    } else {
      this.map.setCenter(place.geometry.location);
      this.map.setZoom(17);
    }

    this.marker.setPosition(place.geometry.location);
    this.marker.setVisible(true);

    this.latitudeTarget.value = place.geometry.location.lat();
    this.longitudeTarget.value = place.geometry.location.lng();

    const addressComponents = place.address_components;
    let city = "";
    let zipcode = "";

    addressComponents.forEach((component) => {
      const types = component.types;
      if (types.includes("locality")) {
        city = component.long_name;
      }
      if (types.includes("postal_code")) {
        zipcode = component.long_name;
      }
    });

    console.log()

    // Send AJAX request to update location
    fetch("/listings/update_location", {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          .getAttribute("content"),
      },
      body: JSON.stringify({ city: city, zipcode: zipcode }),
    })
      .then((response) => response.json())
      .then((data) => {
        console.log("Data: ", data);
        if (data.success) {
          console.log("Location updated successfully");
        }
      });
  }

  keydown(event) {
    if (event.key == "Enter") {
      event.preventDefault();
    }
  }
}
