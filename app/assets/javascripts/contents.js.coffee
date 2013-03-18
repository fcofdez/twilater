@loadContent = (contentID) ->
  $('body').modalmanager('loading')

  request = $.ajax(
                url: '/contents/' + contentID,
                type: 'GET')

  request.done () ->
    $("#full-width").modal()


window.bindContentClickEvents = ->
  $('a[content_id]').click (event)->
    loadContent $(this).attr('content_id')
    event.preventDefault()
    return
  return

$ ->
  bindContentClickEvents()

  infiniteScrollOpts =
    onAfterPageLoad: bindContentClickEvents

  $('#contents').waypoint('infinite', infiniteScrollOpts)

