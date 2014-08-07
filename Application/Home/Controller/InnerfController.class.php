<?php
namespace Home\Controller;

class InnerfController extends TcsController {

	 public function node_map(){
        $this->display();
    }
    public function node_table(){
        $this->display();
    }
    public function node_info_single($baidu_id){
    	$this->show("{id:'GTFRTYFD',name:'节点名称node_info_single',location:'120.456,43.56',position:'江苏省南京市白下区',mode:0,scale:45.345,level:20,freq:3601}");
    }

    public function my_info(){
        $this->display();
    }
	public function password_modify(){
		$this->display();
	}
	public function password_modify_validate(){
		$this->show("修改成功！");
	}

	public function node_edit($nid){
		$this->show("修改".I("nid")."成功！");
	}

    public function test(){
    	$this->show('test!');
    }

}


?>