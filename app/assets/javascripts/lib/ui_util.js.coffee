class @UIUtil
  slide_content: (html) ->
    screen_width = $(window).width()
    screen_height = $(window).height()

    $slider = $("ul#slider")
    $current = $("li.current").css("float", "left").css("width", screen_width).css("height", screen_height)

    $next = $("<li class='next'></li>")
    $next.css("float", "left").css("width", screen_width).css("height", screen_height).html(html)

    $("ul#slider")
      .css("width", screen_width * 2)
      .css("height", screen_height)
      .append($next)
      .animate {"margin-left": "-100%"}, {
        easing: "easeInCubic",
        duration: 1000,
        complete: ->
          $current.remove()
          $next.css("float", "").css("width", "").css("height", "").removeClass("next").addClass("current")
          $slider.css("margin-left", "").css("width", "").css("height", "")
      }