$(document).on('turbolinks:load', function() {
  load_map_listener();
  sortable_endorsements('#endorsement_list');
  display_endorsements('#endorsement_list');
  init_jquery_file_uploader('#guide_uploader');
});
$(document).on('cocoon:after-insert', function(e, insertedItem) {
  $('input[type=checkbox][data-toggle^=vg_toggle]', insertedItem).bootstrapToggle();
});
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
