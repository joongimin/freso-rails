class @Dialog
  constructor: ->
    $(".dialog").each ->
      $this = $(this)
      $this.dialog($this.data())

  alert: (message, callback) ->
    $alert = $(Mustache.to_html($("#templates_dialog_alert").html(), {title: I18n.t("javascripts.dialog.warning"), message: message}))
    $("body").append($alert)

    dialog_args = {
      modal: true,
      buttons: {}
    }
    dialog_args.buttons[I18n.t("javascripts.dialog.ok")] = ->
      $(this).dialog("destroy")
      if callback
        callback()

    $alert.dialog(dialog_args)

$ ->
  util.dialog = new Dialog