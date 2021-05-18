$(function() {
    const importFile = $('#excelFileName').val() + '.xlsx';
    const importFilePath = 'temp/importUpload/' + importFile;

    $('#downloadImportUploadFile').on('click')
    .attr('href', importFilePath)
    .attr('download', importFile);

    document.getElementById('downloadImportUploadFile').click();
    window.location.href = ("./importUpload/index");
});