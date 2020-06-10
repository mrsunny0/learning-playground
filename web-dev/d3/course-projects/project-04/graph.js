/**
 * Dimensions
 */
const dims = { height: 500, width: 1100 }
const svg = d3.select(".canvas")
    .append("svg")
    .attr("width", dims.width + 50 * 2)
    .attr("height", dims.height + 50 * 2)

const graph = svg.append("g")
    .attr("transform", `translate(50, 50)`)

/**
 * Stratify data
 */
const stratify = d3.stratify()
    .id(d => d.name)
    .parentId(d => d.parent)

// convert stratified data into a tree map which can be used in DOM
// similar to the pack function
const tree = d3.tree()
    .size([dims.width, dims.height])

/**
 * Update function
 */
const update = (data) => {

    // transform data
    const rootNode = stratify(data) 

    // transform data into DOM usable elements
    const treeData = tree(rootNode) 

    // need to convert to array format with x/y fields    
    const nodes = graph.selectAll(".node")
        .data(treeData.descendants()) 

    // get links and join data
    const links = graph.selectAll(".link")
        .data(treeData.links()) 

    // enter new links
    links.enter()
        .append("path")
        .attr("class", "link")
        .attr("fill", "none")
        .attr("stroke", "#aaa")
        .attr("stroke-width", 2)
        .attr("d", d3.linkVertical() // data to create the path
            .x(d => d.x)
            .y(d => d.y)
        )

    const enterNodes = nodes.enter()
        .append("g")
            .attr("class", "node")
            .attr("transform", d => `translate(${d.x}, ${d.y})`)

    // append graphics onto nodes
    enterNodes.append("rect")
        .attr("fill", "#aaa")
        .attr("stroke", "#555")
        .attr("stroke-wdith", 2)
        .attr("height", 50)
        .attr("width", d => d.data.name.length * 20)

    // append name text
    enterNodes.append("text")
        .attr("text-anchor", "middle")
        .attr("fill", "#fff")
        .text(d => d.data.name)


}

/**
 * Firebase listener
 */
data = []

db.collection("employees").onSnapshot( res => {
    res.docChanges().forEach(change => {

        // get the document from the change
        const doc = {...change.doc.data(), id: change.doc.id}

        // monitor which type of change
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

