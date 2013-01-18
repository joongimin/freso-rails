class BrandsController
  create: ->
    $(document).delegate "div#template_select", "click", ->
      $(".selected").removeClass("selected").find(".selected_frame").addClass("disabled")
      $(this).find("li").addClass("selected").find(".disabled").removeClass("disabled")
      $(this).find("input").attr("checked", "checked")

    $(document).delegate ".go_design_store", "click", ->
      alert($(this).data("message"))

    $(document).delegate ".cancel", "click", ->
      alert($(this).data("message"))

    $(document).delegate ".show_all", "click", ->
      alert($(this).data("message"))

    $(document).delegate ".template_frame", "mouseenter", ->
    	$(this).find(".info_container").animate({top: '15px'}, 'fast')

  	$(document).delegate ".template_frame", "mouseleave", ->
    	$(this).find(".info_container").animate({top: '210px'}, 'fast')

    $(document).delegate "#select_layout_buttom", "click", ->
      alert("Go Next!")

this.freso.brands = new BrandsController