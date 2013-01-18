$ ->
  $(document).delegate "form .button.reset", "click", ->
    if confirm(I18n.t("javascripts.form.reset_confirmation"))
      $form = $(this).closest("form")
      $form[0].reset()
      $form.resetClientSideValidations()
      $form.pause_validation()
      $form.find("select").change()
      $form.resume_validation()

  $(document).delegate "form .button.submit", "click", ->
    $(this).closest("form").submit()