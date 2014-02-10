class PanelBuilder
  constructor: (@options) ->

  render: (panel_content = null) ->
    @_try_target()

    @$panel = $('<div class="panel" />')
    @$panel.addClass @options.pclass if @options.pclass?
    @$panel.attr 'data-pid', @options.pid
    @$panel.attr 'id', @options.target
    @$panel.html panel_content if panel_content?

    if @_panel_exists()
      $("##{@options.target}").replaceWith @$panel
    else
      $('#main').append @$panel

    setTimeout =>
      @$panel.addClass('in')
    , 50

  _try_target: ->
    unless @options.target?
      throw new Error('[Wiselinks] data-target needs to be specified.')

  _panel_exists: ->
    $('.panel').filter("##{@options.target}").length >= 1



window._Wiselinks = {} if window._Wiselinks == undefined
window._Wiselinks.PanelBuilder = PanelBuilder
