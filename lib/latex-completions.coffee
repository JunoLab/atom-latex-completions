
{CompositeDisposable} = require 'atom'
provider = require './provider'

module.exports =
  config:
    customAliases:
      type: 'string'
      default: ''
      description: 'Path to a custom set of completions.'
    selector:
      type: 'string'
      default: '.source, .text'
      description: 'Enable completions under these scopes:'

  activate: ->
    provider.load()

    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.config.observe 'latex-completions.selector', (selector) =>
      provider.selector = selector

    @subscriptions.add atom.config.observe 'latex-completions.customAliases', (path) =>
      provider.load(path)

  provide: -> provider

  deactivate: ->
    @subscriptions.dispose()
