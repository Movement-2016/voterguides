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
      .attr("stroke-width", 2)
      .attr("class", 'searchable_map_element') 
      //.attr("text-anchor","middle")//my code
      //.attr("text-anchor" , d.properties.stateabbrev)//my code  
      //.attr("text-anchor","middle")
      //.append("svg:text")
      //.text(function(d3){
      // return d3.properties.stateabbrev; 
      //  node.append("text")
      //  .attr("x", CalculateX(nodeType))             
      // .attr("y", CalculateY(nodeType))
      // .attr("text-anchor", "middle")  
      // .style("font-size", "14px")
      //.attr('fill','#cccccc')
      // .text(label);
      //  return node;
  }; 

  d3.json("/maps/us-states.json", render)
}


