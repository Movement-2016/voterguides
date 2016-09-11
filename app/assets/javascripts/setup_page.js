$(document).on('turbolinks:load', function() {
  initD3Map('#searchable_map');
  sortable_endorsements('#endorsement_list');
  display_endorsements('#endorsement_list');
  init_jquery_file_uploader('#guide_uploader');
  init_quickselect('#state_quickselect');
});
$(document).on('cocoon:after-insert', function(e, insertedItem) {
  $('input[type=checkbox][data-toggle^=vg_toggle]', insertedItem).bootstrapToggle();
});
