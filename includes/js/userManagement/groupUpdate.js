$("#groupDesc").bind("change blur", function(e){
    $("#groupDesc_loading").show();
    $("#groupDesc_serverSideErrorMessage").hide();
    $("#groupDesc_required").hide();
    $("#groupDesc-form-group").removeClass("has-error");

    if ( this.value.length == 0 ) {
        $("#groupDesc_required").show();
        $("#groupDesc_loading").hide();
        $("#groupDesc-form-group").addClass("has-error");
        return false;
    }
});

$(function(){
    $("#groupDesc").focus();
});