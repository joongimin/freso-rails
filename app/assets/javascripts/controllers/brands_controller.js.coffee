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

this.freso.brands_controller = new BrandsController