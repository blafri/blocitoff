// Function to set error classes on individual form elements
function setErrorOnFormItems(itemClass) {
  $( itemClass ).parent().addClass( "has-error has-feedback" );
  $( itemClass ).parent().append( '<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>' );
}

// Test an email address
function isValidEmailAddress(emailAddress) {
    var pattern = new RegExp(/^(("[\w-+\s]+")|([\w-+]+(?:\.[\w-+]+)*)|("[\w-+\s]+")([\w-+]+(?:\.[\w-+]+)*))(@((?:[\w-+]+\.)*\w[\w-+]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][\d]\.|1[\d]{2}\.|[\d]{1,2}\.))((25[0-5]|2[0-4][\d]|1[\d]{2}|[\d]{1,2})\.){2}(25[0-5]|2[0-4][\d]|1[\d]{2}|[\d]{1,2})\]?$)/i);
    return pattern.test(emailAddress);
};

// Reset form errors
function resetErrorsOnFormItems(formID) {
  $( formID ).children().removeClass( 'has-error has-feedback' );
  $( formID ).find( '.form-control-feedback' ).remove();
  $( formID ).find( '.alert').remove();
}

// Add error messages to form
function setErrorMsgsOnForm(msgContainer, errors) {
  messages = errors.map( function(value) {
    return "<li>" + value + "</li>";
  }).join("\n");
  
  html = "<div class='alert alert-danger text-center'>\n" +
    "<ul class='list-unstyled'>\n" +
    messages + "\n" +
    "</ul>\n" +
    "</div>";
  
  $( msgContainer ).append( html );
}

// Close the flash messages after 5 seconds
$( document ).ready( function() {
  if ( $( '#flash-notice' ).length ) {
    window.setTimeout(function() {
      $( '#flash-notice' ).alert('close');
    }, 5000);
  }
});