<?php if (!defined('THINK_PATH')) exit();?><html>
 <head>
   <title><?php echo ($title); ?></title>
    <link rel="stylesheet" type="text/css" href="/tcs/Public/ext-2.0.2/resources/css/ext-all.css"/>
    <script type="text/javascript" src="/tcs/Public/ext-2.0.2/adapter/ext/ext-base.js"></script>
    <script type="text/javascript" src="/tcs/Public/ext-2.0.2/ext-all.js"></script>
 </head>
 <body style="background-color:#DDDDDD">
<script type="text/javascript">

Ext.onReady(function(){

    Ext.QuickTips.init();

    // turn on validation errors beside the field globally
    Ext.form.Field.prototype.msgTarget = 'side';//'qtip';//'under';

    //var bd = Ext.getBody();

    /*
     * ================  Simple form  =======================
     */
    //bd.createChild({tag: 'h2', html: 'Form 1 - Very Simple'});

    var simple = new Ext.FormPanel({
        labelWidth: 75, // label settings here cascade unless overridden
        //url:'login_validate.php',
        frame:true,
        title: '<?php echo ($title); ?>',
        style:'margin:auto;padding:150px 0 0;',
        width: 350,
        defaults: {width: 230},
        defaultType:'textfield',
        layout:"form",
        submit:function(){
        	this.getEl().dom.action = "login_validate";
        	this.getEl().dom.method = "post";
        	this.getEl().dom.submit();
        },
        items: [{
                fieldLabel: '账号',
                id:'uid',
                name: 'uid',
                allowBlank:false,
                blankText:'请输入账号'
            },{
                fieldLabel: '密码',
                id:'password',
                name: 'password',
                allowBlank:false,
                inputType:'password',
                blankText:'请输入密码'
            }
        ],

        buttons: [{
            text: '登录',
            handler:tlogin
        },{
            text: '清除',
            handler:function(){ }
        }]
    });

    simple.render(document.body);
    function tlogin(){
    	simple.form.submit();
    }

});
</script>
 </body>
</html>