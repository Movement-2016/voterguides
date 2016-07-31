function init_jquery_file_uploader(selector) {
  $(selector).each(function(i, elem) {
    var fileInput    = $(elem);
    var form         = $(fileInput.parents('form:first'));
    var postData     = $('#voterguide_pdf_uploader').data();
    var submitButton = form.find('input[type="submit"]');
    var progressBar  = $("<div class='progress-bar progress-bar-striped' role='progressbar'></div>");
    var barContainer = $("<div class='progress'></div>").append(progressBar);
    fileInput.after(barContainer);
    fileInput.fileupload({
      fileInput:       fileInput,
      url:             postData['url'],
      type:            'POST',
      autoUpload:      true,
      formData:        postData['formData'],
      paramName:       'file', // S3 does not like nested name fields i.e. name="user[avatar_url]"
      dataType:        'XML',  // S3 returns XML if success_action_status is set to 201
      replaceFileInput: false,
      progressall: function (e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        progressBar.css('width', progress + '%')
        progressBar.attr('aria-valuenow', progress);
      },
      start: function (e) {
        submitButton.prop('disabled', true);
      },
      done: function(e, data) {
        submitButton.prop('disabled', false);
        progressBar.removeClass('progress-bar-striped').text("Uploading done");

        // extract key and generate URL from response
        var key   = $(data.jqXHR.responseXML).find("Key").text();
        var url   = 'https://' + postData['host'] + '/' + encodeURI(key);
        //$('#voter_guide_external_guide_url').val(url);

        // create hidden field
        var input = $("<input />", { type:'hidden', name: fileInput.attr('name'), value: url })
        form.append(input);
      },
      fail: function(e, data) {
        submitButton.prop('disabled', false);

        progressBar.
          css('width', '100%').
          addClass("progress-bar-alert").
          text("Failed");
      }
    });
  });
}
