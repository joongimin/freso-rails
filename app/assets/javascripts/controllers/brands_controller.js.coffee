class BrandsController
  select_layout: ->
    $(document).delegate "li.layout_template", "click", ->
      $this = $(this)
      $this.closest("ul").find(".selected").removeClass("selected")
      $this.addClass("selected")
      $("#layout_layout_template_id").val(freso.data_util.get_resource_id($this))
      $("form#select_layout").resetClientSideValidations()

    $(document).delegate "a.link_design_store", "click", -> alert($(this).data("message"))

    $(document).delegate "a.link_show_all", "click", -> alert($(this).data("message"))

    $(document).delegate "li.layout_template", "mouseenter", ->
      $(this).find(".info_container").stop().animate({top: 0}, "fast", "easeInCubic")

  	$(document).delegate "li.layout_template", "mouseleave", ->
    	$(this).find(".info_container").stop().animate({top: 210}, "fast", "easeOutCubic")

  form: ->
    $("select").each ->
      $select = $(this)
      $select.select2
        width: "element"
      $select.on "change", (e) ->
        # Trigger validation
        $select.trigger("focusout.ClientSideValidations")
    $("form").enableClientSideValidations()

  new: ->
    @form()

  edit: ->
    @form()

  set_step: (step, html, prev) ->
    $(window).scrollTop(0)
    freso.ui_util.slide_content("ul#step_slider", html, {margin: 500, direction: if prev then "left" else "right"})

    $("ul.steps li.step").each (i) ->
      current_step = i + 1
      $this = $(this)
      if $this.hasClass("complete")
        if current_step < step
          # Do Nothing
        else if current_step == step
          $this.find(".check").fadeOut()
          $this.find(".step_title").animate {top: 63}
        else
          $this.find(".check").fadeOut()
      else if $this.hasClass("current")
        if current_step < step
          $this.find(".check").hide().fadeIn()
          $this.find(".step_title").animate {top: 52}
        else if current_step == step
          # Do Nothing
        else
          $this.find(".step_title").animate {top: 52}
      else
        if current_step < step
          $this.find(".check").hide().fadeIn()
        else if current_step == step
          $this.find(".step_title").animate {top: 63}
    setTimeout (->
      $("ul.steps li.step").removeClass("complete").removeClass("current").each (i) ->
        if i + 1 < step
          $(this).addClass("complete")
        else if i + 1 == step
          $(this).addClass("current")
      ), 400

  customize_tutorial: ->
    options = {
      autoPlay: false,
      nextButton: true,
      prevButton: true,
      showPrevButtonOnInit: false,
      navigationSkip: true,
      fadeFrameWhenSkipped: false,
      cycle: false,
    }
    tutorial_sequence = $("#tutorial_sequence").sequence(options)
    tutorial = $("#tutorial_sequence").data("sequence")

    $("a.next").click ->
      next_page = $(".current_page").data("index") + 1
      if next_page <= tutorial.numberOfFrames
        $(".current_page").removeClass("current_page")
        $("#"+next_page+".scroll_button").addClass("current_page")
        if next_page == tutorial.numberOfFrames
          $(this).fadeOut()
        else if next_page == 2
          $("a.prev").fadeIn()

    $("a.prev").click ->
      prev_page = $(".current_page").data("index") - 1
      if prev_page >= 1
        $(".current_page").removeClass("current_page")
        $("#"+prev_page+".scroll_button").addClass("current_page")
        if prev_page == 1
          $(this).fadeOut()
        else if prev_page == 2
          $("a.next").fadeIn()

    $(".scroll_button").click ->
      $(this).closest("ul").find(".current_page").removeClass("current_page")
      $("#tutorial_sequence").data("sequence").goTo($(this).data("index"))
      $(this).addClass("current_page")

this.freso.brands_controller = new BrandsController