var TAX_RATE = parseFloat($('#config_tax_rate').val());
var TAX_SETTING = false;
$('body').addClass('hidetax hidenote hidedate');


function init_date() {
    var now = new Date();
    var month = (now.getMonth() + 1);
    var day = now.getDate();
    if (month < 10) {
        month = "0" + month;
    }
    if (day < 10) {
        day = "0" + day;
    }
    var today = day + '.' + month + '.' + now.getFullYear().toString().substr(2, 2);

    var intwoweeks = new Date(now.getTime() + 14 * 24 * 60 * 60 * 1000);
    var month = (intwoweeks.getMonth() + 1);
    var day = intwoweeks.getDate();
    if (month < 10) {
        month = "0" + month;
    }
    if (day < 10) {
        day = "0" + day;
    }

    var twoweeks = day + '.' + month + '.' + intwoweeks.getFullYear().toString().substr(2, 2);



    $('.datePicker').val(today);
    $('.twoweeks').val(twoweeks);
}

function calculate() {

    var total_price = 0,
        total_tax = 0;

    console.log('CALCULATING - Tax Rate:' + TAX_RATE);

    $('.invoicelist-body tbody tr').each(function () {
        var row = $(this),
            rate = row.find('.rate input').val(),
            amount = row.find('.amount input').val();

        var sum = rate * amount;
        var tax = ((sum / (TAX_RATE + 100)) * TAX_RATE);


        total_price = total_price + sum;
        total_tax = total_tax + tax;

        row.find('.sum').text(sum.toFixed(2));
        row.find('.tax').text(tax.toFixed(2));
    });

    $('#total_price').text(total_price.toFixed(2));
    $('#total_tax').text(total_tax.toFixed(2));
}


var newRow = '<tr><td><a class="control removeRow" href="#">x</a><span contenteditable>Jeans</span></td><td><span contenteditable>Blue and black</span></td><td class="daterelated"><span contenteditable>Datum</span></td><td class="amount"><input type="text" value="1"/></td><td class="rate"><input type="text" value="60" /></td><td class="tax taxrelated"></td><td class="sum"></td></tr>';

$('.invoicelist-body').on('keyup', 'input', function () {
    calculate();
});

$('.newRow').on('click', function (e) {
    $('.invoicelist-body tbody').append(newRow);
    e.preventDefault();
    calculate();
});

$('body').on('click', '.removeRow', function (e) {
    $(this).closest('tr').remove();
    e.preventDefault();
    calculate();
});

$('#config_note').on('change', function () {
    $('body').toggleClass('shownote hidenote');
});
$('#config_tax').on('change', function () {
    TAX_SETTING = !TAX_SETTING;
    $('body').toggleClass('showtax hidetax');
});

$('#config_tax_rate').on('keyup', function () {
    TAX_RATE = parseFloat($(this).val());
    if (TAX_RATE < 0 || TAX_RATE > 100) {
        TAX_RATE = 0;
    }
    console.log('Changed tax rate to: ' + TAX_RATE);
    calculate();
});

$('#config_date').on('change', function () {
    $('body').toggleClass('hidedate showdate');
});


init_date();
calculate();