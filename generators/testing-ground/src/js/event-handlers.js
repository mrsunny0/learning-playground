// find containers and buttons
const container_grid = document.getElementById('container-grid');
const container_list = document.getElementById('container-list');
const display_toggle = document.getElementById("display-toggle");
const display_toggle_checkbox = document.getElementById("display-toggle-checkbox");
const navigation = document.getElementById('navigation');

/***********************
 * toggle display types
 ***********************/
// get header down arrow 
var header_arrow = document.getElementById("section-header").querySelector(".header__scrolldown-link")

// get nav wrapper
var a_list = document.getElementsByTagName('nav')[0]
    .querySelectorAll('a');

// get list of popups 
var popup_containers = document.getElementsByClassName("popup");

// get original hrefs of each a element. Note the use of a gloablly agreed extension
const EXTENSION="-overlay"
function addStripExtension(href, bool) {
    if (bool) {
        return href + EXTENSION
    } else {
        return href.split(EXTENSION)[0]
    }
}

// create a function to change header down arrow href
function change_header_arrow_href(bool) {
    var href = header_arrow.getAttribute("href");
    header_arrow.setAttribute("href", addStripExtension(href, bool))
}

// create function to toggle between original and overlay hrefs
// this means changing the href from the navigation to the 
// new -overlay hrefs or vice-versa
function change_hrefs(bool) {
    for (const a of a_list) {
        var href = a.getAttribute("href");
        a.setAttribute('href', addStripExtension(href, bool))
    }
}

// change href of popup containers
// HACK, swap the IDs so they actually go nowhere. This is the desired result
// where exiting from the popup container stays where the user is located,
// not the actual heading
function change_popup_close_href(bool) {
    for (let p of popup_containers) {
        var ahref = p.querySelector(".popup__close")
        var href = ahref.getAttribute("href")
        ahref.setAttribute("href", addStripExtension(href, !bool))
    }
}

// function to control visibility and display of the container
// block when toggled
function toggle_display(bool) {
    // if checked to list view
    if (bool) {
        container_grid.style.display = "none"
        container_list.style.display = "block"
        container_grid.style.visibility = "hidden"
        container_list.style.visibility = "visible"
    } 
    // default (unchecked) is grid view
    else {
        container_grid.style.display = "block"
        container_list.style.display = "none"
        container_grid.style.visibility = "visible"
        container_list.style.visibility = "hidden"
    }

    // change ref links
    change_hrefs(bool)
    change_header_arrow_href(bool)
    change_popup_close_href(bool)
}

// add event handler to checkbox
display_toggle_checkbox.addEventListener("change", function() {
    toggle_display(this.checked)
})

// initial state
container_list.style.display = 'none'
change_popup_close_href(false) // invert popup href so they go nowhere

/***********************
 * toggle scroll hide
 ***********************/
// change to fixed position once scrolled into
window.addEventListener('scroll', () => {
    // innerHeight is 100vh in javascript html viewport meta
    // grid and link button on/off using opacity changes
    if (window.pageYOffset >= window.innerHeight * .15) {
        display_toggle.style.opacity = 1
    } else {
        display_toggle.style.opacity = 0
    }

    // do the same for the navigation button
    if (window.pageYOffset >= window.innerHeight * 0.5) {
        navigation.style.opacity = 1
    } else {
        navigation.style.opacity = 0
    }
})

// initial states
display_toggle.style.opacity = 0
navigation.style.opacity = 0

/***********************
 * toggle scroll hide
 ***********************/
const navigation_checkbox = document.getElementById("navi-toggle");
const navigation_navcontainer = navigation.querySelector(".navigation__nav");
const navigation_navlist = navigation.querySelector(".navigation__list");
const navigation_navitem = navigation.querySelector(".navigation__item");

[navigation_navcontainer, navigation_navlist, navigation_navitem].forEach(function(e) {
    e.addEventListener("click", function(event) {
        // check to see if this is actually the target
        // rather than a child click on li a links
        if (this == event.target) {
            navigation_checkbox.checked = false;
        }
    })
})

