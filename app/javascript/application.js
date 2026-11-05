// Entry point for the build script in your package.json (bundled by esbuild).

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "./channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()



// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import { makeNavbarItemActiveOnClick } from './components/navbar';
import { makePatternCardClickable } from './components/make_pattern_card_clickable';
import { selectActiveFilter } from './components/search_bar';
import { fitProjectPhotoDependingOnImageRatio } from './components/fit_project_photo_depending_on_image_ratio';
import { styleUploadPhotoInputField } from './components/style_upload_photo_input_field';
import { getPhotoUrlforPattern } from './components/get_photo_url_for_pattern';
import { thumbnailOverlayForDelete } from './components/thumbnail-overlay-for-delete';
import { addFlipCardClassesForGarmentCategoryIcon } from './components/flip_card_garment_category_icon';
import { deleteFabricInputOnDelete } from './components/delete_fabric_input_on_delete';
// Internal imports, e.g:
// import { initSelect2 } from './components/init_select2';

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
