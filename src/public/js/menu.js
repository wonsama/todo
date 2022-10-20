$(function(){

	$(".gnb").each(function(){
		$("> li", this).on("mouseenter focusin",function(){
			$('#header').addClass("over");
			$('.gnb > li').removeClass("hv");
			$(this).addClass("hv");
			$(".head_menu_bg").addClass("on");
		}).on("mouseleave",function(){
			$('#header').removeClass("over");
			$(this).removeClass("hv");
			$(".head_menu_bg").removeClass("on");
		});
		$('*:not(".gnb a")').focus(function(){
			$('.gnb > li').removeClass("hv");
			$(".head_menu_bg").removeClass("on");
		})
		$('#gnb li.has-sub > a').on('click', function(){
			//$(this).removeAttr('href');
			var element = $(this).parent('li');
			if (element.hasClass('open')) {
				element.removeClass('open');
				element.find('li').removeClass('open');
				element.children('ul').slideUp('fast');
			}
			else {
				element.addClass('open');
				element.children('ul').slideDown('fast');
				element.siblings('li').children('ul').slideUp('fast');
				element.siblings('li').removeClass('open');
				element.siblings('li').find('li').removeClass('open');
				element.siblings('li').children('ul').slideUp('fast');
			}
			return false;
		});
	});
	

	$('#header .memb .btn').click(function(){
		$('.mem-set').toggle();
		$('#header .memb .mem-set').on("mouseleave",function(){
			$('.mem-set').hide();
			return false;
		});

	// 	$('#gnb').mouseover(function() {
	// 		$(".mem-set").hide();
	// })
		
		// return false;
	});
	
});
