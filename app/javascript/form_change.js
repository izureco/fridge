$(document).on("click", ".add-btn", function() {
  $("td").parent().clone(true).insertAfter($("td").parent());
  // $(this).parent(".item-tr").clone(true).insertAfter($(this).parent());
});
$(document).on("click", ".del-btn", function() {
  var target = $(this).parent();
  if (target.parent("td").children().length > 1) {
      target.remove();
  }
});