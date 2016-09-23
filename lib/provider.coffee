fs = require 'fs'
path = require 'path'

module.exports =
  filterSuggestions: true
  suggestionPriority: 5
  inclusionPriority: 5

  textEditorSelectors: 'atom-text-editor'
  getTextEditorSelector: -> @textEditorSelectors

  completions: {}

  texPattern: /\\([\w\d^-]*)$/

  load: (p) ->
    @scopeSelector = atom.config.get("latex-completions.selector")
    @disableForScopeSelector = atom.config.get("latex-completions.disableForSelector")
    return if p == ''
    p ?= path.resolve(__dirname, '..', 'completions', 'completions.json')
    fs.readFile p, (error, content) =>
      return if error?
      for name, char of JSON.parse(content)
        @completions[name] = char

  getSuggestions: ({bufferPosition, editor}) ->
    line = editor.getTextInRange([[bufferPosition.row, 0], bufferPosition])
    prefix = line.match(@texPattern)?[1]
    prefix? && ({text: word, leftLabel: char, replacementPrefix: prefix} for word, char of @completions)

  onDidInsertSuggestion: ({editor, triggerPosition, suggestion}) ->
    word = suggestion.text
    editor.selectLeft(word.length + 1)
    editor.insertText(@completions[word])
