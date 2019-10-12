$(function(){
	// 复选框
    $('input').iCheck({
      checkboxClass: 'icheckbox_square-blue',
      radioClass: 'iradio_square-blue',
      increaseArea: '20%' // optional
    });
    
	// 登陆.规则校验
	var loginFormValid = $("#loginForm").validate({
		errorElement : 'span',  
        errorClass : 'help-block',
        focusInvalid : true,  
        rules : {  
        	userName : {  
        		required : true ,
                minlength: 4,
                maxlength: 50
            },  
            password : {  
            	required : true ,
                minlength: 4,
                maxlength: 50
            } 
        }, 
        messages : {  
        	userName : {  
                required :"请输入登陆账号."  ,
                minlength:"登陆账号不应低于4位",
                maxlength:"登陆账号不应超过50位"
            },  
            password : {
            	required :"请输入登陆密码."  ,
                minlength:"登陆密码不应低于4位",
                maxlength:"登陆密码不应超过50位"
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
			$.post(base_url + "/login", $("#loginForm").serialize(), function(data, status) {
                if (data.code == 200) {
                    layer.msg( '登陆成功' );
                    setTimeout(function(){
                        window.location.href = base_url;
                    }, 500);
                } else {
                    layer.open({
                        icon: '2',
                        content: (data.msg||'登陆失败')
                    });
                }
			});
		}
	});
});