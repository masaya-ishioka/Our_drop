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

document.addEventListener("turbolinks:load",　function(){
	$('#next').click(function(){
		$('.how_to').fadeIn(1000);
	});
	$('#next1').click(function(){
		$('.how_to').fadeOut(1000);
		$('.how_to2').fadeIn(1000);
	});
	$('#next2').click(function(){
		$('.how_to2').fadeOut(1000);
		$('.how_to3').fadeIn(1000);
	});
	$('#next3').click(function(){
		$('.how_to3').fadeOut(1000);
		$('.how_to4').fadeIn(1000);
	});
	$('.how_link').click(function(){
		$('.how_to4').fadeOut(1000);
	});


	$('.next').click(function(){
		$('.s_how_to').fadeIn();
	});
	$('.next1').click(function(){
		$('.s_how_to').fadeOut();
		$('.s_how_to2').fadeIn();
	});
	$('.next2').click(function(){
		$('.s_how_to2').fadeOut();
		$('.s_how_to3').fadeIn();
	});
	$('.next3').click(function(){
		$('.s_how_to3').fadeOut();
		$('.s_how_to4').fadeIn();
	});
	$('.next4').click(function(){
		$('.s_how_to4').fadeOut();
		$('.s_how_to5').fadeIn();
	});
	$('.next5').click(function(){
		$('.s_how_to5').fadeOut();
		$('.s_how_to6').fadeIn();
	});
	$('.next6').click(function(){
		$('.s_how_to6').fadeOut();
	});

	$('.fas1').click(function(){
		$('.fas1').hide();
		$('.fas2').show();
		$('.menu').fadeIn();
	});
	$('.fas2').click(function(){
		$('.fas2').hide();
		$('.fas1').show();
		$('.menu').fadeOut();
	});

	$('.like_click1').click(function(){
		$('.like_sound').hide();
		$('.like_user').show();
	});

	$('.like_click2').click(function(){
		$('.like_user').hide();
		$('.like_sound').show();
	});
});

















