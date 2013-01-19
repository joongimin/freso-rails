class BrandsController
  select_layout: ->
    $(document).delegate "li.layout_template", "click", ->
      $this = $(this)
      $this.closest("ul").find(".selected").removeClass("selected")
      $this.addClass("selected").find(".disabled").removeClass("disabled")
      $this.find("input").attr("checked", "checked")

    $(document).delegate ".go_design_store", "click", ->
      alert($(this).data("message"))

    $(document).delegate ".show_all", "click", ->
      alert($(this).data("message"))

    $(document).delegate "li.layout_template", "mouseenter", ->
    	$(this).find(".info_container").animate({top: 0}, 120)

  	$(document).delegate "li.layout_template", "mouseleave", ->
    	$(this).find(".info_container").animate({top: '210px'}, 120)

    $(document).delegate "#select_layout_buttom", "click", ->
      alert("Go Next!")

  form: ->
    $("select").each ->
      $select = $(this)
      $select.select2
        width: "element"
      $select.on "change", (e) ->
        # Trigger validation
        $select.trigger("focusout.ClientSideValidations")

  new: ->
    @form()

  edit: ->
    @form()

  set_step: (step) ->
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

this.freso.brands_controller = new BrandsController