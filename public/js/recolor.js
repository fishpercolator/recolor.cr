Dropzone.autoDiscover = false;

// From clrs.cc
var PALETTE = [
  ['#dddddd', '#aaaaaa', '#111111'],
  ['#001f3f', '#0074d9', '#7fdbff'],
  ['#3d9970', '#2ecc40', '#01ff70'],
  ['#ffdc00', '#ff851b', '#ff4136'],
  ['#85144b', '#f012be', '#b10dc9'],
];
var PALETTE_FLATTENED = [].concat.apply([], PALETTE);

function init_spectrum() {
  var random_color = PALETTE_FLATTENED[Math.floor(Math.random() * PALETTE_FLATTENED.length)];
  $('#color').spectrum({
    color: random_color,
    showPalette: true,
    showInput: true,
    preferredFormat: 'hex',
    palette: PALETTE,
    clickoutFiresChange: true,
    showButtons: true,
    maxSelectionSize: 3,
    change: function (color) {
      $('input[name="color"]').val(color);
    }
  });
  $('input[name="color"]').val(random_color);
}

function init_dropzone() {
  new Dropzone("form#drop", {
    paramName: 'svg',
    acceptedFiles: 'image/svg+xml',
    dictDefaultMessage: 'Now drag black SVGs here',
    thumbnailWidth: 64,
    thumbnailHeight: 64,
    maxFilesize: 1, // up to 1MB allowed 
    init: function() {
      this.on('success', function (file, response) {
        var output = $('<div class="output"></div>');
        var img = $('<img/>').attr({src: response.data});
        var link = $('<a></a>').attr({download: response.filename, href: response.data}).text(response.filename);
        output.append(img).append(link);
        $('#response').append(output);
        setTimeout(function () {
          $(file.previewElement).fadeOut();
        }, 1000);
      });
    }
  });
}

$(document).on('turbolinks:load', function () {
  init_spectrum();
  init_dropzone();
});
