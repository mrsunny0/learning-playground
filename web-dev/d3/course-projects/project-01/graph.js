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
    .value(d => d.cost) // slice up array, and return start and end radian 

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
 * D3 update logic
 */
const update = (data) => {

    // update color scale domain
    color.domain(data.map(d => d.name))
    
    // join pie data to path elements from generator
    const paths = graph.selectAll("path")
        .data(pie(data))

    paths.enter()
        .append("path")
            .attr("class", "arc")
            .attr("d", arcPath) // d is for the path object, starts with "MXX,L11,E00"
            .attr("stroke", "#fff")
            .attr("stroke-width", 3)
            .attr("fill", d => color(d.data.name)) // warning, the data from pie generated is subbed in data field 
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