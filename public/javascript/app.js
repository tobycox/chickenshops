var london = new google.maps.LatLng(51.5171, 0.1062);

function initialize() {
  var mapOptions = {
    center: london,
    zoom: 11,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById("map-canvas"),
      mapOptions);
  return map;
}

function callback(results, status) {
  if (status == google.maps.places.PlacesServiceStatus.OK) {
    addHeatmap(results);
  }
}

function addHeatmap(results) {
  var heatmapData = [];
  for (var i = 0; i < results.length; i++) {
    var coords = results[i].geometry.location;
    var latLng = new google.maps.LatLng(coords.jb, coords.kb);
    heatmapData.push(latLng);
  }
  var heatmap = new google.maps.visualization.HeatmapLayer({
    data: heatmapData,
    dissipating: false,
    map: window.chickenMap
  });
}

function populateMap(map) {
  var request = {
    location: london,
    radius: '10000',
    types: ['store'],
    keyword: 'chicken'
  };

  service = new google.maps.places.PlacesService(map);
  service.nearbySearch(request, callback);
}


$(document).ready(function() {
  window.chickenMap = initialize();
  populateMap(window.chickenMap);
});
