/*
 * Ext JS Library 2.0.2
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */

Ext.onReady(function(){

    var tabs = new Ext.TabPanel({
        renderTo:'tabs',
        resizeTabs:true, // turn on tab resizing
        minTabWidth: 115,
        tabWidth:135,
        enableTabScroll:true,
        width:600,
        height:250,
        defaults: {autoScroll:true},
        plugins: new Ext.ux.TabCloseMenu()
    });

    // tab generation code
    var index = 0;
    while(index < 7){
        addTab();
    }
    var t;
    function addTab(){
        t = tabs.add({
            title: 'New Tab ' + (++index),
            id:'NewTab'+ index,
            iconCls: 'tabs',
            html: 'Tab Body ' + (index) + '<br/><br/>'
                    + Ext.example.bogusMarkup,
            closable:true
        });
        t.show();
    }
    function removeTab(){
        tabs.remove('NewTab2');
        tabs.add(t);
    }

    new Ext.Button({
        text: 'Add Tab',
        handler: removeTab,
        iconCls:'new-tab'
    }).render(document.body, 'tabs');
});