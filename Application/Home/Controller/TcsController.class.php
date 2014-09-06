<?php
namespace Home\Controller;
use Think\Controller;
class TcsController extends Controller {

	public $TCS_NAME = '垃圾场清洁系统';
	public $TCS_TITLE_POS = "{title}";
	public $TCS_TITLE;
	public $MAP_UTYPE = array(
		'1'=>'超级管理员',
		'2'=>'管理员',
		'3'=>'巡检员'
	);
	public $TCS_MAS_HOST = "127.0.0.1";
	public $TCS_MAS_PORT = 8316;
	//public $TCS_RES_PATH = "http://localhost/tcs/Public/";



//所有以T开头的表示页面提示
	public $T_LOGIN_SUCCEED = '登录成功！';
	public $T_LOGOFF_SUCCEED = '退出成功！正在转到登录界面……';

//所有以C开头的表示常量
	public $C_TIME_REDIRECT = 2;

	public function __construct(){
		parent::__construct();
		$configModel = M('Config');
		$lim['type'] = 'server_ip';
		$result = $configModel->where($lim)->find();
		if($result){
			$this->TCS_MAS_HOST = $result['value'];
			//echo $this->TCS_MAS_HOST;
		}
		$lim['type'] = 'server_port';
		$result = $configModel->where($lim)->find();
		if($result){
			$this->TCS_MAS_PORT = $result['value'];
			//echo $this->TCS_MAS_PORT;
		}
        $this->TCS_TITLE = $this->TCS_NAME." - ".$this->TCS_TITLE_POS;
	}

    public function test(){
    	$this->show('test succeed!');
    }

}