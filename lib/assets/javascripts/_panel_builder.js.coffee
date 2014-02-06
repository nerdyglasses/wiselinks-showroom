class PanelBuilder
  constructor: (@options) ->

  render: ->
    @_try_target()

    $panel = $('<div class="panel" />')
    $panel.addClass @options.pclass if @options.pclass?
    $panel.data 'pid', @options.pid if @options.pid?
    $panel.attr 'id', @options.target
    console.log "[PanelBuilder] Panel", $panel

    if @_panel_exists()
      console.log "Panel exists"
      $(@options.target).replaceWith $panel
    else
      console.log "Panel exists NOT"
      $('#main').append $panel



  _try_target: ->
    unless @options.target?
      throw new Error('[Wiselinks] data-target needs to be specified.')

  _panel_exists: ->
    console.log "looking for panel: ##{@options.target}"
    $('.panel').filter("##{@options.target}").length >= 1



window._Wiselinks = {} if window._Wiselinks == undefined
window._Wiselinks.PanelBuilder = PanelBuilder
