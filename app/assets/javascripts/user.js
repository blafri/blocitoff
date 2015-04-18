// For the SignUp page do field validation
// before submitting
$( document ).ready(function() {
  $( '.controller-registrations #sign-up-form' ).submit(function() {
    var formGood = true;
    var errorArray = [];
    
    //reset all errors on the form
    resetErrorsOnFormItems('#sign-up-form')

    // A first name must be present
    if ( !$( '#user_first_name' ).val() ) {
      setErrorOnFormItems( '#user_first_name' );
      formGood = false;
      errorArray.push('First name is required.')
    }
    
    // A last name must be present
    if ( !$( '#user_last_name' ).val() ) {
      setErrorOnFormItems( '#user_last_name' );
      formGood = false;
      errorArray.push('Last name is required.')
    }
    
    // An email must be formated properly
    if ( !isValidEmailAddress($('#user_email').val()) ) {
      setErrorOnFormItems( '#user_email' );
      formGood = false;
      errorArray.push('Please enter a valid email address.')
    }
    
    // A Password must have a minium of 8 caracters
    if ( $( '#user_password' ).val().length < 8 ) {
      setErrorOnFormItems( '#user_password' );
      formGood = false;
      errorArray.push('Password must be at least 8 caracters.')
    }

    if ( !formGood ) {
      setErrorMsgsOnForm('#form-messages', errorArray)
    }
    
    return formGood;
  });
});

$( document ).ready( function() {
  $( '.controller-sessions #new_user' ).submit(function() {
    var formGood = true;
    var errorArray = [];
    
    //reset all errors on the form
    resetErrorsOnFormItems('#new_user')
    
    // An email must be formated properly
    if ( !isValidEmailAddress($('#user_email').val()) ) {
      setErrorOnFormItems( '#user_email' );
      formGood = false;
      errorArray.push('Please enter a valid email address.')
    }
    
    // A password must be present
    if ( !$( '#user_password' ).val() ) {
      setErrorOnFormItems( '#user_password' );
      formGood = false;
      errorArray.push('A password must be present')
    }
    
    if ( !formGood ) {
      setErrorMsgsOnForm('#form-messages', errorArray)
    }
    
    return formGood;
  });
});