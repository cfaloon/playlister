$(document).on 'turbolinks:load', ->
  $.each ['album', 'artist','label'], (_, resource) ->
    $("select[name=#{resource}_name]").select2
      ajax: {
        url: "/#{resource}s"
        data: (params) ->
          { q: params.term }
        dataType: 'json'
        delay: 500
        processResults: (data, params) ->
          {
            results: $.map(data, (el, _) ->
              console.log(el)
              {
                id: el.name
                name: el.name
              }
            )
          }
        cache: true
      }
      escapeMarkup: (markup) -> markup
      templateResult: (item) -> item.name
      templateSelection: (item) -> item.name
      width: '100%'
      tags: true
      createTag: (params) ->
        {
          id: params.term
          name: params.term
        }
