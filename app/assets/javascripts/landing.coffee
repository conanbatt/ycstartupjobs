# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Search

  constructor: (root)->
    @root = $(root)
    @query = ""
    @tags = new Set()
    @companies = []
    @setup_events()

    @initializeFromStore()

  initializeFromStore: ()->
    history = localStorage.getItem("search_query")
    if(history)
      object = JSON.parse(history)
      @query = object.q || ""
      @tags = new Set(object.tags || [])
      @companies = object.companies.filter((comp)->
        comp && comp.id && comp.name
      ) || []

      @root.find(".insta_search").val(@query)
      for tag in object.tags
        @root.find("[data-tag=#{tag}]").toggleClass("active")
      @update()

  store: (data)->
    localStorage.setItem("search_query", JSON.stringify(data))

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

    @root.on "click", ".exclude_company", (e)=>(
      e.preventDefault()
      company = $(e.target).data()
      @companies.push(company)
      @update()
    )
    @root.on "click", ".include_company", (e)=>(
      id = $(e.target).data("id")
      @companies = @companies.filter((el)->
        el.id != id
      )
      @update()
    )

    @root.find(".stick_in_parent").stick_in_parent({ parent: ".sticky_parent", offset_top: -30});

  params: ->
    c_ids = @companies.map((c)-> c.id)
    {
      q: @query,
      tags: Array.from(@tags)
      companies: c_ids
    }

  store_params: ->
    {
      q: @query,
      tags: Array.from(@tags)
      companies: @companies
    }

  update_companies: ->
    return unless @companies.length

    exc = @root.find(".excluded_companies")
    res = @companies.map((comp)->
      $("<span data-id='#{comp.id}' class='include_company tech_btn btn btn-outline btn-sm btn-danger'>#{comp.name}</span>")
    )

    exc.html(res)


  update: ->
    @store(@store_params())
    @update_companies()
    $.get("/search", @params()).then((resp) =>
      @root.find(".jobs_container").html(resp)
    )

$(->

  search = new Search(".home")

)