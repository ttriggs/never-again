// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .
//= require jquery.slick

$(function(){ $(document).foundation(); });


$('.slick-carousel').slick({
  speed: 800,
  fade: true,
  arrows: false,
  slidesToShow: 1,
  slidesToScroll: 1,
  autoplaySpeed: 6000,
  autoplay: true
});

$('.restaurants-carousel').slick({
  infinite: true,
  autoplaySpeed: 3500,
  slidesToShow: 3,
  slidesToScroll: 1,
  // autoplay: true
  // arrows: false,
});
