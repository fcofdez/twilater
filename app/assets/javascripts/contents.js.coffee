@loadContent = (contentID) ->
  $('body').modalmanager('loading')

  request = $.ajax(
                url: '/contents/' + contentID,
                type: 'GET')

  request.done () ->
    $("#full-width").modal()


loadMorePages = (page) ->
  request = $.ajax(
                url: '/contents.js',
                type: 'GET',
                data: 
                  page: page)

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

