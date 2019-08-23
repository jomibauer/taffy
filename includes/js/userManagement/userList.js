var lastToken = "";

$("#inpUserSearch").bind("keyup", function(e){
    $("#search_loading").show();
    lastToken = new Date().getTime();

    var usersTableBody = $("#usersTable > tbody:last");

    $.ajax( {
        "dataType": 'json',
        "type": 'GET',
        "url": PAGE.xeh.ajaxSearchUsers,
        "data": {"token":lastToken,"q":this.value},
        "success": function(e) {
            $("#search_loading").hide();
            if(e === false){
                alert("something went wrong!");

            } else {
                if (e.token == lastToken){
                    usersTableBody.children().remove();
                    var data = $(e.data);
                    if ( data.length ) {
                        data.each(function(index, elem){
                            var output = '<tr><td><a href="' + PAGE.xeh.userDetail + elem.userID +'">' + elem.username + '</a></td><td><a href="' + PAGE.xeh.userDetail + elem.userID +'">' + elem.email + '</a></td><td>' + elem.name + '</td><td style="text-align:center;">';
                            if ( elem.isActive ) {
                                output += '<span class="label label-success">Active</span>'
                            } else {
                                output += '<span class="label label-danger">Inactive</span>'
                            }

                            output += '</td><td>';

                            if ( elem.isLocked ) {
                                output += '<span class="label label-success">Locked</span>'
                            } else {
                                output += '&nbsp;'
                            }

                            output += '</td><td>' + elem.passwordLastSetOn;
                            if ( elem.isPasswordExpired ) {
                                output +=' <span class="label label-danger">Expired</span>';
                            }
                            output += '</td><td>' + elem.lastLoggedInOn;
                            output += '</td></tr>';

                            usersTableBody.append(output);
                        });
                    } else {
                        usersTableBody.append('<tr><td colspan="7"><em>No users found matching that search.</em></td></tr>');
                    }
                }
            }
        },
        "timeout": 15000,
        "error": function(e) {
            $("#search_loading").hide();
        }
    });

});