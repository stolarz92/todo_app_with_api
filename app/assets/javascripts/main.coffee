jQuery(document).ready ($) ->
# Back to top button

  initialize_google_map = ->
    myLatlng = new (google.maps.LatLng)(get_latitude, get_longitude)
    mapOptions =
      zoom: 14
      scrollwheel: false
      center: myLatlng
    map = new (google.maps.Map)(document.getElementById('google-map'), mapOptions)
    marker = new (google.maps.Marker)(
      position: myLatlng
      map: map)
    return

  $(window).scroll ->
    if $(this).scrollTop() > 100
      $('.back-to-top').fadeIn 'slow'
    else
      $('.back-to-top').fadeOut 'slow'
    return
  $('.back-to-top').click ->
    $('html, body').animate { scrollTop: 0 }, 1500, 'easeInOutExpo'
    false
  # Stick the header at top on scroll
  $('#header').sticky
    topSpacing: 0
    zIndex: '50'
  # Intro background carousel
  $('#intro-carousel').owlCarousel
    autoplay: true
    dots: false
    loop: true
    animateOut: 'fadeOut'
    items: 1
  # Initiate the wowjs animation library
  (new WOW).init()
  # Initiate superfish on nav menu
  $('.nav-menu').superfish
    animation: opacity: 'show'
    speed: 400
  # Mobile Navigation
  if $('#nav-menu-container').length
    $mobile_nav = $('#nav-menu-container').clone().prop(id: 'mobile-nav')
    $mobile_nav.find('> ul').attr
      'class': ''
      'id': ''
    $('body').append $mobile_nav
    $('body').prepend '<button type="button" id="mobile-nav-toggle"><i class="fa fa-bars"></i></button>'
    $('body').append '<div id="mobile-body-overly"></div>'
    $('#mobile-nav').find('.menu-has-children').prepend '<i class="fa fa-chevron-down"></i>'
    $(document).on 'click', '.menu-has-children i', (e) ->
      $(this).next().toggleClass 'menu-item-active'
      $(this).nextAll('ul').eq(0).slideToggle()
      $(this).toggleClass 'fa-chevron-up fa-chevron-down'
      return
    $(document).on 'click', '#mobile-nav-toggle', (e) ->
      $('body').toggleClass 'mobile-nav-active'
      $('#mobile-nav-toggle i').toggleClass 'fa-times fa-bars'
      $('#mobile-body-overly').toggle()
      return
    $(document).click (e) ->
      container = $('#mobile-nav, #mobile-nav-toggle')
      if !container.is(e.target) and container.has(e.target).length == 0
        if $('body').hasClass('mobile-nav-active')
          $('body').removeClass 'mobile-nav-active'
          $('#mobile-nav-toggle i').toggleClass 'fa-times fa-bars'
          $('#mobile-body-overly').fadeOut()
      return
  else if $('#mobile-nav, #mobile-nav-toggle').length
    $('#mobile-nav, #mobile-nav-toggle').hide()
  # Smooth scroll for the menu and links with .scrollto classes
  $('.nav-menu a, #mobile-nav a, .scrollto').on 'click', ->
    if location.pathname.replace(/^\//, '') == @pathname.replace(/^\//, '') and location.hostname == @hostname
      target = $(@hash)
      if target.length
        top_space = 0
        if $('#header').length
          top_space = $('#header').outerHeight()
          if !$('#header').hasClass('header-fixed')
            top_space = top_space - 20
        $('html, body').animate { scrollTop: target.offset().top - top_space }, 1500, 'easeInOutExpo'
        if $(this).parents('.nav-menu').length
          $('.nav-menu .menu-active').removeClass 'menu-active'
          $(this).closest('li').addClass 'menu-active'
        if $('body').hasClass('mobile-nav-active')
          $('body').removeClass 'mobile-nav-active'
          $('#mobile-nav-toggle i').toggleClass 'fa-times fa-bars'
          $('#mobile-body-overly').fadeOut()
        return false
    return
  # Porfolio - uses the magnific popup jQuery plugin
  $('.portfolio-popup').magnificPopup
    type: 'image'
    removalDelay: 300
    mainClass: 'mfp-fade'
    gallery: enabled: true
    zoom:
      enabled: true
      duration: 300
      easing: 'ease-in-out'
      opener: (openerElement) ->
        if openerElement.is('img') then openerElement else openerElement.find('img')
  # Testimonials carousel (uses the Owl Carousel library)
  $('.testimonials-carousel').owlCarousel
    autoplay: true
    dots: true
    loop: true
    responsive:
      0: items: 1
      768: items: 2
      900: items: 3
  # Clients carousel (uses the Owl Carousel library)
  $('.clients-carousel').owlCarousel
    autoplay: true
    dots: true
    loop: true
    responsive:
      0: items: 2
      768: items: 4
      900: items: 6
  #Google Map
  get_latitude = $('#google-map').data('latitude')
  get_longitude = $('#google-map').data('longitude')
  google.maps.event.addDomListener window, 'load', initialize_google_map
  return

# ---
# generated by js2coffee 2.2.0