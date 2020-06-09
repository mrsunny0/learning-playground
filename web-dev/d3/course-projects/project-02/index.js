// DOM elements
const btns = document.querySelectorAll("button")
const form = document.querySelector("form")
const formAct = document.querySelector("form span")
const input = document.querySelector("input")
const error = document.querySelector(".error")

var activity = "cycling"

btns.forEach(btn => {
    btn.addEventListener("click", e => {
        // get activity
        activity = e.target.dataset.activity // from data-activity attribute

        // remove and add active class
        btns.forEach(btn => { btn.classList.remove("active") })
        e.target.classList.add("active")

        // reset input field id
        input.setAttribute("id", activity)

        // set text of form span
        formAct.textContent = activity

    })
})

// form submit
form.addEventListener("submit", e => {
    e.preventDefault()

    const distance = parseInt(input.value)
    if (distance) {
        db.collection("activity").add({
            distance: distance, // or in ES6, use distance as is
            activity: activity,
            date: new Date().toString()
        }).then(() => {
            // reset values
            error.textContent = ""
            input.value = ""
        })
    } else {
        error.textContent = "Please enter a valid distance"
    }
})