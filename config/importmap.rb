# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@github/auto-complete-element", to: "https://cdn.skypack.dev/@github/auto-complete-element"
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.6/dist/umd/popper.min.js"
pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
pin "openseadragon" # @5.0.1
pin "jquery", to: "https://code.jquery.com/jquery-3.7.1.min.js"
# chart.js is dependency of blacklight-range-limit, currently is not working
# as vendored importmaps, but instead must be pinned to CDN. You may want to update
# versions perioidically.
pin "chart.js", to: "https://ga.jspm.io/npm:chart.js@4.2.0/dist/chart.js"
# single dependency of chart.js:
pin "@kurkle/color", to: "https://ga.jspm.io/npm:@kurkle/color@0.3.2/dist/color.esm.js"
pin "@fortawesome/fontawesome-free", to: "@fortawesome--fontawesome-free.js"
pin "universalviewer", to: "https://cdn.jsdelivr.net/npm/universalviewer@4.2.0/dist/esm/index.js"

pin_all_from "app/javascript/legacy", under: "legacy"

# blacklight-allmaps
pin "leaflet", to: "https://ga.jspm.io/npm:leaflet@1.9.4/dist/leaflet-src.js"
pin "leaflet-fullscreen", to: "https://ga.jspm.io/npm:leaflet-fullscreen@1.0.2/dist/Leaflet.fullscreen.js"
pin "@allmaps/leaflet", to: "https://cdn.jsdelivr.net/npm/@allmaps/leaflet@1.0.0-beta.49/+esm"
