<?php
namespace Home\Model;
use Think\Model;
class FormModel extends Model {
	//自动验证
	protected $_validate = array(
		array('title', 'require', '标题不能为空！'),
		);
	//自动完成
	protected $_auto = array(
		array('create_time', 'time', 1, 'function'),
		);
}

?>