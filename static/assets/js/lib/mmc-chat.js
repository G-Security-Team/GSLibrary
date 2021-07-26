function minimizedBoxCount() {
    _count = $('#mmc-chat .box.minimized .dropdown li').size();

    $('#mmc-chat .box.minimized .count span').html($('#mmc-chat .box.minimized .dropdown li').size());

    if (_count == 0) {
        $('#mmc-chat .box.minimized').remove();
    }
}


function box_minimizedAddUser() {
    _boxHidden = $('#mmc-chat .box:not(".minimized"):not(".hidden")').eq(0);
    _boxHidden.addClass('hidden');
    dataId = _boxHidden.data('id');

    hasItem = false;
    $('#mmc-chat .box.minimized .dropdown li').each(function () {
        if ($(this).data('id') == dataId) {
            hasItem = true;
        }
    });

    if (!hasItem) {
        dataUserName = _boxHidden.find('.box-username a').text();
        $('#mmc-chat .box.minimized .dropdown').append(box_minimized_dropdownLi.format(dataId, dataUserName));
    }
}

var box_minimized_dropdownLi = '<li data-id="{0}"><div class="username">{1}</div> <div class="remove">X</div></li>'
function box_minimized() {
    _boxDefaultWidth = parseInt($('#mmc-chat .box:not(".minimized")').css('width').replace('px', ''), 0);
    _boxCommonWidth = parseInt($('.chat-box').css('width').replace('px', ''), 10) + 50 + parseInt($('#sidebar').css('width').replace('px', ''), 10);
    _windowWidth = $(window).width();
    _hasMinimized = false;

    $('#mmc-chat .boxs .box').each(function (index) {
        if ($(this).hasClass('minimized')) {
            _hasMinimized = true;
        }
    });

    if ((_windowWidth) > (_boxCommonWidth + 50)) {

        if (!_hasMinimized) {
            return;
        }

        dataId = $('#mmc-chat .boxs .minimized .dropdown li').last().data('id');
        $('#mmc-chat .boxs .minimized .dropdown li').last().remove();
        $('#mmc-chat .boxs .box').each(function (index) {
            if ($(this).data('id') == dataId) {
                $(this).removeClass('hidden');
                return false;
            }
        });
    } else {

        if (!_hasMinimized) {
            $('#mmc-chat .boxs').prepend('<li class="box minimized"><div class="count"><span>0</span></div><ul class="dropdown"></ul></li>');
        }
        box_minimizedAddUser();
    }

    minimizedBoxCount();
}
var newBox = '<li class="box" data-id="{0}"> <div class="had-container"> <div class="box-header "> <div class="info"> <span class="box-username"><a href="#">{1}</a></span> </div><div class="tools"> <span class="collapse tooltipped ti-minus" data-position="top" data-tooltip="Collapse chat"> </span> <span class="maximize ti-layers maximize-tooltipped" data-position="top" data-tooltip="Open other window"> </span> <span class="close ti-close close_tooltip" data-position="top" data-tooltip="Close"> </span> </div></div><div class="box-body"> <div class="status {2}"></div><div class="options"> <div class="group group1"> <a href="#" class="video-cam ti-video-camera" title="If you want video call click"></a> <a href="#" class="person-add ti-user" title="Add person this chat"></a> </div><div class=" group group2"> </div><div class="clear"></div></div><div class="message-scrooler"> <div class="messages"> </div></div></div><div class="box-footer"> <div class="item icons" data-source="icons-set"> <div class="smile-ico"></div><div class="smiles-set"></div></div><div class="item send-message"> <div class="textarea" contenteditable="true" data-placeholder="Write message"> </div></div><div class="item file"> <input type="file" id="selectedFile" class="selected-file"/> </div></div></div></li>';
$(window).resize(function () {
    box_minimized();
    sidebar_closed();
});
//$(function () {
//
//    waveEffect = $('.user-list').attr('wave-effect');
//    waveColor = $('.user-list').attr('wave-color');
//    if (waveEffect == 'true') {
//        $('#sidebar .user-list li').each(function (index) {
//            $(this).addClass('waves-effect ' + waveColor);
//        });
//    }    
//
////    initializeTooltip();
//    messageScrollMoveEnd();
//    generatePlaceholder();   
//
//    box_minimized();
//});



$(document).on('click', '#mmc-chat .box', function () {

    if ($(this).hasClass('new-message')) {
        $(this).removeClass('new-message');
    }
    selectActiveChatBox(this);
});

$(document).on('click', '#mmc-chat .box-header .info', function () {
    removeBoxCollapseClass($(this).parents('.box'));
    //selectActiveChatBox($(this).parents('.box'));
    messageScrollMoveEnd();
});

$(document).on('click', '#mmc-chat .box .collapse', function () {
    parent = $(this).parents('.box');

    if (parent.hasClass('collapsed')) {
        parent.removeClass('collapsed');
        messageScrollMoveEnd();
    } else {
        parent.addClass('collapsed');
    }

});

$(document).on('click', '#mmc-chat .box .close', function () {
    parent = $(this).parents('.box');
    if (parent.hasClass('active')) {
        parent.remove();
        setTimeout(function () { $('#mmc-chat .boxs .box:last-child').addClass('active'); }, 1);
    }
    parent.remove();
    parent.find('.close_tooltip').tooltip('remove');

    box_minimized();
});

$(document).on('click', '#mmc-chat #sidebar .user-list li', function () {

    dataId = $(this).attr('data-id');
    dataStatus = $(this).data('status');
    dataUserName = $(this).attr('data-username');
    _return = false;

    $('#mmc-chat .chat-box .boxs .box').each(function (index) {
        if ($(this).attr('data-id') == dataId) {
            removeBoxCollapseClass(this);
            selectActiveChatBox(this);
            _return = true;
        }
    });
  

    if (_return) {
        return;
    }
    $('#mmc-chat .box').removeClass('active');
    $('#mmc-chat .chat-box .boxs').append(newBox.format(dataId, dataUserName, dataStatus));
    generatePlaceholder();
    messageScrollMoveEnd();
    box_minimized();
    initializeTooltip();
});

$(document).on('focus', '#mmc-chat .textarea', function () {
    if ($(this).html() == '<span class="placeholder">{0}</span>'.format($(this).data('placeholder'))) {
        $(this).html('');
    }
});

$(document).on('blur', ' #mmc-chat .textarea', function () {
    if ($(this).html() == '') {
        $(this).html('<span class="placeholder">{0}</span>'.format($(this).data('placeholder')));
    }
});

$(document).on('click', '#mmc-chat .sidebar-collapse', function () {
    if ($('#mmc-chat').hasClass('sidebar-closed')) {
        $('#mmc-chat').removeClass('sidebar-closed');
        // $('.search').addClass('input-field');
        $('#mmc-chat .search input').attr('placeholder', '');
        $('#mmc-chat .search').css('display', 'block');

        //$('#mmc-chat .user-list li').each(function (index) {

        //    $(this).removeClass('tooltipped');
        //    $(this).removeAttr('data-position');
        //    $(this).removeAttr('data-tooltip'); 
        //    $(this).removeAttr('data-tooltip-id');
        //});

        deinitializeTooltipSiderbarUserList();



    } else {
        $('#mmc-chat').addClass('sidebar-closed');

        // $('.search').removeClass('input-field');
        $('#mmc-chat .search input').attr('placeholder', $('.search input').data('placeholder'));
        $('#mmc-chat .search').css('display', 'none');
        $('#mmc-chat .search').removeAttr('style');
        $('#mmc-chat .searchbar-closed').removeAttr('style');
        //$('#mmc-chat .user-list li').each(function (index) {

        //    $(this).addClass('tooltipped');
        //    $(this).attr('data-position', 'left');
        //    $(this).attr('data-tooltip', $(this).data('username'));

        //});

        initializeTooltipSiderbarUserList();
    }
});

$(document).on('click', '#mmc-chat .searchbar-closed', function () {
    $('#mmc-chat .sidebar-collapse').click();
    setTimeout(function () { $('#mmc-chat .searchbar input').focus(); }, 50);
    return false;
});

$(document).on('click', '#mmc-chat .box .maximize', function () {
    window.open('inbox.html', 'window name', "width=300,height=400,scrollbars=yes");
    $(this).parents('.box').remove();
    $('maximize-tooltipped').tooltip('remove');
    return false;
});



$(document).on('click', '#mmc-chat .boxs .minimized .count', function (e) {
    e.stopPropagation();
    hideStickerBox();
    _parent = $(this).parents('.minimized');

    if (_parent.hasClass('show')) {
        hideMinimizedBox();
    } else {

        _parent.addClass('show');
        _bottom = parseInt(_parent.css('height').replace('px', ''),0) + 10;
        _parent.find('.dropdown').css({
            'display': 'block',
            'bottom': _bottom
        });
    }
});

$(document).on('click', '#mmc-chat .boxs .minimized .dropdown .username', function (e) {
    e.stopPropagation();
    selectedDataId = $(this).parent().data('id');

    $(this).parent().remove();

    box_minimizedAddUser();

    $('#mmc-chat .boxs .box').each(function (index) {
        if ($(this).data('id') == selectedDataId) {
            $(this).removeClass('hidden').removeClass('collapsed');
            selectActiveChatBox($(this));
        }
    });
});

$(document).on('click', '#mmc-chat .boxs .minimized .dropdown .remove', function (e) {
    e.stopPropagation();
    _parent = $(this).parents('.dropdown li');
    dataId = _parent.data('id');

    $('#mmc-chat .box').each(function () {
        if ($(this).data('id') == dataId) {
            $(this).remove();
        }
    });
    _parent.remove();

    minimizedBoxCount();
});

