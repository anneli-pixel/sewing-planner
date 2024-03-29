// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import { makeNavbarItemActiveOnClick } from '../components/navbar';
import { makePatternCardClickable } from '../components/make_pattern_card_clickable';
import { selectActiveFilter } from '../components/search_bar';
import { fitProjectPhotoDependingOnImageRatio } from '../components/fit_project_photo_depending_on_image_ratio';
import { styleUploadPhotoInputField } from '../components/style_upload_photo_input_field';
import { getPhotoUrlforPattern } from '../components/get_photo_url_for_pattern';
import { thumbnailOverlayForDelete } from '../components/thumbnail-overlay-for-delete';
import { addFlipCardClassesForGarmentCategoryIcon } from '../components/flip_card_garment_category_icon';
import { deleteFabricInputOnDelete } from '../components/delete_fabric_input_on_delete';
// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
  makeNavbarItemActiveOnClick();
  makePatternCardClickable();
  selectActiveFilter();
  fitProjectPhotoDependingOnImageRatio();
  styleUploadPhotoInputField();
  getPhotoUrlforPattern();
  thumbnailOverlayForDelete();
  addFlipCardClassesForGarmentCategoryIcon();
  deleteFabricInputOnDelete();
});
