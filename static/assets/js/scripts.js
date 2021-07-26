(function ($) {
    "use strict";

    /* 
    ------------------------------------------------
    Sidebar open close animated humberger icon
    ------------------------------------------------*/

    $(".hamburger").on('click', function () {
        $(this).toggleClass("is-active");
    });


    /*  
    -------------------
    List item active
    -------------------*/
    $('.header li, .sidebar li').on('click', function () {
        $(".header li.active, .sidebar li.active").removeClass("active");
        $(this).addClass('active');
    });

    $(".header li").on("click", function (event) {
        event.stopPropagation();
    });

    $(document).on("click", function () {
        $(".header li").removeClass("active");

    });



    /*  
    -----------------
    Chat Sidebar
    ---------------------*/


    var open = false;

    var openSidebar = function () {
        $('.chat-sidebar').addClass('is-active');
        $('.chat-sidebar-icon').addClass('is-active');
        open = true;
    }
    var closeSidebar = function () {
        $('.chat-sidebar').removeClass('is-active');
        $('.chat-sidebar-icon').removeClass('is-active');
        open = false;
    }

    $('.chat-sidebar-icon').on('click', function (event) {
        event.stopPropagation();
        var toggle = open ? closeSidebar : openSidebar;
        toggle();
    });




    /* 
    ---------------
    LobiPanel Function
    ---------------*/
    $(function () {
        $('.lobipanel-basic').lobiPanel({
            sortable: true,
            reload: {
                icon: 'ti-loop'
            },
            editTitle: {
                icon: 'ti-pencil-alt',
                icon2: 'ti-save'
            },
            unpin: {
                icon: 'ti-pin-alt'
            },
            minimize: {
                icon: 'ti-angle-up',
                icon2: 'ti-angle-down'
            },
            close: {
                icon: 'ti-close'
            },
            expand: {
                icon: 'ti-fullscreen',
                icon2: 'fa fa-compress'
            }
        });
    });





    /* TO DO LIST 
    --------------------*/
    $(".tdl-new").on('keypress', function (e) {
        var code = (e.keyCode ? e.keyCode : e.which);
        if (code == 13) {
            var v = $(this).val();
            var s = v.replace(/ +?/g, '');
            if (s == "") {
                return false;
            } else {
                $(".tdl-content ul").append("<li><label><input type='checkbox'><i></i><span>" + v + "</span><a href='#' class='ti-close'></a></label></li>");
                $(this).val("");
            }
        }
    });


    $(".tdl-content a").on("click", function () {
        var _li = $(this).parent().parent("li");
        _li.addClass("remove").stop().delay(100).slideUp("fast", function () {
            _li.remove();
        });
        return false;
    });

    // for dynamically created a tags
    $(".tdl-content").on('click', "a", function () {
        var _li = $(this).parent().parent("li");
        _li.addClass("remove").stop().delay(100).slideUp("fast", function () {
            _li.remove();
        });
        return false;
    });



    /*  Chat Sidebar User custom Search
    ---------------------------------------*/

    $('[data-search]').on('keyup', function () {
        var searchVal = $(this).val();
        var filterItems = $('[data-filter-item]');

        if (searchVal != '') {
            filterItems.addClass('hidden');
            $('[data-filter-item][data-filter-name*="' + searchVal.toLowerCase() + '"]').removeClass('hidden');
        } else {
            filterItems.removeClass('hidden');
        }
    });


        /*  Chackbox all
        ---------------------------------------*/

        $("#checkAll").change(function () {
            $("input:checkbox").prop('checked', $(this).prop("checked"));
        });


    /*  Data Table
    -------------*/

    //$('#bootstrap-data-table').DataTable();

})(jQuery);


(function ($) {
    "use strict"; 
    $(".card-collapse").click(function() {  
        $(this).parents(".card").find( ".card-content" ).slideToggle(300);
        return false; 
    });





    //Header logo 
    $(".hamburger").on('click', function (){ 
        var logoImg_sml =  $('#logoImg').data('logo_small');
        var logoImg_big =  $('#logoImg').data('logo_big');
        var logoOld =  $('#logoImg').attr('src');
        if (logoOld == logoImg_big) { 
            $('#logoImg').attr('src',logoImg_sml);
        } else {
            $('#logoImg').attr('src',logoImg_big);
        } 
        //$('.sidebar .nano-content > ul li.label').slideToggle(); 
    });


    $(window).on("load",function(e){  
        if($('body').hasClass('sidebar-hide')){
            var logoImg_sml =  $('#logoImg').data('logo_small');
            $('#logoImg').attr('src',logoImg_sml);
        } 
    });



    //sidebar 
    $('.sidebar').hover(function() {
       $('body').addClass('open-sidebar')
    }, function() {
        $('body').removeClass('open-sidebar')
    });



    $('.header-icon.dib').on('click', function(event) {
        var windowHeight = $(window).height();
        var thisHeight = $(this).children('.drop-down').height();
        //alert('mine > ' + thisHeight + ' w > ' + windowHeight);
        if (thisHeight>windowHeight) {
            $(this).children('.drop-down').css({
                'overflow' : 'scroll',
                'padding-bottom': '40px',
                'height': '100vh' 
            });
        } else {
            $(this).children('.drop-down').css({
                'overflow' : 'inherit',
                'padding-bottom': '0',
                'height': 'auto' 
            });
        } 
    });



})(jQuery);
