# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Search

  constructor: (root)->
    @root = $(root)
    @query = ""
    @tags = new Set()
    @setup_events()

    @initializeFromStore()

  initializeFromStore: ()->
    history = localStorage.getItem("search_query")
    if(history)
      object = JSON.parse(history)
      @query = object.q || ""
      @tags = new Set(object.tags || [])

      console.log "wa"
      @root.find(".insta_search").val(@query)
      for tag in object.tags
        @root.find("[data-tag=#{tag}]").toggleClass("active")
      @update()

  store: ()->
    localStorage.setItem("search_query", JSON.stringify(@params()))

  setup_events: ()->
    $(".insta_search").on("input", (e)=>
      @query = e.target.value
      @update()
    )

    $("[data-tag]").on("click", (e)=>
      tag = $(e.target).data("tag")
      $(e.target).toggleClass("active")
      if(@tags.has tag)
        @tags.delete tag
      else
        @tags.add tag
      @update()
    )

    @root.find(".stick_in_parent").stick_in_parent({ parent: ".sticky_parent", offset_top: -30});

  params: ->
    {
      q: @query,
      tags: Array.from(@tags)
    }

  update: ->
    @store(@params())
    $.get("/search", @params()).then((resp) =>
      @root.find(".jobs_container").html(resp)
    )

$(->

  search = new Search(".home")

)