loadContent = (contentID) ->
  $('body').modalmanager('loading')

  request = $.ajax(
                url: '/contents/' + contentID,
                type: 'GET')

  request.done () ->
    $("#full-width").modal()

$ ->
  $('a[content_id]').click (event)->
    loadContent $(this).attr('content_id')
    event.preventDefault()
