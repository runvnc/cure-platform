meta:
  proto:
    isType: false
    name: ''
    default:
    value: ''
    type: ''
    childrenType: ''
    children: []
    properties: {}
    propertyOrder: []
    values: {}

  #property type is proto
  #unless otherwise specified

  attribute:
    isType: true
    name: 'attribute'
    properties:
      name:
        type: 'String'
      value:
        type: 'string'
    

  htmlAttributes:
    isType: true
    type: 'proto'
    name: 'htmlAttributes'
    childrenType: 'attribute'

  map:
    isType: true
    type: 'proto'
    properties:
      onType:
        default: true
        type: 'Boolean'
      from:
        type: 'proto'
      to:
        type: 'proto'

  serial:
    isType: true
    name: 'serial'
    type: 'map'
    properties:
      outList:
        type: 'Array'
           

  htmlAttributeSerial:
    isType: false
    type: 'serial'
    
    values:
      from: 'html'
      to: 'taggedMarkup'
      outList: [ 'name', '=', 'value' ]

  htmlTagSerial:
    isType: false
    type: 'serial'
    values:
      from: 'htmlTag'
      to: 'taggedMarkup'
      outList: [ '<', 'name', 'attributes', '>' ]

          
  html:
    isType: true
    name: 'html'
    type: 'HTMLTag'
    properties:
      htmlTagName:
        default: 'html'
    children: [
      head:
        isType: false
        type: 'HTMLTag'
        values:
          htmlTagName: 'head'
      body:
        isType: false
        type: 'HTMLTag'
        values:
          htmlTagName: 'body'
    ]
 
  docType:
    isType: false
    name: 'docType'
    type: 'html'
    values:
      htmlTagName:
        default: '!DOCTYPE'

  
  script:
    isType: true
    name: 'script'
    type: 'htmlTag'
    properties:
      htmlTagName:
        default: 'script'
      attributes:
         default: [
           name: 'type'
           value: 'text/javascript'
         ]
              
  jQuery:
    isType: false
    name: 'jQuery'
    type: 'script'
    values:
      contents:
        attributes:  [
          name: 'src'
          value: 'js/jQuery.min.js'
        ]
 
  mapList:
    type: 'proto'
    childrenType: 'map'
   
  generator:
    type: 'proto'
    properties:
      from:
        type: 'proto'
      mapsTo:
        type: 'mapList'
     

  generatorList:
    type: 'proto'
    childrenType: 'generator'

  operator:

  conditional:
    type: 'proto'
    properties:
      expr1:
        type: 'expresson'
      expr2:
        type: 'expression'
      comparison:
        type: 'operator'
        default: '='
  
 
  conditionalInsertion:
    type: 'conditional'
    

  dependency:
    type: 'conditionalInsertion'
    properties:
      

  requiresList:
    type: 'proto'
    childrenType: 'dependency'

  

  component:
    name: 'component'
    properties:
      requires:
        type: 'requiresList'
      generators:
        type: 'generatorList'
      
          


#metalevel
#is basically a slot
#might be screen (html)
#or program (for logic)


#defines 
     
#programs as data

#this is key
#everything is data


 
class Tag extends Slot
  @constructor (start, contents, end) ->
    @list = [
    @start = start
    @contents = contents
    @end = end

item = new Slot
  [
    'start',
    'contents',
    'end'
  ]

tag = new Slot
  is:
    'item'
    start: ''

html = new Slot
  html: [
    'head'
    body:
      is: 'item'
      start:
      contents:
      end:
  ]


#A box that you can drag around on the screen
#and that can be dropped inside of other boxes
#and then when generate is called
#outputs a serialized representation of itself
#and whatever is inside
#assume box just has a name and children

class Component
  constructor: (@name) ->

  out: (slot) ->
    #go to that slot
    #output the value

class head extends item


class link
  constructor: ->
    out:
      head:
        start:

        contents:

        end:

class jQuery
  constructor: ->
    out:
      link:
             

class WebNamedContainer
  constructor: (@text) ->
    requires: 'jquery'
    @out =
        
