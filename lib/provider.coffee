fs = require 'fs'
path = require 'path'

texPattern = /\\[\w]*$/

module.exports =
  selector: '.source, .text'
  filterSuggestions: true
  inclusionPriority: 5

  completions: {}

  load: (p) ->
    return if p == ''
    p ?= path.resolve(__dirname, '..', 'completions', 'completions.json')
    fs.readFile p, (error, content) =>
      return if error?
      for name, char of JSON.parse(content)
        @completions[name] = char

  getSuggestions: ({bufferPosition, editor}) ->
    line = editor.getTextInRange([[bufferPosition.row, 0], bufferPosition])
    prefix = line.match(texPattern)?[0]
    prefix? && ({text: word, leftLabel: char} for word, char of @completions)

  onDidInsertSuggestion: ({editor, triggerPosition, suggestion}) ->
    word = suggestion.text
    editor.selectLeft(word.length + 1)
    editor.insertText(@completions[word])
