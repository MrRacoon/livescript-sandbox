_ = require 'prelude-ls'

# const pgWidth  = 500
# const pgHeight = 500
# 
# const numX     = 20
# const numY     = 20
# 
# const xNum     = Math.round Math.random! * numX
# const yNum     = Math.round Math.random! * numY
# 
# console.log xNum
# 
# const cCirc    = (pgWidth / xNum)
# const cSize    = cCirc / 2
# 
# const padding  = cCirc
# const pad      = cSize
# 
# # Generates a set of data
# dataSet = ->
#     xs = [0 til numX]
#     for x in xs
#         ys = [0 til Math.random! * numY]
#         for y in ys
#             {x, y}
# 
# data = _.concat dataSet!
# 
# nes = d3.nest!
#     .key (d) -> d.x
#     .key (d) -> d.y
#     .entries data
# 
# console.log nes
# 
# console.log data
# 
# xscale = d3.scale.linear!
#     .domain [0, xNum]
#     .range [5, 455]
# 
# yscale = d3.scale.linear!
#     .domain [0, yNum]
#     .range [455, 5]
# 
# # Locate the entry point and add an svg element to it
# target = d3
#     .select \#target
#     .append \svg
#     .attr {
#         height: pgHeight + \px
#         width:  pgWidth  + \px
#     }


# # Update
# dots = target.selectAll \circle
#     .data _.concat data
# 
# # Enter
# 
# dots.enter!.append \circle
#     .attr {
#         cx: (d) -> xscale d.x
#         cy: (d) -> yscale d.y
#         r : cSize
#     }
# 
# # Exit
# dots.exit!.remove!
# 
# # onClick
# dots.on \click, (d) ->
#     console.log d
# 
# # onMouseFocus
# dots.on \mouseover, (d) ->
#     d3.select(this).style { fill: \red }
# 
# # onMouseUnFocus
# dots.on \mouseout, (d) ->
#     d3.select(this).style { fill: \black }


const width  = 960
const height = 500

# Create an initial set of random vertice datum
vertices = d3.range 100
    .map ->[
        Math.random! * width
        Math.random! * height
        ]


svg = d3.select \body
    .append \svg
    .attr \width, width
    .attr \height, height
    .on \mousemove, ->
        mouse = d3.mouse this
        console.log 'moved : ', mouse
        vertices[0] = mouse
        redraw!
        undefined

# Create the selection of <path> elements using an svg <g>roups
path = svg.append \g .selectAll \path

# Create the dots that represent the vertices in the don using svg <circle>
svg.selectAll \circle
    .data vertices.slice 1
    .enter!
    .append \circle
    .attr \transform, (d) -> "translate(" + d + ")"
    .attr \r, 1.5

# Draw the polygon in <path> notation
polygon = (d) ->
    "M" + (d.join "L") + "Z"

voronoi = d3.geom.voronoi!.clipExtent [
    * 0
      0
    * width
      height
    ]

redraw = ->
    # On Update | Refresh the <path> data using the polygon function
    path := path.data voronoi(vertices), polygon
    # On Exit   | Remove from the DOM
    path.exit!.remove!
    # On Enter  | Create a <path> element
    path.enter!.append \path
        .attr \class, (d, i) -> "q" + (i % 9) + "-9"
        .attr \d, polygon

    path.order!




# Initiate the initial redraw....
redraw! # NOW !!!
#


