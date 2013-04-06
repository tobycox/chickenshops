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

function addHeatmap(results) {
  var heatmapData = [];
  for (var i = 0; i < results.length; i++) {
    var shop = results[i];
    var latLng = new google.maps.LatLng(shop.latitude, shop.longitude);
    heatmapData.push(latLng);
  }
  var heatmap = new google.maps.visualization.HeatmapLayer({
    data: heatmapData,
    dissipating: false,
    map: window.chickenMap
  });
}

function populateMap(map) {
  $.getJSON('/shops.json', null, function(data, textStatus, jqXHR) {
    $('#shop-count').html('Showing ' + data.length + ' shops');
    addHeatmap(data);
  });
}


$(document).ready(function() {
  window.chickenMap = initialize();
  populateMap(window.chickenMap);
});
