<?php
namespace Home\Controller;

class InnerController extends TcsController {

	public function system_summary(){
		$this->show('system_summary');
	}

	public function area_info(){
		$this->display();
	}
	public function acc_info(){
		$this->display();
	}  
	public function acc_info_modify(){
		//$t = I("uname");
		$this->show("修改成功！");                     
	}
	public function acc_add(){
		$this->acc_add_title = "账户添加";
		$this->display();
	}
	public function acc_add_validate(){
		$this->show("添加成功！");
	}
	public function perm_modify(){
		$this->display();
	}
	public function perm_modify_validate(){
		$this->show('修改成功！');  
	}

	public function node_info(){ 
		$this->display();
	}
	public function node_info_list(){
		$this->display();
	}

	public function op_info(){
		$this->display();
	}
	public function op_info_list(){
		$this->display();
	} 

	public function msg_info(){
		$this->display(); 
	}
	public function msg_info_list(){
		$this->display(); 
	} 

	public function password_modify(){
		$this->display();
	}
	public function password_modify_validate(){
		$this->show("修改成功！");
	}

}


?>