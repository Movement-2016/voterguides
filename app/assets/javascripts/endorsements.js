function sortable_endorsements(selector) {
  if ($(selector).length == 0) {
    return false;
  }
  var target_list = $(selector)[0];
  Sortable.create(target_list, {
    handle: '.endorsement_handle',
    draggable: '.endorsement_list_item',
    ghostClass: 'endorsement_list_placeholder',
    // dragging started
    onStart: function (/**Event*/evt) {
      $('.endorsement_list_item .panel-collapse.in').addClass('js-dragging-in').removeClass('in');
    },
    onEnd: function(evt) {
      $('.endorsement_list_item .panel-collapse.js-dragging-in').addClass('in').removeClass('js-dragging-in');
    },
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
    toggle_all_endorsements(new jQuery.Event);
  }
  $('#toggle_all_endorsements').on('click', toggle_all_endorsements);
  $('input[type=checkbox][data-toggle^=vg_toggle]').bootstrapToggle();
}

function toggle_all_endorsements(ev) {
  ev.preventDefault();
  var selector = "#endorsement_list";
  var panel_toggle = $('#toggle_all_endorsements');
  if(panel_toggle.attr('data-state') == 'closed') {
    $('.panel-collapse', selector).addClass('in');
    panel_toggle.text(panel_toggle.data('open'));
    panel_toggle.attr('data-state', 'open');
  } else {
    $('.panel-collapse', selector).removeClass('in');
    panel_toggle.text(panel_toggle.data('closed'));
    panel_toggle.attr('data-state', 'closed');
  }
}
