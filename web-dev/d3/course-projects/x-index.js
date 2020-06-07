const svg = d3.select("svg")
var data;

d3.json("./planet.json").then(data => {
    
    const circles = svg.selectAll("circle")
        .data(data)
        .enter()
        .append("circle")
        .attr("r", d => d.radius)
        .attr("cx", d => d.distance)
        .attr("cy", 200)
        .attr("fill", d => d.fill)

})

// const data = [
//     {width: 200, height: 500, fill: "purple"},
//     {width: 400, height: 600, fill: "purple"},
//     {width: 1000, height: 700, fill: "purple"}
// ]

// const svg = d3.select("svg")

// svg.selectAll("rect")
//     .data(data)
//     .enter()
//     .append("rect")
//     .attr("width", (d, i, n) => {
//         console.log(n[i])
//         return d.width
//     })
//     .attr("height", (d) => {return d.height})
//     .attr("fill", (d) => {return d.fill})
//     .attr("opacity", 0.2)
//     .on("click", function() {
//         this.style("fill", "red")
//         console.log(this)
//     })