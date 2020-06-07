const svg = d3.select(".canvas").append("svg")
    .attr("height", 600)
    .attr("width", 600)

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

const xAxisGroup = graph.append("g")
    .attr("transform", `translate(0, ${graphHeight})`)
const yAxisGroup = graph.append("g")

db.collection("dishes").get().then(res => {
    // get data
    var data = res.docs.map(d => {
        return d.data()
    })

    // create domain range
    const x = d3.scaleBand()
        .domain(data.map(d => d.name))
        .range([0, 300])
        .paddingInner(0.2)
        .paddingOuter(0.2)
    const y = d3.scaleLinear()
        .domain([0, d3.max(data, d => d.orders)])
        .range([graphHeight, 0])

    // bind data
    graph.selectAll("rect")
        .data(data)
        .enter()
        .append("rect")
        .attr("x", d => x(d.name))
        .attr("y", d => y(d.orders))
        .attr("width", x.bandwidth)
        .attr("height", d => graphHeight - y(d.orders))

    // create axis
    const xAxis = d3.axisBottom(x)
    const yAxis = d3.axisLeft(y)
        .ticks(3)
        .tickFormat(d => d + " orders")
    xAxisGroup.call(xAxis)
    yAxisGroup.call(yAxis)

    // customize
    xAxisGroup.selectAll("text")
        .attr("transform", "rotate(-40)")
        .attr("text-anchor", "end")    
})