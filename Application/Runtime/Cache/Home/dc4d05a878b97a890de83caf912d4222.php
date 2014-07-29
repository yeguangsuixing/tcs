<?php if (!defined('THINK_PATH')) exit();?><html>
 <head>
   <title><?php echo ($title); ?></title>

    <link rel="stylesheet" type="text/css" href="/tcs/Public/ext-2.0.2/resources/css/ext-all.css"/>
    <script type="text/javascript" src="/tcs/Public/ext-2.0.2/adapter/ext/ext-base.js"></script>
    <script type="text/javascript" src="/tcs/Public/ext-2.0.2/ext-all.js"></script>
 </head>
 <body>
<script type="text/javascript">

Ext.onReady(function(){

    Ext.QuickTips.init();

    // turn on validation errors beside the field globally
    Ext.form.Field.prototype.msgTarget = 'side';

    //var bd = Ext.getBody();

    /*
     * ================  Simple form  =======================
     */
    //bd.createChild({tag: 'h2', html: 'Form 1 - Very Simple'});


    var simple = new Ext.FormPanel({
        labelWidth: 75, // label settings here cascade unless overridden
        url:'login_validate.php',
        frame:true,
        title: '<?php echo ($title); ?>',
        bodyStyle:'padding:5px 5px 0',
        width: 350,
        defaults: {width: 230},
        defaultType:'textfield',
        items: [{
                fieldLabel: '账号',
                id:'utname'
                name: 'utname',
                allowBlank:false
            },{
                fieldLabel: '密码',
                id:'tpassword',
                name: 'tpassword',
                allowBlank:false,
                inputType:'password'
            }
        ],

        buttons: [{
            text: '登录',
            handler:function(){
            	alert('ddd');
            }
        },{
            text: '清除',
            handler:function(){ }
        }]
    });

    simple.render(document.body);

});
</script>
 </body>
</html>