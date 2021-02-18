// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

require("chartkick")
require("chart.js")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "controllers"
import "css/application.scss"

import 'alpinejs'

document.addEventListener("turbolinks:load", function () {
  const triggers = document.querySelectorAll('[data-dropdown-trigger]')

  for (const trigger of triggers) {
    trigger.addEventListener('click', function(e) {
      e.stopPropagation()
      e.currentTarget.nextElementSibling.classList.remove('hidden')
    })
  }

  if (triggers.length > 0) {
    document.addEventListener('click', function(e) {
      const dropdown = e.target.closest('[data-dropdown]')

      if (dropdown && e.target.tagName === 'A') {
        dropdown.classList.add('hidden')
      }
    })

    document.addEventListener('click', function(e) {
      const clickedInDropdown = e.target.closest('[data-dropdown]')

      if (!clickedInDropdown) {
        for (const dropdown of document.querySelectorAll('[data-dropdown]')) {
          dropdown.classList.add('hidden')
        }
      }
    })
  }
})