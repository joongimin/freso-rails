class BrandsController
  $(document).delegate "a#template_select", "click", () ->
    $(".selected").removeClass("selected").html("")
    $(this).find("li").addClass("selected").html("<div class='arrow-up'></div>")
