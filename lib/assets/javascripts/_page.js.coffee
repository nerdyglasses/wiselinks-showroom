#= require _request_manager

class Page
  constructor: (@$target, @options) ->
    self = this

    @template_id = new Date().getTime()
    @request_manager = new _Wiselinks.RequestManager(@options)

    @$target = @_wrap(@$target)

    @_try_target(@$target)

    if History.emulated.pushState && @options.html4 == true
      if window.location.href.indexOf('#.') == -1 &&
          @options.html4_normalize_path == true &&
          window.location.pathname != @options.html4_root_path

        window.location.href = "#{window.location.protocol}//#{window.location.host}#{@options.html4_root_path}#.#{window.location.pathname}"

    History.Adapter.bind(
      window,
      "statechange"
      (event, data) ->
        state = History.getState()

        if state.data.bpi != undefined
          $('.panel').eq(state.data.bpi).nextAll('.panel').removeClass('animation-in')
        else
          if self._template_id_changed(state)
            self._call(self._reset_state(state))
          else
            self._call(state)
    )

    $(document).on(
      'click', 'a[data-push], a[data-replace]'
      (event) ->
        return true if $(event.target).is('input')
        if (link = new _Wiselinks.Link(self, $(this))).allows_process(event)
          event.preventDefault()
          link.process()

          return false
    )

    $(document).on(
      'submit', 'form[data-push], form[data-replace]'
      (event) ->
        if (form = new _Wiselinks.Form(self, $(this)))
          event.preventDefault()
          form.process()

          return false
    )

  load: (url, other_options = {}) ->
    defaults =
      timestamp: (new Date().getTime())
      target: selector
      referer: window.location.href
      render: "template"

    options = {}
    $.extend true, options, defaults, other_options
    
    @template_id = new Date().getTime() if options.render != 'partial' && options.render != 'panel'
    options.template_id = @template_id

    selector = if options.target?
      $target = this._wrap(options.target)
      this._try_target($target, options)
      $target.selector

    History.pushState( options, document.title, url )

  reload: ->
    History.replaceState({
      timestamp: (new Date().getTime()),
      template_id: @template_id,
      render: 'template',
      referer: window.location.href
    }, document.title, History.getState().url )

  _call: (state) ->
    $target = if state.data.target? then $(state.data.target) else @$target
    this.request_manager.call($target, state)

  _template_id_changed: (state) ->
    !state.data.template_id? || state.data.template_id != @template_id

  _make_state: (url, target, render = 'template', referer) ->
    {
      url: url
      data:
        target: target
        render: render
        referer: referer
    }

  _reset_state: (state) ->
    state.data = {} unless state.data?
    state.data.target = null
    state.data.render = 'template'
    state

  _try_target: ($target, request_options = {}) ->
    if $target.length == 0 &&
    @options.target_missing == 'exception' &&
    request_options.render != 'panel'
      throw new Error("[Wiselinks] Target missing: `#{$target.selector}`")

  _wrap: (object) -> $(object)


window._Wiselinks = {} if window._Wiselinks == undefined
window._Wiselinks.Page = Page
