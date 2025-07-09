document.addEventListener("DOMContentLoaded", function () {
  function initMap() {
    const mapElement = document.getElementById("map");
    if (!mapElement) return;

    const lat = parseFloat(mapElement.dataset.lat);
    const lng = parseFloat(mapElement.dataset.lng);

    if (!isNaN(lat) && !isNaN(lng)) {
      const map = new google.maps.Map(mapElement, {
        center: { lat: lat, lng: lng },
        zoom: 15,
      });
      new google.maps.Marker({
        map: map,
        position: { lat: lat, lng: lng },
        title: "ここです！",
      });
    }
  }

  window.initMap = initMap; // Google Maps APIが呼び出す関数として登録
});