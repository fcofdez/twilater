loadContent = (contentID) ->
  $('body').modalmanager('loading')

  request = $.ajax(
                url: '/contents/' + contentID,
                type: 'GET')

  request.done () ->
    $("#full-width").modal()

loadMorePages = (page) ->
  request = $.ajax(
                url: '/contents.js',
                type: 'GET')


$ ->
  $('a[content_id]').click (event)->
    loadContent $(this).attr('content_id')
    event.preventDefault()

  waypointOpts = 
    ofsset: -25,
    triggerOnce: true,
    context: '#contents',
    onlyOnScroll: true

  $('#contents').waypoint( ->
    loadMorePages 2
    , waypointOpts)

