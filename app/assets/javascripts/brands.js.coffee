class BrandsController
  $(document).delegate "a#template_select", "click", () ->
    $(".selected").removeClass("selected").html("<div class='tick check_icon'></div>")
    $(this).find("li").addClass("selected").html("<div class='arrow-up'></div><div class='tick icon'></div>")
