



var node_edit_window;
function getNodeEditWindow(ptitle, purl, pemodeselect, pvid, pvname, pvloc, pvpos, pvmode, pvscale, pvlevel, pvfreq){
	if(!node_edit_window){
		pemodeselect.style.display="";
		var node_edit_form = new Ext.FormPanel({
	        labelWidth: 75,
	        frame:true,
	        //title: ptitle,
	        //style:'padding-top:150px;margin:auto',
	        width: 350,
	        header:false,
	        defaults: {width: 230},
	        defaultType:'textfield',
	        //layout:"form",
	        items: [{
                fieldLabel: 'ID',
                id:'node_edit_nid',
                name: 'node_edit_nid',
                value:pvid,
                disabled:true//readOnly:true
            },{
                fieldLabel: '昵称',
                id:'node_edit_nname',
                name: 'node_edit_nname',
                value:pvname,
                allowBlank:true,
                maxLength:20
            },{
                fieldLabel: '经纬度',
                id:'node_edit_nlocation',
                name: 'node_edit_nlocation',
                value:pvloc,
                disabled:true
            },{
                fieldLabel: '地理位置',
                id:'node_edit_nposition',
                name: 'node_edit_nposition',
                value:pvpos,
                disabled:true
            },{
                fieldLabel: '模式',
                id:'node_edit_nmode',
                name: 'node_edit_nmode',
                xtype:'combo',
                transform:"nmodeList",
				triggerAction:'all',
				lazyRender:true
            },{
                fieldLabel: '混合比例',
                id:'node_edit_mix_scale',
                name: 'node_edit_mix_scale',
                value:pvscale,
                allowBlank:true
            },{
                fieldLabel: '混合量',
                id:'node_edit_mix_level',
                name: 'node_edit_mix_level',
                value:pvlevel,
                allowBlank:true
            },{
                fieldLabel: '喷洒频率',
                id:'node_edit_mix_freq',
                name: 'node_edit_mix_freq',
                value:pvfreq,
                allowBlank:true
            }]
	    });
        node_edit_window = new Ext.Window({
            //el:'node_edit_div',
            title:'节点编辑',
            layout:'form',
            width:360,
            height:273,
            closeAction:'hide',
            plain: true,
            modal:true,
            items: node_edit_form,
            buttons: [{
                text:'提交',
                handler:function(){
                	Ext.Ajax.request({
						url: purl,
						method:"GET",
						params:{
							nid:Ext.getCmp('node_edit_nid').getValue(),
							nname:Ext.getCmp('node_edit_nname').getValue(),
							//
							mix_scale:Ext.getCmp('node_edit_mix_scale').getValue(),
							mix_level:Ext.getCmp('node_edit_mix_level').getValue(),
							mix_freq:Ext.getCmp('node_edit_mix_freq').getValue()
						},
						success:function(response, options){
							//Ext.MessageBox.alert('警告', response.responseText);
							node_edit_window.hide();
							Ext.example.msg("提示", response.responseText);
						},
						failure:function(){
							Ext.example.msg("提示", "修改失败！");
						}
					});
                }
            },{
                text: '取消修改',
                handler: function(){
                    node_edit_window.hide();
                }
            }]
        });
	} else {//如果窗口已经创建
		Ext.getCmp('node_edit_nid').setValue(pvid);
		Ext.getCmp('node_edit_nname').setValue(pvname);
		Ext.getCmp('node_edit_nlocation').setValue(pvloc);
		Ext.getCmp('node_edit_nposition').setValue(pvpos);
		//node_edit_nmode
		Ext.getCmp('node_edit_mix_scale').setValue(pvscale);
		Ext.getCmp('node_edit_mix_level').setValue(pvlevel);
		Ext.getCmp('node_edit_mix_freq').setValue(pvfreq);
	}
	return node_edit_window;
}