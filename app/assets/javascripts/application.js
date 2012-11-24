// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.sortable
//= require handlebars
//= require ember
//= require ember-data
//= require_self
//= require edge_agility
EdgeAgility = Ember.Application.create({
  ready: function(){
    console.log("Created App namespace");
  }
});
EdgeAgility.displayError = function(e) {
  if (typeof e === 'string') {
    // display error strings
    alert(e);
  }
  else if (typeof e === 'object' && e.responseText !== undefined) {
    // TODO - further process json errors
    alert(e.responseText);
  }
  else {
    alert("An unexpected error occurred.");
  }
};

//= require_tree .
