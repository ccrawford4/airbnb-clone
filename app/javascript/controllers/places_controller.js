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
      "formatted_address",
    ]);
    this.autocomplete.addListener(
      "place_changed",
      this.placeChanged.bind(this)
    );

    this.marker = new google.maps.Marker({
      map: this.map,
      anchorPoint: new google.maps.Point(0, -29),
    });
  }

  placeChanged() {
    let place = this.autocomplete.getPlace();

    console.log("Place: ", place);
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

    const latitude = place.geometry.location.lat();
    const longitude = place.geometry.location.lng();
    const addressComponents = place.address_components;
    let city = "";
    let zipcode = "";
    let country = "";
    let state = "";

    addressComponents.forEach((component) => {
      const types = component.types;
      if (types.includes("locality")) {
        city = component.long_name;
      }
      if (types.includes("postal_code")) {
        zipcode = component.long_name;
      }
      if (types.includes("country")) {
        country = component.long_name;
      }
      if (types.includes("administrative_area_level_1")) {
        state = component.long_name;
      }
    });

    try {
      // Send AJAX request to update location
      fetch("/listings/update_location", {
        method: "POST",
        body: JSON.stringify({
          city: city,
          state: state,
          zipcode: zipcode,
          country: country,
          address: place.formatted_address,
          latitude: latitude,
          longitude: longitude,
        }),
      }).then((response) => {
        console.log("Response: ", response);
        response.json().then((data) => {
          console.log("Data: ", data);
        });
      });
    } catch (error) {
      console.log("Error: ", error);
    }
  }

  keydown(event) {
    if (event.key == "Enter") {
      event.preventDefault();
    }
  }
}
