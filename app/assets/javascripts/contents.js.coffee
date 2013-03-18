@loadContent = (contentID) ->
  $('body').modalmanager('loading')

  request = $.ajax(
                url: '/contents/' + contentID,
                type: 'GET')

  request.done () ->
    $("#full-width").modal()


window.bindContentClickEvents = ->
  $('a[data-content-id]').click (event)->
    loadContent $(this).attr('data-content-id')
    event.preventDefault()
    return
  return

$ ->
  bindContentClickEvents()

  infiniteScrollOpts =
    onAfterPageLoad: bindContentClickEvents

  $('#contents').waypoint('infinite', infiniteScrollOpts)

