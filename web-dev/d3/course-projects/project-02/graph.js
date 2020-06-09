/**
 * Graph dimensions
 */
const margin = {top: 40, right: 20, bottom: 50, left: 100}
const graphWidth = 560 - margin.left - margin.right
const graphHeight = 400 - margin.top - margin.bottom

const svg = d3.select(".canvas")
    .append("svg")
    .attr("width", graphWidth + margin.left + margin.right)
    .attr("height", graphHeight + margin.top + margin.bottom)

const graph = svg.append("g")
    .attr("width", graphWidth)
    .attr("height", graphHeight)
    .attr("transform", `translate(${margin.left},${margin.top})`)

/**
 * Scales & axis
 */
const x = d3.scaleTime().range([0, graphWidth])
const y = d3.scaleLinear().range([graphHeight, 0]) // backwards because of html canvas dimensions

const xAxisGroup = graph.append("g")
    .attr("class", "x-axis")
    .attr("transform", `translate(0, ${graphHeight})`)
const yAxisGroup = graph.append("g")
    .attr("class", "y-axis")

/**
 * Line path generator
 */
const line = d3.line()
    .x(function(d) { return x(new Date(d.date)) })
    .y(function(d) { return y(d.distance) })

// initialize line path element
const path = graph.append("path")

const xpath = graph.append("path")
    .attr("class", "xpath")

const ypath = graph.append("path")
    .attr("class", "ypath")

/**
 * Update function
 */
const update = (data) => {

    // filter data based on front-end activity
    data = data.filter(item => { return item.activity == activity })

    // sort data based on date object
    data.sort( (a, b) => new Date(a.date) - new Date(b.date))

    // set up domains
    x.domain(d3.extent(data, d => new Date(d.date))) // time series, get min and max from given dates
    y.domain([0, d3.max(data, d => d.distance)]) // fixed min at 0

    // update path data
    path.data([data]) // important, line needs to be an array of array data
        .attr("fill", "none")
        .attr("stroke", "#00bfa5")
        .attr("stroke-width", 2)
        .attr("d", d => line(d))

    // select circles
    const circles = graph.selectAll("circle")
        .data(data)

    // remove 
    circles.exit().remove()

    // update existing circles (do not need to change existing attributes)
    circles
        .attr("cx", d => x(new Date(d.date)))
        .attr("cy", d => y(d.distance))

    // create new data
    circles.enter()
        .append("circle")
            .attr("r", 4)
            .attr("cx", d => x(new Date(d.date)))
            .attr("cy", d => y(d.distance))
            .attr("fill", "#ccc")

    // add interactivity
    graph.selectAll("circle")
        .on("mouseover", (d, i, n) => {
            d3.select(n[i])
                .transition().duration(250)
                .attr("r", 10)
                .attr("fill", "#fff")

            const xorigin = {
                date: data[0].date,
                distance: d.distance
            } 
            const yorigin = {
                date: d.date,
                distance: 0
            }

            xpath.data([[xorigin, d]])
                .attr("fill", "none")
                .attr("stroke", "#fff")
                .attr("stroke-width", 1)
                .attr("d", d => line(d))
                .style("stroke-dasharray", ("3, 3"))

            ypath.data([[yorigin, d]])
                .attr("fill", "none")
                .attr("stroke", "#fff")
                .attr("stroke-width", 1)
                .attr("d", d => line(d))
                .style("stroke-dasharray", ("3, 3"))

        })
        .on("mouseout", (d, i, n) => {
            d3.select(n[i])
                .transition().duration(250)
                .attr("r", 4)
                .attr("fill", "#ccc")

            xpath.data([]).exit().remove()
            ypath.data([]).exit().remove()
        })
        
    // call axis
    const xAxis = d3.axisBottom(x)
        .ticks(4)
        // .tickFormat(d3.timeFormat("%b %m")) // built in date from d3
        .tickFormat(d3.timeFormat("%I:%M")) // refer to: https://github.com/d3/d3-time-format
    const yAxis = d3.axisLeft(y)
        .ticks(4)
        .tickFormat(d => d + " m")
    xAxisGroup.call(xAxis)
    yAxisGroup.call(yAxis)

    // annotations
    xAxisGroup.selectAll("text")
        .attr("transform", "rotate(-40)")
        .attr("text-anchor", "end")
}

/**
 * Data and firestore
 */
var data = []

db.collection("activity").onSnapshot(res => {
    // get all documents
    res.docChanges().forEach(change => {

        // create data from chnaged snapshot
        const doc = {...change.doc.data(), id: change.doc.id}

        // test which one was updated
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

    update(data)
})