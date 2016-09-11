function initD3Map(selector) {
  //Width and height
  var map_target = $(selector);

  if(map_target.length == 0) {
    return;
  }

  var w = map_target.width();
  var h = w * 2 / 3;
  map_target.css('height', h);

  //Define map projection
  var projection = d3.geoAlbersUsa()
    .translate([w / 2, h / 2])
    .scale([w * 1.4]);

  //Define path generator
  var path = d3.geoPath()
    .projection(projection);

  // Create SVG element
  var mapdiv = d3.select(selector);

  var svg = mapdiv.append("svg")
    .attr("width", w)
    .attr("height", h);

  var render = function(geo) {
    //Bind data and create one path per GeoJSON feature
    svg.selectAll("path")
      .data(geo.features)
      .enter()

      .append("a")
      .attr("xlink:href", function(d) {
        return "/voter_guides?search_state=" + d.properties.stateabbrev
      })
      .attr("target", "_parent")

      .append("path")
      .attr("d", path)
      .attr("stroke", "#e2eee1")
      .attr("stroke-width", 0.3)
      .attr("class", 'searchable_map_element')
  };

  d3.json("/maps/us-states.json", render)
}
