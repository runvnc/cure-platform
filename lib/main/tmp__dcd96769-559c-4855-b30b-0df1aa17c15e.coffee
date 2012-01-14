
#startexports
boolean = (name) ->
  type: 'boolean'
  name: name

textfield = (name) ->
  type: 'text'
  name: name


todo =
  version_: 1
  name_: 'todo'
  done: boolean 'done'
  description: textfield 'description'
  archived: boolean 'archived'

  
gen = require '../generators'
{ replacedeferred_funcs,replacedeferred,deferred,defer_funcs,defer,mustinclude_funcs,mustinclude,outfile,newfile_funcs,newfile,currgen,text_funcs,text,expressapp_funcs,expressapp,addpermission_funcs,addpermission,doctype_funcs,doctype,html_funcs,html,head_funcs,head,body_funcs,body,input_funcs,input,button_funcs,button,h1_funcs,h1,p_funcs,p,title_funcs,title,script_funcs,script,headitems,htmlhead_funcs,htmlhead,htmlpage_funcs,htmlpage,jquery_funcs,jquery,entryfields,inputentry_funcs,inputentry,entryfield_funcs,entryfield,entrybutton_funcs,entrybutton,savefields,savefield_funcs,savefield} = gen.functions
gen = require './generators'

shown = ->
  and: [
    archived: false
    done: false
  ]

exports.run = ->
  expressapp ->
    addpermission 'guests', 'todo', 'all'
    htmlpage 'todo', ->
      entryfield todo.description
      entrybutton todo, 'add'
      #linebreak
      #count todo, shown
      #text ' remaining'
      #actionbutton ->
      #  update todo, { done: true },
      #    archived: true
      #linebreak
      #list todo,
      #  criteria: shown
      #  template: ->
      #    entryfield todo.done
      #    showfield todo.description

    htmlpage 'about', ->
      h1 'About'
      p 'Hello, this is about..'
 
 
