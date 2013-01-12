$ ->
  save_translation = ($form, $link) ->
    $fields = $form.find("div.fields")
    $fields.empty()

    $tr = $link.closest("tr")
    $tr.find("textarea, input").each ->
      $input = $(this)
      $("<input type='hidden'></input>").attr("name", $input.attr("name")).val($input.val()).appendTo($fields)
    $form.submit()

  $("a#link_create_translation").click ->
    save_translation($("form#form_create_translation"), $(this))

  $("a#link_update_translation").click ->
    save_translation($("form#form_update_translation"), $(this))

  $("a#link_edit_translation").click ->
    $(this).closest("tr").addClass("editing")

  $("a#link_cancel_translation").click ->
    $(this).closest("tr").removeClass("editing")