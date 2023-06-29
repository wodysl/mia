$(document).ready(function(){
  function remove() {
    $(".red").click(function(){
      $(this).closest("tr").remove();
    });
  }
  remove();
  $(".add-form").on('submit', function(e){
    e.preventDefault();
    if($("input[name=name]").val(), $("input[name=name]").val(), $("input[name=name]").val() == "") {
      $(".alert").addClass("active");
      $(".remove").click(function(){
        $(".alert").removeClass("active");
      });
    } else {
      var name = $("input[name=name]").val();
      var surname = $("input[name=surname]").val();
      var email = $("input[name=email]").val();
      $(".first-tr").after('<tr><td></td><td>'+name+'</td><td>'+surname+'</td><td>'+email+'</td><td class="static"><span class="button red"><i class="glyphicon glyphicon-remove"></i></span></td></tr>');
      remove();
      $("input[name=name], input[name=surname], input[name=email]").val("");   
    }
  });
});