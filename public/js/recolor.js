Dropzone.options.drop = {
  paramName: 'svg',
  acceptedFiles: 'image/svg+xml',
  dictDefaultMessage: 'Now drag black SVGs here',
  thumbnailWidth: 64,
  thumbnailHeight: 64,
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
}

// From clrs.cc
var PALETTE = [  
  ['#dddddd', '#aaaaaa'],
  ['#001f3f', '#ffdc00'],
  ['#0074d9', '#ff851b'],
  ['#7fdbff', '#ff4136'],
  ['#39cccc', '#85144b'],
  ['#3d9970', '#f012be'],
  ['#2ecc40', '#b10dc9'],
  ['#01ff70', '#111111'],
];
var PALETTE_FLATTENED = [].concat.apply([], PALETTE);

$(document).ready(function () {
  
  var random_color = PALETTE_FLATTENED[Math.floor(Math.random() * PALETTE_FLATTENED.length)];
  $('#color').spectrum({
    color: random_color,
    showPalette: true,
    showInput: true,
    preferredFormat: 'hex',
    palette: PALETTE,
    clickoutFiresChange: true,
    showButtons: false,
    change: function (color) {
      $('input[name="color"]').val(color);
    }
  });
  $('input[name="color"]').val(random_color);
  
});
