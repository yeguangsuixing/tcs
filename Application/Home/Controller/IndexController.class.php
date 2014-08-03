<?php
namespace Home\Controller;
class IndexController extends TcsController {

    public function __construct(){
        parent::__construct();
        $this->system_name = $this->TCS_NAME;
        $this->login_title = str_replace($this->TCS_TITLE_POS, '登录', $this->TCS_TITLE);
        $this->index_title = str_replace($this->TCS_TITLE_POS, '后台管理', $this->TCS_TITLE);
    }

    public function index(){
        if(session('uid') == null) {
            //$this->redirect('Home/Index/login', 0, 0, '');
            //return;
        }
        //$this->show('index'.session('uid'));
        $this->display();
    }

    public function login(){
        $this->name = "超级管理员";
        $this->cur_module_name = "Home";
        $this->cur_controller_name = "Index";
        $this->display();
    }

    public function login_validate(){
        //$this->show(I('uid').'<br />');
        //$this->show(I('password').'<br />');
        $data['uid'] = I('uid');
        $data['password'] = I('password');
        $user = D('User');
        if($user->create()){
            $t = $user->where($data)->select();
            if($t){
                session('uid', $t[0]['uid']);
                session('uname', $t[0]['uname']);
                session('last_login', $t[0]['last_login']);
                session('email', $t[0]['email']);
                session('mobilephone', $t[0]['mobilephone']);
                session('utype', $t[0]['utype']);
                $this->success($this->T_LOGIN_SUCCEED,__ROOT__.'/Home/Index/index', $this->C_TIME_REDIRECT);
                //$this->redirect('/Home/Index/index', 0, 5, '页面跳转中...');
            } else {
                $this->show('login_FAILED.');
            }
        } else {
            $this->error($user->getError());
        }
    }

    public function hello(){
    	//echo "Hello, ThinkPHP World!";
    	$this->name = "My ThinkPHP";
    	$this->display();
    }
    public function hellodb(){
        $Data = M('data'); // 实例化Data数据模型
        $this->data = $Data->select();
        $this->display();
    }
    public function test(){
    	$this->show('test!');
    }
}