# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(->
  $(".insta_search").on("input", (e)=>
    $.get("/search", {q: e.target.value}).then((resp)->
      $(".jobs_container").html(resp)
    )
  )

)