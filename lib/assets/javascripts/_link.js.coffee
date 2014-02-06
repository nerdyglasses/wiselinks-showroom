class Link
  constructor: (@page, @$link) ->

  allows_process: (event) ->
    !(this._cross_origin_link(event.currentTarget) ||
      this._non_standard_click(event))

  process: ->
    options = {}
    switch @$link.data('push')
      when 'partial' then type = 'partial'
      when 'panel' then type = 'panel'
      else type = 'template'

    options =
      type:   type
      target: @$link.data('target')
      pid:    @$link.data('pid')
      pclass: @$link.data('pclass')

    @page.load(@$link.attr("href"), options)

  _cross_origin_link: (link) ->
    this._different_protocol(link) ||
    this._different_host(link) ||
    this._different_port(link)

  _different_protocol: (link) ->
    return false if link.protocol == ':' || link.protocol == ''
    location.protocol != link.protocol

  # IE returns host with port and all other browsers return host without port
  #
  _different_host: (link) ->
    return false if link.host == ''
    (location.host.split(':')[0] != link.host.split(':')[0])

  # IE returns for link.port "80" but the location.port is ""
  # Stupid but "modern" browsers return correct values
  #
  _different_port: (link) ->
    port_equals = (location.port == link.port) ||
      (location.port == '' && (link.port == "80" || link.port == "443"))

    !port_equals

  _non_standard_click: (event) ->
    event.metaKey || event.ctrlKey || event.shiftKey || event.altKey

window._Wiselinks = {} if window._Wiselinks == undefined
window._Wiselinks.Link = Link
