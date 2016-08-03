function sortable_endorsements(selector) {
  if ($(selector).length == 0) {
    return false;
  }
  var target_list = $(selector)[0];
  Sortable.create(target_list, {
    handle: '.endorsement_handle',
    draggable: '.endorsement_list_item',
    ghostClass: 'endorsement_list_placeholder',
    onUpdate: function (evt) {

      var itemEl = evt.item;  // dragged HTMLElement
      $.ajax($(evt.item).data('target-url'), {
        type: 'PATCH',
        data: {'endorsement': {'guide_order_position': evt.newIndex}}
      }).done(function() {
        //console.log('completed update to ' + evt.newIndex);
      }).error(function() {
        //console.log('something has gone wrong');
      })
      // + indexes from onEnd
    }
  });
}

function display_endorsements(selector) {
  var w = Math.max(document.documentElement.clientWidth, window.innerWidth || 0);
  var endorsements = $(".panel-collapse", selector);
  if (w > 768 && endorsements.length > 0) {
    endorsements.addClass('in');
  }
  $('input[type=checkbox][data-toggle^=vg_toggle]').bootstrapToggle();
}
