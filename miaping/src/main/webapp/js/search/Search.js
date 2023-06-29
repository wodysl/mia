// View in Full Page Mode!

// Script for the dual URL search function.
// Useful for intranet searches that require
// prefixes and suffixes to your query.
//
// function gsearch(pref, suff) {
//   userInput = document.getElementById('searchtext').value;
//   window.open(pref + userInput + suff);
// }

function gsearch(pref) {
  userInput = document.getElementById('searchtext').value;
  window.open(pref + userInput);
}

// Function to detect enter keydown.
// Requires jQuery.

$(document).ready(function() {

  $("#searchtext").bind("keydown", function(event) {
    var keycode = (event.keyCode ? event.keyCode : (event.which ? event.which : event.charCode));
    if (keycode == 13) {
      document.getElementById('searchbutton').click();
      return false;
    } else {
      return true;
    }
  });
});