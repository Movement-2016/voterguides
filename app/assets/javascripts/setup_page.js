$(document).on('turbolinks:load', function() {
  load_map_listener();
  sortable_endorsements('#endorsement_list');
  display_endorsements('#endorsement_list');
});
