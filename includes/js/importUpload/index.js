$(function () {
  const templateFile = 'companyDummyTemplate.xlsx';
  const templateFilPath = 'templates/companyDummyTemplate.xlsx';

  $('#downloadImportUploadTemplate').on('click')
  .attr('href', templateFilPath)
  .attr('download', templateFile);

  $('#importBtn').show();
  $('#importLoading').hide();

  $('#importBtn').on('click', function() {
    $('#importBtn').hide();
    $('#importLoading').show();
  });

  $('input[name="fileUpload"]').on('change', function() {
    if (this.files[0] != undefined && this.files[0].size >= 20000000) {
      $('#sizeAlertContainer').show();
    } else {
      $('#sizeAlertContainer').hide();
      $('#importBtn').on('click', function(e){
        $('#importBtn').hide();
        $('#importLoading').show();
      })
    }
  });

});