$(function() {
    const importFile = $('#excelFileName').val() + '.xlsx';
    const importFilPath = 'temp/importUpload/' + importFile;

    $('#downloadImportUploadFile').on('click')
    .attr('href', importFilPath)
    .attr('download', importFile);

    document.getElementById('downloadImportUploadFile').click();
    window.location.href = ("./importUpload/index");
});