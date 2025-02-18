function jpostal() {
  console.log("postal.js loaded");
  $('#zipcode').jpostal({
    postcode : ['#zipcode'],
    address : {
      '#place_address': '%3%4%5'
    }
  });
}
$(document).on("turbolinks:load", jpostal);