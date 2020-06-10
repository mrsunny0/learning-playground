/**
 * Initialize materialize modal
 */
const modal = document.querySelector(".modal")
M.Modal.init(modal)

/**
 * Form firebase submission
 */
const form = document.querySelector("form")
const name = document.querySelector("#name")
const parent = document.querySelector("#parent")
const department = document.querySelector("#department")

form.addEventListener("submit", e => {
    e.preventDefault()

    db.collection("employees").add({
        name: name.value,
        parent: parent.value,
        department: department.value
    })

    // hide modal, using materialize
    var instance = M.Modal.getInstance(modal)
    instance.close(modal)

    // reset form
    form.reset()
})