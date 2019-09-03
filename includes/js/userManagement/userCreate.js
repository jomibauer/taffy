

$("#username").bind("change blur", function(e){
    $("#username_loading").show();
    $("#username_ok").hide();
    $("#username_warning").hide();
    $("#username_invalid").hide();
    $("#username_serverSideErrorMessage").hide();
    $("#username-form-group").removeClass("has-error");

    if ( this.value.length === 0 ) {
        $("#username_loading").hide();
        $("#username_invalid").show();
        $("#username-form-group").addClass("has-error");
        return false;
    }

    $.ajax( {
        "dataType": 'json',
        "type": 'POST',
        "url": PAGE.xeh.ajaxIsUsernameAvailable,
        "data": {"userID": PAGE.userID, "username":this.value},
        "success": function(e) {
            //console.log(e);
            if(e == true){
                $("#username_loading").hide();
                $("#username_ok").show();
                $("#username_warning").hide();
            } else {
                $("#username_loading").hide();
                $("#username_ok").hide();
                $("#username_warning").show();
                $("#username-form-group").addClass("has-error");
            }
        },
        "timeout": 15000,
        "error": function(e) {
            $("#username-form-group").addClass("has-error");
        }
    });

});

$("#email").bind("change blur", function(e){
    $("#email_loading").show();
    $("#email_ok").hide();
    $("#email_warning").hide();
    $("#email_serverSideErrorMessage").hide();
    $("#email_invalid").hide();
    $("#email-form-group").removeClass("has-error");

    if ( !validateEmail(this.value) ) {
        $("#email_loading").hide();
        $("#email_invalid").show();
        $("#email-form-group").addClass("has-error");
        return false;
    }

    $.ajax( {
        "dataType": 'json',
        "type": 'POST',
        "url": PAGE.xeh.ajaxIsEmailAvailable,
        "data": {"userID": PAGE.userID, "email":this.value},
        "success": function(e) {
            //console.log(e);
            if(e == true){
                $("#email_loading").hide();
                $("#email_ok").show();
                $("#email_warning").hide();
            } else {
                $("#email_loading").hide();
                $("#email_ok").hide();
                $("#email_warning").show();
                $("#email-form-group").addClass("has-error");
            }
        },
        "timeout": 15000,
        "error": function(e) {
            $("#username-form-group").addClass("has-error");
        }
    });

});

function validateEmail(email) {
  var emailReg = /^([\w-\+\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
  if( email.length == 0 || !emailReg.test( email ) ) {
    return false;
  } else {
    return true;
  }
}

$("#generatePassword").change(function(e) {
    $("#passwordQuestionsWell").toggle($(e.target).val() === "false");
});


$("#showPasswordText").change(function(e){
    $(".passwordInput").attr("type", this.checked ? "text" : "password");
});

$(".passwordInput").bind("change blur", validatePasswords);

function validatePasswords() {
    if ( $("#password").val() === $("#password2").val() ) {
        $(".passwordInputFormGroup").removeClass("has-error");
        $(".passwordsDontMatchErrorMessage").hide();
        return true;
    } else {
        $(".passwordInputFormGroup").addClass("has-error");
        $(".passwordsDontMatchErrorMessage").show();
        return false;
    }
}

$("#requireUserToChangePassword").change(togglePasswordClearTextWarning);
$("#sendLoginInstructions").change(togglePasswordClearTextWarning);

function togglePasswordClearTextWarning () {
    var sendLoginInstructionsChecked = $("#sendLoginInstructions").is(':checked'),
        requireUserToChangePasswordChecked = $("#requireUserToChangePassword").is(':checked');

    $("#passwordClearTextWarning").toggle(!requireUserToChangePasswordChecked && sendLoginInstructionsChecked);
}

// @jquery-autocomplete (<- search for this tag to find other places where jquery-autocomplete is being documented)
// This is the actual autocomplete call.  The only actual requirement is that you provide a source, everything else is optional.
// You can find more info here if you need it: http://api.jqueryui.com/autocomplete/
// Below this we have special behavior that has been added to suit our needs for this form.

$("#state").autocomplete({
      source: PAGE.statesArray
    , response: function(event, ui) {
        // here we provide a response callback (more info found in the link above)
        // all we want to do here is set some things that we will care about when they blur out of the input
        PAGE.numStateMatches = ui.content.length;
        if (PAGE.numStateMatches === 1) {
            PAGE.stateMatch = ui.content[0];
        }
    }
});

function setStateAndClearErrors(stateValue) {
    $('#state').val(stateValue);
    $('#state_valid').show();
    $('#state_invalid').hide();
    $('#state-form-group').removeClass('has-error');
    $('#createAccountSubmitButton').removeClass('disabled');
}

$("#state").bind("blur", function() {

    if (PAGE.numStateMatches === 1) {
        // if they blur and the number of matches in the autocomplete search is exactly 1
        // we want to set that as the value of the input and clear the errors for them
        setStateAndClearErrors(PAGE.stateMatch.value);
        return;
    } 

    var thisValue = $(this).val().toLowerCase();

    if (thisValue.length === 0) {
        // if they blur and the length of their input is 0 they probably don't want to input a state
        // the field is not required, so we don't care.
        setStateAndClearErrors("");
        return;
    }

    var state = PAGE.statesArray.find(state => {
        // we want to see if there is an exact match between their input and either
        // the label (which is the state's name) or on the value (which is the state's two-character code)
        if (thisValue === state.label.toLowerCase() || thisValue === state.value.toLowerCase()) {
            return true;
        }
    });

    if(state !== undefined) {
        // if we found an exact match, set that as the value and clear the errors for them
        setStateAndClearErrors(state.value);
        return;
    }

    // otherwise, they have a bad state input, so we can just show the error and disable the submit
    $('#state_valid').hide();
    $('#state_invalid').show();
    $('#createAccountSubmitButton').addClass('disabled');
    $('#state-form-group').addClass('has-error');
});
// end @jquery-autocomplete

$(function(){
    $('#username').focus();
    $("#generatePassword").change();
});
