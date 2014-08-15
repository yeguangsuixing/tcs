<?php
namespace Home\Controller;


class InnerController extends TcsController {

	public function system_summary(){
		//$this->show('system_summary');
		$this->display();
	}

	public function area_info(){
		$province_model = M('province');
		$city_model = M('CityView');
		$district_model = M('DistrictView');

		$province_list = $province_model->select();
		$city_list = $city_model->select();
		$district_list = $district_model->select();

		$this->assign("province_list", $province_list);
		$this->assign("city_list", $city_list);
		$this->assign("district_list", $district_list);
		$this->assign("province_list_count", count($province_list));
		$this->assign("city_list_count", count($city_list));
		$this->assign("district_list_count", count($district_list));
		$this->display();
	}
	public function acc_info(){
		$m = M('User');
		$m_list = $m->where("utype <> '1'")->select();//除去超管
		$this->assign("user_list", $m_list);
		$this->assign("user_list_count", count($m_list));
		$this->display();
	}  
	//uid:uid,uname:uname,email:email,mobilephone:mobilephone,utype:utype
	public function acc_info_modify($uid=-1,$uname='',$email='',$mobilephone='',$utype=2){
		//$t = I("uname");
		if($uid == -1 || $uid == '' || $mobilephone == ''){
			$this->show("参数错误！");
			return;
		}
		$m = M('User');
		$data['uid'] = I('uid');
		$data['uname'] = I('uname');
		$data['email'] = I('email');
		$data['mobilephone'] = I('mobilephone');
		$data['utype'] = I('utype');
		if($m->save($data) === false){
			$this->show("修改失败！");
		} else {
			$this->show("修改成功！");
		}
	}
	public function acc_add(){
		$this->acc_add_title = "账户添加";
		$this->display();
	}
	public function acc_add_validate(){
		$m = M('User');
		if($m->create()){
			$m->create_time = date('Y-m-d H:i:s', time());
			$result = $m->add();//$this->show($m->_sql());
			if($result){
				$this->show("添加用户".I('uid')."成功！");
			} else {
				$this->show("添加失败！插入对象错误！");
			}
		} else {
			$this->show("添加失败！创建对象错误！");
		}
	}
	public function perm_info_list($uid=''){
		$uid = I('uid');
		if($uid != ''){
			$cond['uid'] = $uid;
			$m = M('PermView');
			$list = $m->where($cond)->select();//dump($list);
			$this->assign("perm_list", $list);
			$this->assign("perm_list_count", count($list));
		} else {
			$this->assign("perm_list", array());
			$this->assign("perm_list_count", 0);
		}
		$this->display();
	}
	//params:{uid:uid, pcheck:pcheck, pcontrol:pcontrol},
	public function perm_modify_validate($uid='',$did='',$pcheck='',$pcontrol=''){
		if(I('uid') == '' || I('did') == '' || I('pcheck') == '' || I('pcontrol') == ''){
			$this->show('参数错误！');return;
		}
		$m = M('Perm');
		$m->create();
		$m->pcheck = ($m->pcheck == 'true');
		$m->pcontrol = ($m->pcontrol == 'true');
		$m->add();
		$this->show('修改成功！');
	}

	public function node_info(){ 
		$this->display();
	}
	public function node_info_list(){
		$m = M();
		$count = $m->query('SELECT count(nid) AS c FROM t_node');
		$node_model = M('NodeView');
		$node_list = $node_model->select();
		$this->assign("node_list", $node_list);
		$this->assign('node_count', $count[0]['c']);
		$this->display();
	}

	public function op_info(){
		$this->display();
	}
	public function op_info_list(){
		$m = M();
		$count = $m->query('SELECT count(oid) AS c FROM t_node_op_view');
		$this->assign('node_op_count', $count[0]['c']);
		$op_model = M('NodeOpView');
		$op_list = $op_model->select();
		$this->assign("op_list", $op_list);
		$this->display();
	} 

	public function msg_info(){
		$this->display(); 
	}
	public function msg_info_list(){
		$m = M();
		$count = $m->query('SELECT count(m.mid) AS c FROM t_sys_msg_view m');
		$this->assign('sys_msg_count', $count[0]['c']);
		$sys_msg_model = M('SysMsgView');
		$sys_msg_list = $sys_msg_model->select();
		$this->assign("sys_msg_list", $sys_msg_list);
		$this->display(); 
	} 

	public function password_modify(){
		$this->display();
	}
	public function password_modify_validate($old_password='',$new_password=''){
		if($old_password == '' || $new_password == ''){
			$this->show('修改失败！'); return;
		}
		if(session('password') != $old_password){
			$this->show('修改失败！密码错误！'); return;
		}
		$m = M('User');
		$data['uid'] = session('uid');
		$data['password'] = I('new_password');
		if($m->save($data) === false){
			$this->show('修改失败！修改数据库失败！');  
		} else {
			$this->show('修改成功！');
		}
	}

}


?>