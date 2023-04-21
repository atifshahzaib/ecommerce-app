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
//= require cloudinary
//= require popper
//= require rails-ujs
//= require bootstrap-sprockets
//= require activestorage
//= require turbolinks
//= require_tree .


// Input an image and then preview
function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      $('#img_prev').attr('src', e.target.result)
    };

    reader.readAsDataURL(input.files[0]);
  }
}

var files, filesLength, setIndex;

// Input multiple images and prewiew with remove btn
$(document).ready(function() {
  if (window.File && window.FileList && window.FileReader) {
    $("#add_product_images").on("change", function(e) {
      files = e.target.files, filesLength = files.length;
      for (var i = 0; i < filesLength; i++) {
        var f = files[i];
        var fileReader = new FileReader();
        $('.pip').remove();
        fileReader.onload = (function(e, i) {
          var file = e.target;
          $(
            "<span class=\"pip\">" +
              "<img class=\"imageThumb\" src=\"" +
              e.target.result +
              "\" title=\"" +
              file.name +
              "\"/>" +
            "</span>"
          ).insertAfter("#add_product_images");

          // Old code here
          // $("<img></img>", {
          //   class: "imageThumb",
          //   src: e.target.result,
          //   title: file.name + " | Click to remove"
          // }).insertAfter("#add_product_images").click(function(){$(this).remove();});

        });
        fileReader.readAsDataURL(f);
      }
    });
  } else {
    alert("Your browser doesn't support to File API")
  }
});
