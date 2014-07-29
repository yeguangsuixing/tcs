<?php
namespace Home\Controller;
use Think\Controller;

class FormController extends Controller{
	public function insert(){
		$form = D('Form');
		if($form->create()){
			if($form->add()){
				$this->success('操作成功！');
			} else {
				$this->error('写入错误！');
			}
		} else {
			$this->error($form->getError());//
		}
	}
	public function read($id=0){
		$form = D('Form');
		$data = $form->find($id);
		if($data){
			$this->data = $data;
		} else {
			$this->error('数据错误！');
		}
		$this->display();
	}
	public function edit($id=0){
		$form = D('Form');
		$this->vo = $form->find($id);
		$this->display();
	}
	public function update(){
		$form = D('Form');
		if($form->create()){
			if($form->save()){
				$this->success('更新成功！');
			} else {
				$this->error('写入错误！');
			}
		} else {
			$this->error($form->getError());
		}
	}
}

?>