const svg = d3.select(".canvas").append("svg")
    .attr("height", 600)
    .attr("width", 600)

/******************************
 * Dimensions
 ******************************/
const margin = {
    top: 20,
    right: 20,
    bottom: 100,
    left: 100
}

const graphWidth = 600 - margin.left - margin.right
const graphHeight = 600 - margin.top - margin.bottom

const graph = svg.append("g")
    .attr("width", graphWidth)
    .attr("height", graphWidth)
    .attr("transform" ,`translate(${margin.left}, ${margin.top})`)

/******************************
 * Axis
 ******************************/
const xAxisGroup = graph.append("g")
    .attr("transform", `translate(0, ${graphHeight})`)
const yAxisGroup = graph.append("g")

const x = d3.scaleBand()
    .range([0, 500])
    .paddingInner(0.2)
    .paddingOuter(0.2)

const y = d3.scaleLinear()
    .range([graphHeight, 0])

const xAxis = d3.axisBottom(x)
const yAxis = d3.axisLeft(y)
    .ticks(3)
    .tickFormat(d => d + " orders")    

xAxisGroup.selectAll("text")
    .attr("transform", "rotate(-40)")
    .attr("text-anchor", "end")        

/*******************************
 * Update
 *******************************/
const update = (data) => {
    // 1. update scales
    x.domain(data.map(d => d.name))
    y.domain([0, d3.max(data, d => d.orders)])

    // 2. join updated data to elements
    const rects = graph.selectAll("rect").data(data)

    // 3. remove any unwanted shapes (if there are too many)
    rects.exit().remove()

    // 4. update current shapes in the dom
    rects.attr("x", d => x(d.name))
        .attr("y", d => y(d.orders))
        .attr("width", x.bandwidth)
        .attr("height", d => graphHeight - y(d.orders))

    // 5. append the enter selection to the dom
    rects.enter().append("rect")
        .attr("x", d => x(d.name))
        .attr("y", d => y(d.orders))
        .attr("width", x.bandwidth)
        .attr("height", d => graphHeight - y(d.orders))

    // 6. customization
    xAxisGroup.call(xAxis)
    yAxisGroup.call(yAxis)
}

/*******************************
 * Plot
 *******************************/
db.collection("dishes").get().then(res => {
    // get data
    var data = res.docs.map(d => {
        return d.data()
    })

    // update data
    update(data)
})