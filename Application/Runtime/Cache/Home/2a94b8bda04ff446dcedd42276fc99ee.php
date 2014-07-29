<?php if (!defined('THINK_PATH')) exit();?><html>
 <head>
   <title><?php echo ($index_title); ?></title>
    <link rel="stylesheet" type="text/css" href="/tcs/Public/ext-2.0.2/resources/css/ext-all.css"/>
    <script type="text/javascript" src="/tcs/Public/ext-2.0.2/adapter/ext/ext-base.js"></script>
    <script type="text/javascript" src="/tcs/Public/ext-2.0.2/ext-all.js"></script>
<style type="text/css">
    html, body {
        font:normal 12px verdana;
        margin:0;
        padding:0;
        border:0 none;
        overflow:hidden;
        height:100%;
    }
    p {
        margin:5px;
    }
    .settings {
        background-image:url(/tcs/Public/ext-2.0.2/examples/shared/icons/fam/folder_wrench.png);
    }
    .nav {
        background-image:url(/tcs/Public/ext-2.0.2/examples/shared/icons/fam/folder_go.png);
    }
    .tcs_menu_item{
        text-align: left;
        padding: 0 0 0 10px;
        margin: 3px 5px;
        font-size: 12px;
    }
</style>
<script type="text/javascript">
    Ext.onReady(function(){

        Ext.state.Manager.setProvider(new Ext.state.CookieProvider());
        
        var main_tab_panel = new Ext.TabPanel({
            region:'center',
            deferredRender:false,
            activeTab:0,
            defaults: {autoScroll:true},
            enableTabScroll: true,
            items:[{
                contentEl:'tcs_main_panel_sys_summary',
                title: '系统概况',
                autoScroll:true
            },{
                contentEl:'tcs_main_panel_area_info',
                title: '区域信息',
                closable:true,
                autoScroll:true
            },{
                contentEl:'tcs_main_panel_node_info',
                title: '节点信息',
                closable:true,
                autoScroll:true
            },{
                contentEl:'tcs_main_panel_acc_info',
                title: '账户信息',
                closable:true,
                autoScroll:true
            },{
                contentEl:'tcs_main_panel_acc_add',
                title: '账户添加',

                autoScroll:true
            },{
                contentEl:'tcs_main_panel_acc_modify',
                title: '账户修改',
                closable:true,
                autoScroll:true
            },{
                contentEl:'tcs_main_panel_my_info',
                title: '个人资料',
                closable:true,
                autoScroll:true
            },{
                contentEl:'tcs_main_panel_info_modify',
                title: '资料修改',
                closable:true,
                autoScroll:true
            },{
                contentEl:'tcs_main_panel_password_modify',
                title: '密码修改',
                closable:true,
                autoScroll:true
            }]
        })

        var viewport = new Ext.Viewport({
            layout:'border',
            items:[
                new Ext.BoxComponent({ // raw
                    region:'north',
                    el: 'north',
                    height:32
                }),{
                    region:'west',
                    id:'menu-panel',
                    title:'菜单',
                    split:true,
                    width: 100,
                    minSize: 85,
                    maxSize: 400,
                    collapsible: true,
                    margins:'0 0 0 5',
                    layout:'accordion',
                    layoutConfig:{
                        animate:true
                    },
                    items: [{
                        contentEl: 'tcs_menu_info',
                        title:'系统概况',
                        border:false,
                        iconCls:'nav'
                    },{
                        contentEl: 'tcs_menu_acc',
                        title:'账户管理',
                        border:true,
                        iconCls:'nav'
                    },{
                        contentEl: 'tcs_menu_mine',
                        title:'我的账户',
                        border:false,
                        iconCls:'settings'
                    }]
                },
                main_tab_panel
             ]
        });
    });
    </script>


 </head>

 <body>


  <div id="tcs_menu_info">
        <div class="tcs_menu_item" id="tcs_menu_item_sys_summary">系统概况</div>
        <div class="tcs_menu_item" id="tcs_menu_item_area_info">区域信息</div>
        <div class="tcs_menu_item" id="tcs_menu_item_node_info">节点信息</div>
  </div>
  <div id="tcs_menu_acc">
        <div class="tcs_menu_item" id="tcs_menu_item_acc_info">账户信息</div>
        <div class="tcs_menu_item" id="tcs_menu_item_acc_add">账户添加</div>
        <div class="tcs_menu_item" id="tcs_menu_item_acc_modify">账户修改</div>
  </div>
  <div id="tcs_menu_mine">
        <div class="tcs_menu_item" id="tcs_menu_item_my_info">我的资料</div>
        <div class="tcs_menu_item" id="tcs_menu_item_info_modify">资料修改</div>
        <div class="tcs_menu_item" id="tcs_menu_item_password_modify">密码修改</div>
  </div>

  <div id="north">
    <img src="" style="margin:5px" width="25px" height="25px"/>
    <span style="font-size:30px;"><?php echo ($system_name); ?></span>
  </div>

  <div id="tcs_main_panel_sys_summary">正在加载系统概况模块……</div>
  <div id="tcs_main_panel_area_info">正在加载区域信息模块……</div>
  <div id="tcs_main_panel_node_info">正在加载节点概况模块……</div>
  <div id="tcs_main_panel_acc_info">正在加载账户信息模块……</div>
  <div id="tcs_main_panel_acc_add">正在加载账户添加修改模块……</div>
  <div id="tcs_main_panel_acc_modify">正在加载账户修改模块……</div>
  <div id="tcs_main_panel_my_info">正在加载个人资料模块……</div>
  <div id="tcs_main_panel_info_modify">正在加载资料修改模块……</div>
  <div id="tcs_main_panel_password_modify">正在加载密码修改模块……</div>

  <div id="props-panel" style="width:200px;height:200px;overflow:hidden;">
  </div>


 </body>
</html>