// initialize the carousel ourselves, since we need to listen for turbo:load
document.addEventListener("turbo:load", () => {
    const carousel_el = document.getElementById('home-carousel');
    if (!carousel_el) return;

    const carousel = new bootstrap.Carousel(carousel_el, {
        interval: 3000,
        ride: 'carousel',
        touch: false,
        pause: false,
        keyboard: false
    })
});
