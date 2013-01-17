this.freso ?= {}
this.util = this.freso

$ ->
  I18n.defaultLocale = freso.data_util.get("default-locale")
  I18n.locale = freso.data_util.get("locale")
  $(window).load ->
    window.loaded = true