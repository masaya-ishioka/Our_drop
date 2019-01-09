// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

$(function(){
	$('#next').click(function(){
		$('.how_to').fadeIn(2000);
	});

	$('#next1').click(function(){
		$('.how_to').fadeOut(2000);
		$('.how_to2').fadeIn(2000);
	});

	$('#next2').click(function(){
		$('.how_to2').fadeOut(2000);
		$('.how_to3').fadeIn(2000);
	});

	$('#next3').click(function(){
		$('.how_to3').fadeOut(2000);
		$('.how_to4').fadeIn(2000);
	});

});