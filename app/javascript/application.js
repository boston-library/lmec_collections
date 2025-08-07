// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import * as bootstrap from "bootstrap"
import githubAutoCompleteElement from "@github/auto-complete-element"
import Blacklight from "blacklight"
import 'jquery'
import "universalviewer"
import 'blacklight-gallery'
import "@fortawesome/fontawesome-free"
import 'commonwealth-vlr-engine'


import "openseadragon"
import "openseadragon-rails"

// Legacy scripts
import "legacy/navbar"
import "legacy/main"

Blacklight.onLoad(function() {
  $('.documents-masonry').BlacklightMasonry();
  $('.documents-slideshow').slideshow();
});

import BlacklightRangeLimit from "blacklight-range-limit";
BlacklightRangeLimit.init({onLoadHandler: Blacklight.onLoad });

import "blacklight-allmaps"
