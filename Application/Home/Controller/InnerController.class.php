<?php
namespace Home\Controller;


class InnerController extends TcsController {

	public function __construct(){
        parent::__construct();
        if(session('uid') == null) {
            $this->redirect('Home/Index/login', 0, 0, '');
            return;
        }
	}

	public function system_summary(){
		//$this->show('system_summary');
		$this->assign('user_count', M('User')->count('uid'));
		$this->assign('province_count', M('Province')->count('vid'));
		$this->assign('city_count', M('City')->count('cid'));
		$this->assign('district_count', M('District')->count('did'));
		$this->assign('node_count', M('Node')->count('nid'));
		$this->assign('msg_count', M('SysMsg')->count('mid'));
		$this->display();
	}
	public function acc_delete($uid=''){
		if($uid == ''){
			$this->show('参数错误！');
		}

		$p = M('Perm');
		$p->where('`uid`=\''.I('uid').'\'')->delete();//删除权限表对应记录
		$m = M('User');
		if( $m->where('`uid`=\''.I('uid').'\'')->delete() ){
			$this->show('删除成功！');
		} else {
			$this->show('删除错误！'.$m->_sql());
		}
	}

	public function area_info(){
		$province_model = M('province');
		$city_model = M('CityView');
		$district_model = M('DistrictView');

		$province_list = $province_model->order('vid')->select();
		$city_list = $city_model->order('cid')->select();
		$district_list = $district_model->order('did')->select();

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

		$m2 = M('Perm');
		$data['uid'] = I('uid');
		$data['did'] = I('did');
		if($m2->where($data)->find()){
			$m->save();
		} else {
			$m->add();	
		}
		$this->show('修改成功！');
	}

	public function node_info(){ 
		$this->display();
	}
	public function node_info_list($start=0,$limit=20,$name='',$position=''){
		//$m = M();
		//$count = $m->query('SELECT count(nid) AS c FROM t_node WHERE ');
		$name = I('name');
		$position = I('position');
		if($name != ''){
			$condmap['nname'] = array('like', '%'.I('name').'%');
		}
		if($position != ''){
			$condmap['vname|cname|dname'] = array('like', '%'.I('position').'%');
		}
		$node_model = M('NodeView');
		$count = $node_model->where($condmap)->count('did');
		//echo $node_model->_sql();echo $count;return;
		$node_list = $node_model->where($condmap)->limit($start, $limit)->select();
		//echo $node_model->_sql();return;
		//echo $node_model->_sql();
		$this->assign("node_list", $node_list);
		$this->assign('node_count', $count);
		$this->display();
	}

	public function op_info(){
		$this->display();
	}
	public function op_info_list($start=0,$limit=20){
		//$m = M();
		$op_model = M('NodeOpView');
		//$count = $m->query('SELECT count(oid) AS c FROM t_node_op_view');
		$count = $op_model->count('oid');
		$this->assign('node_op_count', $count);
		$op_list = $op_model->limit($start, $limit)->order('otime desc')->select();
		$this->assign("op_list", $op_list);
		$this->display();
	} 

	public function msg_info(){
		$this->display(); 
	}
	public function msg_info_list($start=0,$limit=20){
		//$m = M();
		$sys_msg_model = M('SysMsgView');
		//$count = $m->query('SELECT count(m.mid) AS c FROM t_sys_msg_view m');
		$count = $sys_msg_model->count('mid');
		$this->assign('sys_msg_count', $count);
		$sys_msg_list = $sys_msg_model->limit($start, $limit)->order('mtime desc')->select();
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