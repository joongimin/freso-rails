class LayoutTemplatesController
  form: ->
    HtmlMode = require("ace/mode/html").Mode
    $(".ace_editor").each ->
      $target = $(this).closest(".field_value").find("textarea").hide()
      editor = ace.edit($(this).get(0))
      editor.setTheme("ace/theme/twilight")
      editor.getSession().setMode(new HtmlMode())
      editor.getSession().setTabSize(2)
      editor.getSession().setUseSoftTabs(true)
      editor.getSession().on "change", (e) ->
        $target.val(editor.getValue())

  new: ->
    @form()

  edit: ->
    @form()

  show: ->
    HtmlMode = require("ace/mode/html").Mode
    $(".ace_editor").each ->
      editor = ace.edit($(this).get(0))
      editor.setTheme("ace/theme/twilight")
      editor.getSession().setMode(new HtmlMode())
      editor.getSession().setTabSize(2)
      editor.getSession().setUseSoftTabs(true)

this.freso.layout_templates_controller = new LayoutTemplatesController