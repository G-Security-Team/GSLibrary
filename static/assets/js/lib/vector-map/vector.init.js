(function ($) {
    "use strict";





    jQuery('#vmap').vectorMap({
        map: 'world_en',
        backgroundColor: null,
        color: '#ffffff',
        hoverOpacity: 0.7,
        selectedColor: '#8FC9FB',
        enableZoom: true,
        showTooltip: true,
        values: sample_data,
        scaleColors: ['#8FC9FB', '#006491'],
        normalizeFunction: 'polynomial'
    });

    jQuery('#vmap2').vectorMap({
        map: 'dz_fr',
        color: '#ff2e44',
        borderColor: '#fff',
        backgroundColor: '#fff',
        borderOpacity: 1,
        enableZoom: true,
        showTooltip: true
    });

    jQuery('#vmap3').vectorMap({
        map: 'argentina_en',
        color: '#ff2e44',
        borderColor: '#fff',
        backgroundColor: '#fff',
        onRegionClick: function (element, code, region) {
            var message = 'You clicked "' + region + '" which has the code: ' + code.toUpperCase();

            alert(message);
        }
    });

    jQuery('#vmap4').vectorMap({
        map: 'brazil_br',
        color: '#ff2e44',
        borderColor: '#fff',
        backgroundColor: '#fff',
        onRegionClick: function (element, code, region) {
            var message = 'You clicked "' + region + '" which has the code: ' + code.toUpperCase();

            alert(message);
        }
    });

    jQuery('#vmap5').vectorMap({
        map: 'france_fr',
        color: '#ff2e44',
        borderColor: '#fff',
        backgroundColor: '#fff',
        enableZoom: true,
        showTooltip: true
    });

    jQuery('#vmap6').vectorMap({
        map: 'germany_en',
        color: '#ff2e44',
        borderColor: '#fff',
        backgroundColor: '#fff',
        onRegionClick: function (element, code, region) {
            var message = 'You clicked "' + region + '" which has the code: ' + code.toUpperCase();

            alert(message);
        }
    });

    jQuery('#vmap7').vectorMap({
        map: 'greece',
        color: '#ff2e44',
        borderColor: '#fff',
        backgroundColor: '#fff',
        onRegionClick: function (element, code, region) {
            var message = 'You clicked "' + region + '" which has the code: ' + code.toUpperCase();

            alert(message);
        }
    });

    jQuery('#vmap8').vectorMap({
        map: 'iran_ir',
        onRegionClick: function (element, code, region) {
            var message = 'You clicked "' + region + '" which has the code: ' + code.toUpperCase();

            alert(message);
        }
    });

    jQuery('#vmap9').vectorMap({
        map: 'iraq',
        color: '#ff2e44',
        borderColor: '#fff',
        backgroundColor: '#fff',
        onRegionClick: function (element, code, region) {
            var message = 'You clicked "' + region + '" which has the code: ' + code.toUpperCase();

            alert(message);
        }
    });

    jQuery('#vmap10').vectorMap({
        map: 'russia_en',
        color: '#ff2e44',
        borderColor: '#fff',
        backgroundColor: '#fff',
        hoverOpacity: 0.7,
        selectedColor: '#999999',
        enableZoom: true,
        showTooltip: true,
        scaleColors: ['#C8EEFF', '#006491'],
        normalizeFunction: 'polynomial'
    });

    jQuery('#vmap11').vectorMap({
        map: 'tunisia',
        color: '#ff2e44',
        borderColor: '#fff',
        backgroundColor: '#fff',
        onRegionClick: function (element, code, region) {
            var message = 'You clicked "' + region + '" which has the code: ' + code.toUpperCase();

            alert(message);
        }
    });

    jQuery('#vmap12').vectorMap({
        map: 'europe_en',
        color: '#ff2e44',
        borderColor: '#fff',
        backgroundColor: '#fff',
        enableZoom: true,
        showTooltip: true
    });

    jQuery('#vmap13').vectorMap({
        map: 'usa_en',
        color: '#ff2e44',
        borderColor: '#fff',
        backgroundColor: '#fff',
        enableZoom: true,
        showTooltip: true,
        selectedColor: null,
        hoverColor: null,
        colors: {
            mo: '#C9DFAF',
            fl: '#C9DFAF',
            or: '#C9DFAF'
        },
        onRegionClick: function (event, code, region) {
            event.preventDefault();
        }
    });

    jQuery('#vmap14').vectorMap({
        map: 'turkey',
        color: '#ff2e44',
        borderColor: '#fff',
        backgroundColor: '#fff',
        onRegionClick: function (element, code, region) {
            var message = 'You clicked "' + region + '" which has the code: ' + code.toUpperCase();
            alert(message);
        }
    });



})(jQuery);



var map;

jQuery(document).ready(function () {

    // Store currentRegion
    var currentRegion = 'fl';

    // List of Regions we'll let clicks through for
    var enabledRegions = ['mo', 'fl', 'or'];

    map = jQuery('#vmap15').vectorMap({
        map: 'usa_en',
        color: '#ff2e44',
        borderColor: '#fff',
        backgroundColor: '#fff',
        enableZoom: true,
        showTooltip: true,
        selectedColor: '#333333',
        selectedRegions: ['fl'],
        hoverColor: null,
        colors: {
            mo: '#C9DFAF',
            fl: '#C9DFAF',
            or: '#C9DFAF'
        },
        onRegionClick: function (event, code, region) {
            // Check if this is an Enabled Region, and not the current selected on
            if (enabledRegions.indexOf(code) === -1 || currentRegion === code) {
                // Not an Enabled Region
                event.preventDefault();
            } else {
                // Enabled Region. Update Newly Selected Region.
                currentRegion = code;
            }
        },
        onRegionSelect: function (event, code, region) {
            console.log(map.selectedRegions);
        },
        onLabelShow: function (event, label, code) {
            if (enabledRegions.indexOf(code) === -1) {
                event.preventDefault();
            }
        }
    });
});