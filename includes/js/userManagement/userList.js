$(function() {

    function setDataTable() {
        $("#usersTable").DataTable({
            'info': false
            , 'searching': true
            , 'lengthChange': false
            , 'pageLength': 20
            , 'language': {
                'search': ''
                , 'searchPlaceholder': 'Filter'
            }
            , 'initComplete': applyDetailAnchors()
            , 'dom': '<"d-flex float-left dataTableFilter"f>t<"d-flex justify-content-center"p>'
        });
    }

    function applyDetailAnchors() {
        $('.clickable').on('click', function() {
            window.location = $(this).data("href");
        });
    }

    setDataTable();
});