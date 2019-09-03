$(function() {
	$("#removeBtn").on("click", function() {
		$("#removeCardBody").hide();
		$("#removeCardBodyConfirm").show();
	});

	$("#removeBtnCancel").on("click", function() {
		$("#removeCardBodyConfirm").hide();
		$("#removeCardBody").show();
	});

});