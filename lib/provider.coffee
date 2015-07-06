texPattern = /\\[\w]*$/

completions =
  alpha: 'α'
  beta: 'β'

module.exports =
  selector: '.source.coffee, .source.js'
  filterSuggestions: true
  inclusionPriority: 6
  # excludeLowerPriority: true

  getSuggestions: ({bufferPosition, editor}) ->
    line = editor.getTextInRange([[bufferPosition.row, 0], bufferPosition])
    prefix = line.match(texPattern)?[0]
    if prefix?
      [{text: 'alpha'}, {text: 'beta'}]
    else
      []

  onDidInsertSuggestion: ({editor, triggerPosition, suggestion}) ->
    word = suggestion.text
    editor.selectLeft(word.length + 1)
    editor.insertText(completions[word])
