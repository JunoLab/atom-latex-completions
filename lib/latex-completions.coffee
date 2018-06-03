{CompositeDisposable} = require 'atom'
provider = require './provider'

module.exports =
  config:
    customAliases:
      type: 'string'
      default: ''
      description: 'Path to a custom set of completions. Multiple paths may be comma-seperated.'
      order: 1
    enableDefaultCompletions:
      type: 'boolean'
      default: true
      description: 'Disable this to use only custom completions.'
      order: 2
    selector:
      type: 'string'
      default: '.source, .text'
      description: 'Enable completions under these scopes:'
      order: 3
    disableForSelector:
      type: 'string'
      default: '.tex, .latex'
      description: 'Disable completions under these scopes:'
      order: 4
    boostGreekCharacters:
      type: 'boolean'
      default: true
      description: 'Make common greek characters easier to complete by moving them higher in the list of completions.'

  activate: ->
    atom.config.get("latex-completions.enableDefaultCompletions") && provider.load()

    provider.activate()

    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.config.observe 'latex-completions.customAliases', (path) =>
      for path in path.split(',')
        provider.load(path)

  provide: -> provider

  deactivate: ->
    @subscriptions.dispose()
    provider.deactivate()
