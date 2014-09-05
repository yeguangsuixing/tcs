<?php
namespace Home\Controller;
class IndexfController extends TcsController {

    public function __construct(){
        parent::__construct();
        $this->system_name = $this->TCS_NAME;
        $this->index_title = str_replace($this->TCS_TITLE_POS, '前台管理', $this->TCS_TITLE);
    }

    public function index(){
        if(session('uid') == null) {
            $this->redirect('Home/Index/login', 0, 0, '');
            return;
        }
        $this->display();
    }
}