{CompositeDisposable} = require 'atom'
provider = require './provider'

module.exports =
  config:
    enableDefaultCompletions:
      type: 'boolean'
      default: true
      description: 'Disable this to use only custom completions.'
    customAliases:
      type: 'string'
      default: ''
      description: 'Path to a custom set of completions. Multiple paths may be comma-seperated.'
    selector:
      type: 'string'
      default: '.source, .text'
      description: 'Enable completions under these scopes:'

  activate: ->
    atom.config.get("latex-completions.enableDefaultCompletions") && provider.load()

    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.config.observe 'latex-completions.customAliases', (path) =>
      for path in path.split(',')
        provider.load(path)

  provide: -> provider

  deactivate: ->
    @subscriptions.dispose()
