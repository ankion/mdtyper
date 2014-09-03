# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

hljs.highlightBlock(e) for e in $('pre code')

$("#sidebar-toggle").click (e) ->
  e.preventDefault()
  $("#wrapper").toggleClass "toggled"

# Hide Header on on scroll down
didScroll = false
lastScrollTop = 0
delta = 5
navbarHeight = $('.header').outerHeight()
introHeight = $('.intro-header').outerHeight()

hasIntroImage = ->
  st = $(this).scrollTop()
  if st >= introHeight
    $('.header').removeClass('nav-image')
  else
    $('.header').addClass('nav-image')

hasIntroImage()

$(window).scroll (event) ->
  didScroll = true

setInterval (->
  if didScroll
    hasScrolled()
    hasIntroImage()
    didScroll = false
), 250

hasScrolled = ->
  st = $(this).scrollTop()
  navbarHeight = $('.header').outerHeight()
  return if Math.abs(lastScrollTop - st) <= delta
  if st > lastScrollTop and st > navbarHeight
    $('.header').css('top', navbarHeight * -1)
  else
    $('.header').css('top', 0) if st + $(window).height() < $(document).height()
  lastScrollTop = st
