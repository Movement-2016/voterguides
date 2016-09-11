function init_quickselect(selector) {
  console.log("assigning event", selector);
  $(selector).change(function(ev) {
    console.log("/voter_guides?search_state=" + $(ev.target).val());
    location.href = "/voter_guides?search_state=" + $(ev.target).val();
  });
}
