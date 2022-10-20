// 버튼 클릭 이벤트

function btnPopOpen(){
$('.btn-pop').click(function(){
    var $self = $(this);
    var activeTab = $(this).attr("data-target");
    $(activeTab).attr('tabindex', '0').addClass('on').focus();
    $(activeTab).children().after('<div class="pop-bg"></div>');
    $(activeTab).find(".pop-close, .pop-bg").click(function(){
        $(activeTab).removeClass('on');
        $self.focus();
        $('.pop-bg').remove();
        return false;
    });
    //return false;
});
}

//탭메뉴
function tabMenu(){
    $(".tab-script").each(function(){
		var tabM = $(".tab-script ul");
		$("li a", this).click(function() {
			$(this).parent().parent().find('li').removeClass("on");
			$(this).parent().addClass("on"); 
			$(this).parents().siblings(".tab-con-script").hide(); 
			var activeTab = $(this).attr("href");
			$(activeTab).show(); 
			return false;
		});
	});
}

//레이아웃 변경
function layChange(){
    $('.btn-lay-b').click(function(){
        $(this).hide();
        $('.btn-lay-c').show();
        $('#sub-container #content').removeClass();
        $('#sub-container #content').addClass('lay-type-c');
        return false;
    });
    $('.btn-lay-c').click(function(){
        $(this).hide();
        $('.btn-lay-b').show();
        $('#sub-container #content').removeClass();
        $('#sub-container #content').addClass('lay-type-b');
        return false;
    });
}


$(function(){

    btnPopOpen()
    tabMenu();
    layChange();
	moreBtn();

});



//스크롤 페이드인
$(document).ready(function() {
	
	triggerJqueryFadeIn()
    $(window).scroll(triggerJqueryFadeIn);
});
var animateQueue = new Array();
var ready = true;
function triggerJqueryFadeIn() {
	$('.ani-in').each( function(){
		var object_top = $(this).offset().top;
		var window_bottom = $(window).scrollTop() + $(window).height() - 200;
		if( window_bottom > object_top ){
			$(this).addClass('action');
		}
	}); 
	triggerJqueryFadeInQueue();
}
function triggerJqueryFadeInQueue() {
	if(animateQueue.length != 0 && ready) {
		ready = false;
		$this = animateQueue.shift();
		$($this).addClass('action');
	}
}

// more 버튼
function moreBtn(){
    $(".more-btn").click(function(){
        if( $(this).children(".view").css("display") == "none"){
            $(".view").hide();
            $(this).children(".view").show();
        }else{
            $(this).children(".view").hide();
        }
    });
}