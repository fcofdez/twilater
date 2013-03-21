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

bindInifiteScrollEvents = ->
  infiniteScrollOpts =
    onAfterPageLoad: bindContentClickEvents

  $('#contents .row').waypoint('infinite', infiniteScrollOpts)

$ ->
  bindContentClickEvents()
  bindInifiteScrollEvents()

#Due to turbolink gem
$(document).on('page:load', bindContentClickEvents)
$(document).on('page:load', bindInifiteScrollEvents)
