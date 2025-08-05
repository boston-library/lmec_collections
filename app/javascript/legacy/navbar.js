$(function() {
  // Clicking the search toggle activates/deactivates the search panel
  // on the navbar.
  $('[data-search-toggle]').on('click', function() {
    $(this).toggleClass('active');
    $('.navbar-search').toggleClass('active');
    $('#q').focus();
  });

  // Clicking outside of the active nav search deactivates the panel
  $(document).mouseup(function (e) {
    var navSearch = $('.navbar-search.active, [data-search-toggle]');
    // ... not navSearch nor a descendant of the navSearch, and the same for the toggle
    if (!navSearch.is(e.target) && navSearch.has(e.target).length === 0) {
      $('[data-search-toggle], .navbar-search').removeClass('active');
    }
  });

  // Choosing an item from the search type dropdown sets the form
  // action and submits the form
  $('[data-search-action]').on('click', function(e) {
      var $link = $(this),
          $form = $link.parents('form'),
          name = $link.data('search-name');
      e.preventDefault();
      if (name) {
        $form.find('input[type="text"]').attr('name', name);
      }
      $form.attr('action', $link.attr('href'));
      $form.submit();
      return false;
  });

});