<?php
namespace Home\Controller;

class InnerfController extends TcsController {

	 public function node_map(){
        $this->display();
    }
    public function node_table(){
        $this->display();
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