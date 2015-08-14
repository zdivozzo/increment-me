{CompositeDisposable} = require 'atom'

module.exports =
 subscriptions: null

 activate: ->
   @subscriptions = new CompositeDisposable
   @subscriptions.add atom.commands.add 'atom-workspace',
    'increment-me:increment': => @convert()

 deactivate: ->
    @subscriptions.dispose()

 convert: ->

    editor = atom.workspace.getActiveTextEditor()
    selections = editor.getSelections()
    seedNumber = 1

    selections.forEach (selection, index) ->

      selectionText = selection.getText()
      selectionArray = selectionText.split('').reverse()
      selectionNumbers = []

      i = 0
      while i < selectionArray.length
        if isNaN(selectionArray[i])
          break
        else
          selectionNumbers.push(selectionArray[i])
        i++

      selectionNumbers = selectionNumbers.reverse().join('')
      if selectionNumbers
        selectionText = selectionText.slice(0,(selectionNumbers.length)*-1)

      if selectionNumbers && index == 0
        seedNumber = selectionNumbers

      selection.insertText(selectionText + seedNumber)
      seedNumber++
