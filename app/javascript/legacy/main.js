$(function() {
  // Activates active class for button tabs
  // Seen on map sets homepage
  $('[data-toggle="btns"] .btn').on('click', function(){
        var $this = $(this);
        $this.parent().find('.active').removeClass('active');
        $this.addClass('active');
  });

  // Connect tab control to URL hash. Changing tabs updates the
  // URL. Loading a url with a hash selects the tab.
  if ($('a[data-toggle="tab"][href="' + location.hash + '"]').length > 0) {
    $('a[href="' + location.hash + '"]').tab('show');
  }
  $('a[data-toggle="tab"]').on('shown.bs.tab', function(e) {
    if (history && history.replaceState) {
      history.replaceState({}, '', $(e.target).attr('href'));
    }
  });

  // Focus on inputs with autofocus when opening bootstrap modals
  $(document).on('shown.bs.modal', '.modal', function() {
        $(this).find('[autofocus]').focus();
  });

  // navbar off-canvas toggle
  $('.nav-offcavas-toggle, .nav-offcavas-overlay').click(function() {
    const $toggleBtn = $('.nav-offcavas-toggle');
    const $navOffcanvas = $('.nav-offcavas');
    const $overlay = $('.nav-offcavas-overlay');

    if ($navOffcanvas.hasClass('expanded')) {
      $navOffcanvas.removeClass('expanded');
      $toggleBtn.find('.text').text('Menu');
    } else {
      $navOffcanvas.addClass('expanded');
      $toggleBtn.find('.text').text('Close');
    }
  });
});
