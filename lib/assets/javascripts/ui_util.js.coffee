class @UIUtil
  slide_content: (slider_path, html, args = {}) ->
    $slider = $(slider_path)
    if $slider.length != 1
      return

    args["direction"] ||= "right"
    args["margin"] ||= 0
    args["duration"] ||= 1000
    args["easing"] ||= "easeInCubic"
    args["nofog"] ||= false

    if !args["nofog"]
      $("body").append("<div class='fog left'></div>").append("<div class='fog right'></div>")

    slider_width = $slider.width()

    $slider.addClass("sliding")
    $current_slide = $slider.children("li").css("float", "left").css("width", slider_width)

    $next_slide = $("<li class='next_slide'></li>")
    if args.slide_class
      $next_slide.addClass(args.slide_class)
    $next_slide.css("float", "left").css("width", slider_width).html(html)

    if args["direction"] == "right"
      $slider.append($next_slide)
      target_margin_left = -slider_width - args["margin"]
      $current_slide.css("margin-right", args["margin"])
    else
      $slider.prepend($next_slide)
      $slider.css("margin-left": -slider_width - args["margin"])
      target_margin_left = 0
      $current_slide.css("margin-left", args["margin"])

    $slider
      .css("width", slider_width * 2 + args["margin"])
      .animate {"margin-left": target_margin_left}, {
        easing: args["easing"],
        duration: args["duration"],
        complete: ->
          $current_slide.remove()
          $next_slide.css("float", "").css("width", "").removeClass("next_slide")
          $slider.css("margin-left", "").css("width", "")
          $slider.removeClass("sliding").trigger("nv:slide:end")
          if !args["nofog"]
            $(".fog").remove()
      }

  show: ($target, args = {}) ->
    $target.css("opacity", 1).show()

  hide: ($target) ->
    $target.css("opacity", 0).hide()

  scroll_to: (target) ->
    $html = $("html")
    if target == "top"
      scroll_top = 0
    else
      scroll_top = $(target).offset().top

    $("html, body").animate {scrollTop: scroll_top}, "fast"

  fade_in: ($target, complete = null) ->
    $target.stop().show().animate({opacity: 1}, "slow", complete)

  fade_out: ($target, complete = null) ->
    $target.stop().animate {opacity: 0}, "fast", ->
      $(this).hide()
      if complete
        complete()

this.util.ui_util = new UIUtil