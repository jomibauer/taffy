$(function() {
	$("#groupName").bind("change blur", function(e){
		$("#groupName_loading").show();
		$("#groupName_ok").hide();
		$("#groupName_warning").hide();
		$("#groupName_serverSideErrorMessage").hide();
		$("#groupName_required").hide();
		$("#groupName").removeClass("is-invalid");

		if ( this.value.length == 0 ) {
			$("#groupName_required").show();
			$("#groupName_loading").hide();
			$("#groupName").addClass("is-invalid");
			return false;
		}

		$.ajax( {
			"dataType": 'json',
			"type": 'POST',
			"url": PAGE.xeh.ajaxIsGroupNameAvailable,
			"data": {"vcGroupName":this.value},
			"success": function(e) {
				//console.log(e);
				if (e == true){
					$("#groupName_loading").hide();
					$("#groupName_ok").show();
					$("#groupName_warning").hide();
				} else {
					$("#groupName_loading").hide();
					$("#groupName_ok").hide();
					$("#groupName_warning").show();
					$("#groupName").addClass("is-invalid");
				}
			},
			"timeout": 15000,
			"error": function(e) {
				$("#groupName").addClass("is-invalid");
			}
		});

	});

	$("#groupAbbr").bind("change blur", function(e){
		$("#groupAbbr_loading").show();
		$("#groupAbbr_ok").hide();
		$("#groupAbbr_warning").hide();
		$("#groupAbbr_serverSideErrorMessage").hide();
		$("#groupAbbr_required").hide();
		$("#groupAbbr").removeClass("is-invalid");

		if ( this.value.length == 0 ) {
			$("#groupAbbr_required").show();
			$("#groupAbbr_loading").hide();
			$("#groupAbbr").addClass("is-invalid");
			return false;
		}

		$.ajax( {
			"dataType": 'json',
			"type": 'POST',
			"url": PAGE.xeh.ajaxIsGroupAbbrAvailable,
			"data": {"vcGroupAbbr":this.value},
			"success": function(e) {
				//console.log(e);
				if (e == true){
					$("#groupAbbr_loading").hide();
					$("#groupAbbr_ok").show();
					$("#groupAbbr_warning").hide();
				} else {
					$("#groupAbbr_loading").hide();
					$("#groupAbbr_ok").hide();
					$("#groupAbbr_warning").show();
					$("#groupAbbr").addClass("is-invalid");
				}
			},
			"timeout": 15000,
			"error": function(e) {
				$("#groupAbbr").addClass("is-invalid");
			}
		});

	});

	$("#groupDesc").bind("change blur", function(e){
		$("#groupDesc_loading").show();
		$("#groupDesc_serverSideErrorMessage").hide();
		$("#groupDesc_required").hide();
		$("#groupDesc").removeClass("is-invalid");

		if ( this.value.length == 0 ) {
			$("#groupDesc_required").show();
			$("#groupDesc_loading").hide();
			$("#groupDesc").addClass("is-invalid");
			return false;
		}
	});

	$("#groupName").focus();
});