class @UIUtil
  slide_content: ($slider, html, args = {}) ->
    args["direction"] ||= "right"

    screen_width = $(window).width()
    screen_height = $(window).height()

    $slider.addClass("sliding")
    $current_slide = $slider.children("li.current_slide").css("float", "left").css("width", screen_width).css("height", screen_height)

    $next_slide = $("<li class='next_slide'></li>")
    $html = $(html)
    $next_slide.css("float", "left").css("width", screen_width).css("height", screen_height).append($html)

    if args["direction"] == "right"
      $slider.append($next_slide)
      target_margin_left = "-100%"
    else
      $slider.prepend($next_slide)
      $slider.css("margin-left": "-100%")
      target_margin_left = 0

    $html.filter("script").each ->
      e = document.createElement('script')
      e.src = $(this).attr("src")
      e.type = "text/javascript"
      e.async = true
      $next_slide[0].appendChild(e)

    $slider
      .css("width", screen_width * 2)
      .css("height", screen_height)
      .animate {"margin-left": target_margin_left}, {
        easing: "easeInCubic",
        duration: 1000,
        complete: ->
          $current_slide.remove()
          $next_slide.css("float", "").css("width", "").css("height", "").removeClass("next_slide").addClass("current_slide")
          $slider.css("margin-left", "").css("width", "").css("height", "")
          $slider.removeClass("sliding").trigger("nv:slide:end")
      }