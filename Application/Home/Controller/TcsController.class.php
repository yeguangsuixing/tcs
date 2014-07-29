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
	//public $TCS_RES_PATH = "http://localhost/tcs/Public/";



//所有以T开头的表示页面提示
	public $T_LOGIN_SUCCEED = '登录成功！';

//所有以C开头的表示常量
	public $C_TIME_REDIRECT = 3;

	public function __construct(){
		parent::__construct();
        $this->TCS_TITLE = $this->TCS_NAME." - ".$this->TCS_TITLE_POS;
	}

    public function test(){
    	$this->show('test succeed!');
    }

}