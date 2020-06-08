/**
 * Dimension setup
 */
const dims = { height: 300, width: 300, radius: 150 }
const cent = { x: (dims.width / 2 + 5), y: (dims.height / 2 + 5)}
const padding = 150

const svg = d3.select(".canvas")
    .append("svg")
    .attr("width", dims.width + padding)
    .attr("height", dims.height + padding)

const graph = svg.append("g")
    .attr("transform", `translate(${cent.x},${cent.y})`)

/**
 * Pie generator
 */
 const pie = d3.pie()
    .sort(null) // prevent sorting based on the angle
    .value(d => d.cost) // slice up array, and return start and end radian angles

/**
 * Arc generator
 */
const arcPath = d3.arc()
    .outerRadius(dims.radius)
    .innerRadius(dims.radius / 2)

/**
 * Ordinal scale 
 */
const color = d3.scaleOrdinal(d3["schemeSet3"]) // output range color scheme

/**
 * Legend setup 
 */
const legendGroup = svg.append("g")
    .attr("transform", `translate(${dims.width + 40}, 10)`)

const legend = d3.legendColor()
    .shape("circle")
    .shapePadding(10)
    .scale(color) // same color scale as pie chart

/**
 * D3 update logic
 */
const update = (data) => {

    // update color scale domain
    color.domain(data.map(d => d.name))

    // update call legend
    legendGroup.call(legend)
    legendGroup.selectAll("text").attr("fill", "white")
    
    // join pie data to path elements from generator
    const paths = graph.selectAll("path")
        .data(pie(data))

    // remove
    paths.exit()
        .transition().duration(750)
        .attrTween("d", arcTweenExit)
        .remove()

    // update
    paths.attr("d", arcPath) // update remaining paths due to removal
        .transition().duration(750)
        .attrTween("d", arcTweenUpdate)

    // enter
    paths.enter()
        .append("path")
            .attr("class", "arc")
            // .merge(paths) // IMPORTANT: combine with previous data (already entered in previous call)
            // .attr("d", arcPath) // d is for the path object, starts with "MXX,L11,E00"
            // transition takes care of writing out the d
            .attr("stroke", "#fff")
            .attr("stroke-width", 3)
            .attr("fill", d => color(d.data.name)) // warning, the data from pie generated is subbed in data field 
            
            
            .each(function(d) { // perform a function on each one, want to use this
                this._current = d // force a data collection on current data, used for update
            }) 
            
            .transition().duration(750)
                .attrTween("d", arcTweenEnter)
}

/**
 * Firestore data logic
 */
var data = []

db.collection("expenses").onSnapshot(res => {

    res.docChanges().forEach(change => {

        // create document from db
        const doc = {...change.doc.data(), id: change.doc.id}

        // logic to handle data updates
        switch (change.type) {
            case "added":
                data.push(doc)
                break
            case "modified":
                const index = data.findIndex(item => item.id == doc.id)
                data[index] = doc
                break
            case "removed":
                data = data.filter(item => item.id !== doc.id)
                break
            default:
                break
        }

    })

    // update graph
    update(data)

})

/**
 * Tween
 */
const arcTweenEnter = (d) => {
    var i = d3.interpolate(d.endAngle, d.startAngle)

    // required callback for tween
    return function(t) {
        d.startAngle = i(t) // increment during transition
        return arcPath(d)
    }
}

const arcTweenExit = (d) => {
    var i = d3.interpolate(d.startAngle, d.endAngle)

    // required callback for tween
    return function(t) {
        d.startAngle = i(t) // increment during transition
        return arcPath(d)
    }
}

// require function keyword for this
// important, hack to store previous data using a new field created in the enter call
// remember to update this previous data even during the update method
function arcTweenUpdate(d) {
    var i = d3.interpolate(this._current, d) // interpolate the entire object, d3 will figure it out if it shrinks or grows
    this._current = i(1) // or use d itself

    return function(t) {
        return arcPath(i(t))
    }
} 