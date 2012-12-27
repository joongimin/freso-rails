draw_background = (args = {}) ->
  tilt = 320
  $canvas_left = $("#home-index canvas.background-left")
  canvas_left = $canvas_left[0]
  $canvas_left.css("left", 0)
  canvas_left.width = ($(window).width() + tilt + 10) * 0.5 + 100
  canvas_left.height = $(window).height()

  ctx = canvas_left.getContext("2d")
  ctx.clearRect(0, 0, canvas_left.width, canvas_left.height)
  ctx.fillStyle = "rgb(244, 244, 244)";
  ctx.beginPath()
  ctx.moveTo(0, 0)
  ctx.lineTo(canvas_left.width - 5, 0)
  ctx.lineTo(canvas_left.width - tilt, canvas_left.height)
  ctx.lineTo(0, canvas_left.height)
  ctx.closePath()
  if args["shadow"]
    ctx.shadowColor = 'rgba(0, 0, 0, 0.5)';
    ctx.shadowBlur = 5;
    ctx.shadowOffsetX = 1;
    ctx.shadowOffsetY = 1;
  ctx.fill()

  $canvas_right = $("#home-index canvas.background-right")
  canvas_right = $canvas_right[0]
  $canvas_right.css("right", 0)
  canvas_right.width = ($(window).width() + tilt + 10) * 0.5 - 100
  canvas_right.height = $(window).height()

  ctx = canvas_right.getContext("2d")
  ctx.clearRect(0, 0, canvas_right.width, canvas_right.height)
  ctx.fillStyle = "rgb(244, 244, 244)";
  ctx.beginPath()
  ctx.moveTo(tilt, 0)
  ctx.lineTo(canvas_right.width, 0)
  ctx.lineTo(canvas_right.width, canvas_right.height)
  ctx.lineTo(5, canvas_right.height)
  ctx.closePath()
  if args["shadow"]
    ctx.shadowColor = 'rgba(0, 0, 0, 0.5)';
    ctx.shadowBlur = 5;
    ctx.shadowOffsetX = -1;
    ctx.shadowOffsetY = -1;
  ctx.fill()

$ ->
  draw_background()

  $("a#link_login_with_nuvo").click ->
    speed = 1000
    easing = "easeInCubic"
    draw_background(shadow: true)
    $background_left = $("#home-index canvas.background-left")
    $background_left.animate({left: 200 - $background_left.width()}, speed, easing, -> $("div.back_container").animate({opacity: 1}))

    $background_right = $("#home-index canvas.background-right")
    $background_right.animate({right: 200 - $background_right.width()}, speed, easing)

    $logo_container = $("div.logo_container")
    $logo_container.css("top", "49%").css("left", "50.5%")
    $logo_container.animate({top: "12%", left: "6%"}, speed, easing)
    $logo_container.find(".login").animate({opacity: 0}, "fast", -> $(this).hide())

  $("a#link_back").click ->
    speed = 1000
    easing = "easeInCubic"

    $("div.back_container").animate({opacity: 0})

    $background_left = $("#home-index canvas.background-left")
    $background_left.animate({left: 0}, speed, easing, ->
      draw_background(shadow: false)
      $logo_container.find(".login").show().animate({opacity: 1})
      )

    $background_right = $("#home-index canvas.background-right")
    $background_right.animate({right: 0}, speed, easing)

    $logo_container = $("div.logo_container")
    $logo_container.animate({top: "50%", left: "50%"}, speed, easing)