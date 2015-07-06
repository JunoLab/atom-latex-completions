fs = require 'fs'
path = require 'path'

texPattern = /\\[\w]*$/

module.exports =
  selector: '.source, .text'
  filterSuggestions: true
  inclusionPriority: 5

  completions: []

  load: ->
    fs.readFile path.resolve(__dirname, '..', 'completions', 'completions.json'), (error, content) =>
      return if error?
      @completions = JSON.parse(content)

  getSuggestions: ({bufferPosition, editor}) ->
    line = editor.getTextInRange([[bufferPosition.row, 0], bufferPosition])
    prefix = line.match(texPattern)?[0]
    prefix? && ({text: word} for word, char of @completions)

  onDidInsertSuggestion: ({editor, triggerPosition, suggestion}) ->
    word = suggestion.text
    console.log word
    editor.selectLeft(word.length + 1)
    editor.insertText(@completions[word])
