let formatter = new Intl.NumberFormat('en-US', {
  style: 'currency',
  currency: 'USD'
});

function updateQuantity(me, id, price, maxQuantity) {
  $.ajax({
    url: '/cart_items/',
    type: 'get',
    dataType: 'text',
    success: () => {
      var cart = $('#cart_item_' + id.toString());
      var sub_total = $('#cart_item_total_' + id.toString());
      var qty_field = cart.children('form').children('#cart_item_quantity');
      var qty_text = cart.children('div.btn');
      if ($(me).hasClass('btn-danger')) {
        if (parseInt(qty_field[0].value) > 0) {
          qty_text.html(qty_field[0].value);
          qty_field[0].value = parseInt(qty_field[0].value)-1;
          qty_field[1].value = parseInt(qty_field[1].value)-1;
          $('#cart_item_'+ id.toString() +' :input[type="submit"].btn.btn-primary').removeClass('d-none').addClass('d-block');
        }
        if (parseInt(qty_field[0].value) > maxQuantity) {
          qty_text.html(maxQuantity);
          qty_field[0].value = maxQuantity-1;
          qty_field[1].value = maxQuantity+1;
        }
      }
      if ($(me).hasClass('btn-primary')) {
        if (parseInt(qty_field[1].value) <= (maxQuantity + 1)) {
          qty_text.html(qty_field[1].value);
          qty_field[0].value = parseInt(qty_field[0].value)+1;
          qty_field[1].value = parseInt(qty_field[1].value)+1;
          $('#cart_item_'+ id.toString() +' :input[type="submit"].btn.btn-danger').removeClass('d-none').addClass('d-block');
        }
      }
      sub_total.html(formatter.format(parseInt(cart.children('div.btn').html()) * price));
      if (parseInt(qty_text.html()) == 1) {
        $('#cart_item_'+ id.toString() +' :input[type="submit"].btn.btn-danger').removeClass('d-block').addClass('d-none');
      }
      if (parseInt(qty_text.html()) == maxQuantity) {
        $('#cart_item_'+ id.toString() +' :input[type="submit"].btn.btn-primary').removeClass('d-block').addClass('d-none');
      }
    }
  })
}

document.addEventListener('turbolinks:load', function () {
  $input = $('[data-behavior="autocomplete"]');

  var options = {
    getValue: 'name',
    url: function (phrase) {
      return '/products/search.json?keyword=' + phrase;
    },
    categories: [
      {
        listLocation: 'products',
        header: '<strong>Products</strong>',
      },
    ],
    list: {
      onChooseEvent: function () {
        var url = $input.getSelectedItemData().url;
        $input.val('');
        Turbolinks.visit(url);
      },
    },
  };

  $input.easyAutocomplete(options);
});
