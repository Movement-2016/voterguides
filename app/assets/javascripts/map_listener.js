$(document).on('turbolinks:load', function() {
  $('#searchable_map').usmap({
    // The styles for the state
    'stateStyles': {
      fill: "#D4867F",
    },

    // The styles for the hover
    'stateHoverStyles': {
      fill: "#79A6D2",
    },

    'click' : function(event, data) {
      location = '/voter_guides?search_state=' + data.name;
    }

  });
});
