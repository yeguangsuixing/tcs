



var node_edit_window;
function getNodeEditWindow_change_mode_select(value){
    if(value == 0){
        Ext.getCmp('node_edit_mix_scale').el.parent().prev().dom.innerText = '自动混合比例:';
        Ext.getCmp('node_edit_mix_level').el.parent().prev().dom.innerText = '自动混合量:';
        Ext.getCmp('node_edit_mix_freq').el.parent().prev().dom.innerText = '自动喷洒量:';
        Ext.getCmp('node_edit_nh3').setDisabled(false);
        Ext.getCmp('node_edit_h2s').setDisabled(false);
        Ext.getCmp('node_edit_btn_mix').setDisabled(true);
        Ext.getCmp('node_edit_btn_cleanup').setDisabled(true);
        Ext.getCmp('node_edit_btn_submit').setText('提交自动模式数据');
    } else {
        Ext.getCmp('node_edit_mix_scale').el.parent().prev().dom.innerText = '手动混合比例:';
        Ext.getCmp('node_edit_mix_level').el.parent().prev().dom.innerText = '手动混合量:';
        Ext.getCmp('node_edit_mix_freq').el.parent().prev().dom.innerText = '手动喷洒量:';
        Ext.getCmp('node_edit_nh3').setDisabled(true);
        Ext.getCmp('node_edit_h2s').setDisabled(true);
        Ext.getCmp('node_edit_btn_mix').setDisabled(false);
        Ext.getCmp('node_edit_btn_cleanup').setDisabled(false);
        Ext.getCmp('node_edit_btn_submit').setText('设置节点为手动');
    }
}
function getNodeEditWindow(ptitle, purl, pemodeselect, pvid, pvname, pvloc, pvpos, pvmode, pvscale, pvlevel, pvfreq, pvnh3, pvh2s){
	if(!node_edit_window){
		pemodeselect.style.display="";
        var modeselect = new Ext.form.ComboBox({
           	fieldLabel: '模式',
            id:'node_edit_nmode',
            name: 'node_edit_nmode',
            mode:'local',
            transform:"nmodeList",
            //clearCls:'x-form-text ',
            cls:'tcs_select',
            itemCls:'tcs_select_item',
            tpl:'<tpl for="."><div class="x-combo-list-item tcs_select_item" >{text}</div></tpl>',
            //style:'font-size:18px;height:30px;',
            //xtype:'combo',
			//displayField:'text',
            //store:modeStore,
            //applyTo: 'node_edit_nmode_input',
            editable:false,
            selectOnFocus:true,
			triggerAction:'all',
			lazyRender:true
        });
        modeselect.setValue(pvmode);
        //console.log(pvmode);
        modeselect.on('select',function(elem){ getNodeEditWindow_change_mode_select(elem.value); });
		var node_edit_form = new Ext.FormPanel({
	        labelWidth: 150,
	        frame:true,
	        //title: ptitle,
	        style:'margin:auto',
	        //bodyStyle:'padding:25px 25px 0',
            //defaults:{margin_top:3},
	        //width: 400,
	        header:false,
	        defaults: {width: 230, height:30},
	        defaultType:'textfield',
	        layout:"form",
	        items: [{
                fieldLabel: 'ID',
                id:'node_edit_nid',
                name: 'node_edit_nid',
                value:pvid,
                style:'font-size:18px;',
            	itemCls:'tcs_select_item',
                disabled:true//readOnly:true
            },{
                fieldLabel: '昵称',
                id:'node_edit_nname',
                name: 'node_edit_nname',
                style:'font-size:18px;',
            	itemCls:'tcs_select_item',
                value:pvname,
                allowBlank:true,
                maxLength:20
            },{
                fieldLabel: '经纬度',
                id:'node_edit_nlocation',
                name: 'node_edit_nlocation',
                style:'font-size:18px;',
            	itemCls:'tcs_select_item',
                value:pvloc,
                disabled:true
            },{
                fieldLabel: '地理位置',
                id:'node_edit_nposition',
                name: 'node_edit_nposition',
                style:'font-size:18px;',
            	itemCls:'tcs_select_item',
                value:pvpos,
                disabled:true
            },
                modeselect
            ,{
                fieldLabel: pvmode==0?'自动混合比例':'手动混合比例',
                id:'node_edit_mix_scale',
                name: 'node_edit_mix_scale',
                style:'font-size:18px;',
            	itemCls:'tcs_select_item',
                value:pvscale,
                allowBlank:true
            },{
                fieldLabel: pvmode==0?'自动混合量':'手动混合量',
                id:'node_edit_mix_level',
                name: 'node_edit_mix_level',
                style:'font-size:18px;',
            	itemCls:'tcs_select_item',
                value:pvlevel,
                allowBlank:true
            },{
                fieldLabel: pvmode==0?'自动喷洒量':'手动喷洒量',
                id:'node_edit_mix_freq',
                name: 'node_edit_mix_freq',
                style:'font-size:18px;',
            	itemCls:'tcs_select_item',
                value:pvfreq,
                allowBlank:true
            },{
                fieldLabel:'自动喷洒NH<sub>3</sub>阈值',
                id:'node_edit_nh3',
                value:pvnh3,
                style:'font-size:18px;',
                itemCls:'tcs_select_item',
                disabled:pvmode==1,
                allowBlank:true
            },{
                fieldLabel:'自动喷洒H<sub>2</sub>S阈值',
                id:'node_edit_h2s',
                value:pvh2s,
                style:'font-size:18px;',
                itemCls:'tcs_select_item',
                disabled:pvmode==1,
                allowBlank:true
            }]
	    });
        node_edit_window = new Ext.Window({
            //el:'node_edit_div',
            title:'节点编辑与控制',
            layout:'form',
            width:500,
            height:273,
            closeAction:'hide',
            plain: true,
            modal:true,
            items: node_edit_form,
            buttons: [{
                text:'启动混合',
                disabled:pvmode==0,
                id:'node_edit_btn_mix',
                handler:function(elem){

                }
            },{
                text:'启动喷洒',
                disabled:pvmode==0,
                id:'node_edit_btn_cleanup',
                handler:function(elem){

                }
            },{
            	id:'node_edit_btn_submit',
                text: pvmode==0?'提交自动模式数据':'设置节点为手动',
                handler:function(elem){
                	elem.setDisabled(true);
                	Ext.Ajax.request({
						url: purl,
						method:"GET",
						params:{
							nid:Ext.getCmp('node_edit_nid').getValue(),
							nname:Ext.getCmp('node_edit_nname').getValue(),
							nmode:Ext.getCmp('node_edit_nmode').getValue(),
							mix_scale:Ext.getCmp('node_edit_mix_scale').getValue(),
							mix_level:Ext.getCmp('node_edit_mix_level').getValue(),
							mix_freq:Ext.getCmp('node_edit_mix_freq').getValue()
						},
						success:function(response, options){
							//Ext.MessageBox.alert('警告', response.responseText);
							node_edit_window.hide();
							elem.setDisabled(false);
							Ext.example.msg("提示", response.responseText);
						},
						failure:function(response, options){
							elem.setDisabled(false);
							Ext.example.msg("提示", response.responseText);
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
        //getNodeEditWindow_change_mode_select(pvmode);
	} else {//如果窗口已经创建
		Ext.getCmp('node_edit_nid').setValue(pvid);
		Ext.getCmp('node_edit_nname').setValue(pvname);
		Ext.getCmp('node_edit_nlocation').setValue(pvloc);
		Ext.getCmp('node_edit_nposition').setValue(pvpos);
		Ext.getCmp('node_edit_nmode').setValue(pvmode);
		Ext.getCmp('node_edit_mix_scale').setValue(pvscale);
		Ext.getCmp('node_edit_mix_level').setValue(pvlevel);
		Ext.getCmp('node_edit_mix_freq').setValue(pvfreq);
        Ext.getCmp('node_edit_nh3').setValue(pvnh3);
        Ext.getCmp('node_edit_h2s').setValue(pvh2s);
        getNodeEditWindow_change_mode_select(pvmode);
	}
	return node_edit_window;
}