$ ->
  loadFacebookSDK()
  bindFacebookEvents() unless window.fbEventsBound

bindFacebookEvents = ->
  $(document)
  .on('turbolinks:request-start', saveFacebookRoot)
  .on('turbolinks:load', ->
    restoreFacebookRoot()
    FB?.XFBML.parse()
  )
  @fbEventsBound = true

saveFacebookRoot = ->
  if $('#fb-root').length
    @fbRoot = $('#fb-root').detach()

restoreFacebookRoot = ->
  if @fbRoot?
    if $('#fb-root').length
      $('#fb-root').replaceWith @fbRoot
    else
      $('body').append @fbRoot

loadFacebookSDK = ->
  window.fbAsyncInit = initializeFacebookSDK
  $.getScript("//connect.facebook.net/en_US/sdk.js#xfbml=1")

initializeFacebookSDK = ->
  FB.init
    appId  : $('meta[name="fb:app_id"]').attr('content')
    status : true
    cookie : true
    xfbml  : true
    version: 'v2.7'
