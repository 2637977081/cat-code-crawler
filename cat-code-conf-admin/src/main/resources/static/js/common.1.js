$(function(){
	
	// scrollup
	$.scrollUp({
		animation: 'fade',	// fade/slide/none
		scrollImg: true
	});

    // 左侧菜单状态，js + 后端 + cookie方式（新）
    $('.sidebar-toggle').click(function(){
        var adminlte_settings = $.cookie('adminlte_settings');	// 左侧菜单展开状态[adminlte_settings]：on=展开，off=折叠
        if ('off' == adminlte_settings) {
            adminlte_settings = 'on';
        } else {
            adminlte_settings = 'off';
        }
        $.cookie('adminlte_settings', adminlte_settings, { expires: 7 });	//$.cookie('the_cookie', '', { expires: -1 });
    });
    // 左侧菜单状态，js + cookie方式（遗弃）
    /*
    var adminlte_settings = $.cookie('adminlte_settings');
    if (adminlte_settings == 'off') {
        $('body').addClass('sidebar-collapse');
    }
    */

	// logout
	$("#logoutBtn").click(function(){

        layer.confirm( "确认注销登录?" , {
            icon: 3,
            title: '系统提示' ,
            btn: [ '确定', '取消' ]
        }, function(index){
            layer.close(index);

            $.post(base_url + "/logout", function(data, status) {
                if (data.code == 200) {
                    layer.msg( '注销成功' );

                    setTimeout(function(){
                        window.location.href = base_url + "/";
                    }, 500);
                } else {
                    layer.open({
                        icon: '2',
                        content: (data.msg||'注销失败')
                    });
                }
            });

        });

	});
	
	// update pwd
    $('#updatePwd').on('click', function(){
        $('#updatePwdModal').modal({backdrop: false, keyboard: false}).modal('show');
    });
    var updatePwdModalValidate = $("#updatePwdModal .form").validate({
        errorElement : 'span',
        errorClass : 'help-block',
        focusInvalid : true,
        rules : {
            password : {
                required : true ,
                rangelength:[4,50]
            }
        },
        messages : {
            password : {
                required : '请输入密码'  ,
                rangelength : "密码长度限制为4~50"
            }
        },
        highlight : function(element) {
            $(element).closest('.form-group').addClass('has-error');
        },
        success : function(label) {
            label.closest('.form-group').removeClass('has-error');
            label.remove();
        },
        errorPlacement : function(error, element) {
            element.parent('div').append(error);
        },
        submitHandler : function(form) {
            $.post(base_url + "/user/updatePwd",  $("#updatePwdModal .form").serialize(), function(data, status) {
                if (data.code == 200) {
                    $('#updatePwdModal').modal('hide');

                    layer.msg( '修改密码成功，即将注销登陆' );
                    setTimeout(function(){
                        $.post(base_url + "/logout", function(data, status) {
                            if (data.code == 200) {
                                window.location.href = base_url + "/";
                            } else {
                                layer.open({
                                    icon: '2',
                                    content: (data.msg||'注销失败')
                                });
                            }
                        });
                    }, 500);
                } else {
                    layer.open({
                        icon: '2',
                        content: (data.msg||'修改密码失败')
                    });
                }
            });
        }
    });
    $("#updatePwdModal").on('hide.bs.modal', function () {
        $("#updatePwdModal .form")[0].reset();
        updatePwdModalValidate.resetForm();
        $("#updatePwdModal .form .form-group").removeClass("has-error");
    });

    // 切换Env
    $('.changeEnv').click(function(){
        var env = $(this).attr('env');
        $.cookie('XXL_CONF_CURRENT_ENV', env, { expires: 7 });	//$.cookie('the_cookie', '', { expires: -1 });

        window.location.reload();
    });
	
});
