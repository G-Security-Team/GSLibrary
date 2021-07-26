
var placeholder = '<span class="placeholder">{0}</span>';
function selectActiveChatBox(selector) {
    $('#mmc-chat .box').removeClass('active');
    $(selector).addClass('active');
}
function removeBoxCollapseClass(selector) {

    if ($(selector).hasClass('collapsed')) {
        $(selector).removeClass('collapsed');
    }
}
function messageScrollMoveEnd() {

    setTimeout(function () {
        if ($('.messages div').size() == 0) {
            return;
        }
        $('.message-scrooler').animate({
            scrollTop: $('.messages div:last').offset().top
        }, 0);
    }, 100);
}

function initializeTooltip() {
    //tooltip
    $('.tooltipped').tooltip({ delay: 50 });
    $('.close_tooltip').tooltip({ delay: 50 });
}

function initializeTooltipSiderbarUserList() {
    $('.user-tooltip').tooltip({ delay: 50 });
}
function deinitializeTooltipSiderbarUserList() {
    $('.user-tooltip').tooltip('remove');
}

function stickersTab() {
    setTimeout(function () {
        $('.stickers ul.tabs').tabs();
        $('.stickers ul.tabs').css({ 'height': '55px' });

    }, 1);
}

function hideStickerBox() {
    $('#mmc-chat .box .icons').removeClass('show');
    $('#mmc-chat .box .icons').find('.smiles-set').removeAttr('style');
}
function hideMinimizedBox() {

    if ($('#mmc-chat .boxs .minimized').hasClass('show')) {
        $('#mmc-chat .boxs .minimized').removeClass('show');
        $('#mmc-chat .boxs .minimized').find('.dropdown').removeAttr('style');
    }

}
function hasNewMessage(dataId) {
    $('#mmc-chat .chat-box .boxs .box').each(function () {
        if ($(this).data('id') == dataId) {
            $(this).addClass('new-message');
        }
    });
}
function generatePlaceholder() {
    setTimeout(function () {
        $("#mmc-chat .textarea").each(function () {
            $(this).html(placeholder.format($(this).data('placeholder')));
        });
    }, 10);
}
//var messageType = { text: 1, date: 2 }
//var messageSenderType = { in: 1, out: 2 }
//var _messageDate = '<div class="date">{0}</div>';

//function messageAdd(dataId, message, type, senderType) {
//    type = type || messageType.text;
//    senderType = senderType || messageSenderType.in;

//    $('#mmc-chat .chat-box .boxs .box').each(function () {
//        if ($(this).data('id') == dataId) {

//            switch (type) {
//                case messageType.date:
//                    $(this).find('.messages').append(_messageDate.format(message));
//                    break;
//                default:
//                    $(this).find('.messages').append(_messageDate.format(message));
//                    break;

//            }


//        }
//    });
//    conversation.find('.messages')
//       .append('<div class="date">Today</div>')
//       .append('<div class="message in "><div class="sender"><a href="javascript:void(0);" title="Rufat Askerov"><img src="assets/img/avatar.png" class="avatar" alt="Rufat Askerov"></a></div><div class="body"><div class="content"><span>Hello, welcome to chat </span></div><div class="seen"><span>few seconds ago </span> </div></div><div class="clear"></div></div>');


//    messageScrollMoveEnd();
//}
function sidebar_closed() {
    windowWidth = $(window).width();
    if (windowWidth < 1100) {
        $('#mmc-chat').addClass('sidebar-closed');
    } else {
        $('#mmc-chat').removeClass('sidebar-closed');
    }
}
//string format function -- use 'hello {0}'.format('demo')  -> result : 'hello demo'
String.prototype.format = String.prototype.f = function () {
    var s = this,
        i = arguments.length;

    while (i--) {
        s = s.replace(new RegExp('\\{' + i + '\\}', 'gm'), arguments[i]);
    }
    return s;
};

$(document).on('click', '#mmc-chat .box .smile-ico', function (e) {
    e.stopPropagation();
    hideMinimizedBox();

    _parent = $(this).parents('.icons');

    if (_parent.hasClass('show')) {
        hideStickerBox(_parent);
    } else {
        _bottom = parseInt(_parent.css('height').replace('px', ''), 0) + 10;
        _source = _parent.data('source');
        _parent.find('.smiles-set').html($('.' + _source).html());

        _parent.find('.smiles-set').css({
            'bottom': _bottom,
            'display': 'block'
        });
        _parent.addClass('show');
        stickersTab();
    }
});
$(document).on('click', '#mmc-chat .box .stickers', function (e) {
    e.stopPropagation();
});
$(document).on('click', '#mmc-chat .preview-image', function () {
    preview = '<div class="preview-overlay"><div class="preview-placeholder"><img class="preview-image" src="{0}"/><div class="preview-caption">{1}</div></div></div>';
    imgSrc = $(this).attr('src');
    caption = $(this).data('caption');

    imgWidth = $(this).css('width');
    imgHeight = $(this).css('height');

    if ($('#mmc-chat').hasClass('preview-placeholder')) {
        return;
    }
    $('#mmc-chat').prepend(preview.format(imgSrc, caption));
    var origin = $('.preview-placeholder .preview-image');

    var windowWidth = window.innerWidth;
    var windowHeight = window.innerHeight;
    var originalWidth = origin.width();
    var originalHeight = origin.height();

    var ratio = 0;
    var widthPercent = originalWidth / windowWidth;
    var heightPercent = originalHeight / windowHeight;
    var newWidth = 0;
    var newHeight = 0;

    if (widthPercent > heightPercent) {
        ratio = originalHeight / originalWidth;
        newWidth = windowWidth * 0.9;
        newHeight = windowWidth * 0.9 * ratio;
    }
    else {
        ratio = originalWidth / originalHeight;
        newWidth = (windowHeight * 0.9) * ratio;
        newHeight = windowHeight * 0.9;
    }

    var _left = $(document).scrollLeft() + windowWidth / 2 - origin.parent('.preview-placeholder').offset().left - newWidth / 2;
    var _top = $(document).scrollTop() + windowHeight / 2 - origin.parent('.preview-placeholder').offset().top - newHeight / 2;


    $('.preview-placeholder').css({
        'max-width': newWidth,
        'width': originalWidth,
        'top': _top
    });


    $('.preview-caption').css({
        'top': (newHeight )
    });

});
$(document).on('click', '#mmc-chat .preview-overlay:not(".preview-placeholder")', function () {
    $('.preview-overlay').remove();
});
$(document).on('click', '#mmc-chat .box .stickers .tab-content li', function () {

    _sendMsg = $(this).parents('.box-footer').find('.send-message div');
    //_src = $(this).find('img').attr('src');
    _img = $(this).html();
    if ($(this).parents('.box-footer').find('.send-message div').html() == '<span class="placeholder">{0}</span>'.format(_sendMsg.data('placeholder'))) {
        _sendMsg.html(_img);
    } else {
        _str = _sendMsg.html();
        //_sendMsg.html(_str + ' ' + '<div class="send-sticker" style="background-image:url({0})"></div>'.format(_src));
        _sendMsg.html(_str + ' ' + _img);
    }
});
$(document).on('keypress', '#mmc-chat .textarea', function (e) {

    if (e.which == 13) {
        _box_message = $(this).parents('.box').find('.messages');
        _msgTxt = $(this).html();
        _box_message.append('<div class="message out no-avatar"> <div class="sender"> <a href="javascript:void(0);" title="Rufat Askerov"> <img src="assets/img/avatar.png" class="avatar" alt="Rufat Askerov"> </a> </div><div class="body"> <div class="content">{0}</div><div class="seen"><span>a few seconds ago </span> </div></div><div class="clear"></div></div>'
            .format(_msgTxt));
        //_box_message.find('.message').last().
        $(this).html('');
        hideStickerBox();
        messageScrollMoveEnd();
    }
});

$(document).click(function () {
    hideStickerBox();
    hideMinimizedBox();
});


