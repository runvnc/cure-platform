{boolean, text} = require '../base/types'
gen = require '../generators'

#startexports
exports.todo =
  done: boolean 'done'
  description: text 'description'
  archived: boolean 'archived'

#gen.addAll 'types', { todo:todo }

  
