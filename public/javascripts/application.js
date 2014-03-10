$(function() {
  $( "#signup_form" ).submit(function(e) {
    e.preventDefault();
    console.log($("#signup_form").serialize());
    $.ajax({
      url: $("#signup_form").attr('action'),
      type: "POST",
      headers: { accept: 'application/json' },
      crossDomain: true,
      dataType: "json",
      data: $("#signup_form").serialize(),
      error: function(xhr, textStatus, error) {
        console.dir(JSON.parse(xhr.responseText));
        console.log(textStatus);
        console.log(error);
      },
      success: function(data) {
        console.dir(data);
      }
    });
  });
});
