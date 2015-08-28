_ = require 'prelude-ls'

xTop  = 75
yTop  = 50
numXs = Math.random! * xTop

# Generates a set of data
dataSet = ->
    xs = [0 til numXs]
    for x in xs
        ys = [0 til Math.random! * yTop]
        for y in ys
            {x, y}

data = _.concat dataSet!

console.log data

target = d3
    .select \#target
    .append \svg
    .attr {
        height: 500
        width: 500
    }

xscale = d3.scale.linear!
    .domain [0, numXs]
    .range [5, 455]

yscale = d3.scale.linear!
    .domain [0, yTop]
    .range [455, 5]

# Update
dots = target.selectAll \circle
    .data _.concat data

# Enter
dots.enter!.append \circle
    .attr {
        cx: (d) -> xscale d.x
        cy: (d) -> yscale d.y
        r : 3
    }

# Exit
dots.exit!.remove!

# onClick
dots.on \click, (d) ->
    console.log d

# onMouseFocus
dots.on \mouseover, (d) ->
    d3.select(this).style { fill: \red }

# onMouseUnFocus
dots.on \mouseout, (d) ->
    d3.select(this).style { fill: \black }
