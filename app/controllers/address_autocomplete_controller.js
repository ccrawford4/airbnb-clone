import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.initMap()
    this.initAutocomplete()
  }

  initMap() {
    this.map = new google.maps.Map(document.getElementById("map"), {
      center: { lat: 37.7749, lng: -122.4194 }, // San Francisco coordinates
      zoom: 13,
      disableDefaultUI: true, // Removes default UI controls
      styles: [
        {
          featureType: "poi",
          elementType: "labels",
          stylers: [{ visibility: "off" }]
        },
        {
          featureType: "transit",
          elementType: "labels",
          stylers: [{ visibility: "off" }]
        }
      ]
    })
  }

  initAutocomplete() {
    const input = this.element
    const autocomplete = new google.maps.places.Autocomplete(input, {
      fields: ["address_components", "geometry", "formatted_address"],
      types: ["address"]
    })
    
    autocomplete.addListener("place_changed", () => {
      const place = autocomplete.getPlace()
      
      if (!place.geometry) {
        return
      }

      // Update map
      this.map.setCenter(place.geometry.location)
      
      // Add marker
      if (this.marker) {
        this.marker.setMap(null)
      }
      
      this.marker = new google.maps.Marker({
        map: this.map,
        position: place.geometry.location,
        icon: {
          path: google.maps.SymbolPath.CIRCLE,
          scale: 10,
          fillColor: "#000000",
          fillOpacity: 1,
          strokeWeight: 2,
          strokeColor: "#FFFFFF",
        }
      })

      // Update the disabled location input
      document.querySelector('input[name="location[formatted_address]"]').value = place.formatted_address
    })
  }
}