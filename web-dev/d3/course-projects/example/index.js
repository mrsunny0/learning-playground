const svg = d3.select(".canvas")
    .append("svg")
    .attr("width", 600)
    .attr("height", 600)

// create margins and dimensions
const margin = {
    top: 20, 
    right: 20,
    bottom: 100, // room for axis
    left: 100 // room for axis
}

// create dimensions of the graph using the margin information
const graphWidth = 600 - margin.left - margin.right
const graphHeight = 600 - margin.top - margin.bottom

const graph = svg.append("g")
    .attr("width", graphWidth)
    .attr("height", graphHeight)
    .attr("transform", `translate(${margin.left}, ${margin.top})`)
    .style("background-color", "red")

// generate axis group
const xAxisGroup = graph.append("g")
    .attr("transform", `translate(0, ${graphHeight})`) // need to shift down axis to bottom
const yAxisGroup = graph.append("g")

d3.json("./menu.json").then(data => {

    const min = d3.min(data, d => d.orders)
    const max = d3.max(data, d => d.orders)
    const extent = d3.extent(data, d => d.orders)

    // scale
    const y = d3.scaleLinear() 
        .domain([0, max])
        .range([graphHeight, 0])

    const x = d3.scaleBand()
        .domain(data.map(d => {
            return d.name
        }))
        .range([0, 300])
        .paddingInner(0.2)
        .paddingOuter(0.2)

    graph.selectAll("rect")
        .data(data)
        .enter()
        .append("rect")
        .attr("x", (d, i) => x(d.name))
        .attr("width", x.bandwidth)
        .attr("y", d => y(d.orders))
        .attr("height", d => graphHeight - y(d.orders))

    // create axis
    const xAxis = d3.axisBottom(x)
    const yAxis = d3.axisLeft(y)
        .ticks(3)
        .tickFormat(d => d + " orders")

    xAxisGroup.call(xAxis)
    yAxisGroup.call(yAxis)

    xAxisGroup.selectAll("text")
        .attr("transform", `rotate(-40)`)
        .attr("text-anchor", "end")
        .attr("fill", "orange")

})