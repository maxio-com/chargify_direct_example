$(function() {
  $( "#signup_form" ).submit(function(e) {
    event.preventDefault();
    $.ajax({
      url: $("#signup_form").attr('action'),
      type: "post",
      data: $("#signup_form").serialize(),
      dataType: "js",
      crossDomain: true,
      headers: { "X-Requested-With": "XMLHttpRequest" },
      success: function(data)
      {
        console.log(data);
      } 
    });
  });
});
