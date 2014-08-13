<?php
namespace Home\Controller;

class InnerfController extends TcsController {

	
    public function __construct(){
        parent::__construct();
        $this->mas_port = $this->TCS_MAS_PORT;
    }

	 public function node_map(){
        $this->display();
    }
    public function node_table(){
        $this->display();
    }
    public function node_info_single($baidu_id){
    	$this->show("{id:'GTFRTYFD',name:'节点名称node_info_single',location:'120.456,43.56',position:'江苏省南京市白下区',mode:0,scale:45.345,level:20,freq:3601,nh3:45,h2s:57}");
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

	public function node_edit($pnid,$pnmode,$pnname=0,$pmix_scale=0,$pmix_level=0,$pmix_freq=0,$pnh3=0,$ph2s=0){
		$nid = I('get.pnid');
		$nname = I('get.pnname');
		$nmode = I('get.pnmode');
		$scale = I('get.pmix_scale');
		$level = I('get.pmix_level');
		$freq = I('get.pmix_freq');
		$nh3 = I('get.pnh3');
		$h2s = I('get.ph2s');
		if($nmode == '0'){
			$this->show("设置节点".$nid."为自动模式成功！");
		} else if($nmode == '1'){
			$url = "/?type=node&id=$nid&mode=1";
			$resp = $this->conn_middle_application_server($url);
			if($resp == "result:0"){
				$this->show("设置节点".$nid."为手动模式成功！");
			} else {
				$this->show("设置节点".$nid."为手动模式失败！");
			}
		} else if($nmode == '2'){
			$this->show("设置节点".$nid."启动混合成功！");
		} else if($nmode == '3'){
			$this->show("设置节点".$nid."启动喷洒成功！");
		} else {
			$this->show("修改节点".$nid."信息失败！");
		}
	}

    public function test(){
    	$this->show('test!');
    }

    public function conn_middle_application_server($purl){
    	$errno = '';
    	$errstr = '';
    	$data = '';
    	$header = "GET $purl HTTP/1.1\r\n";
    	$header .= "Host:$this->TCS_MAS_HOST:$this->TCS_MAS_PORT\r\n";
    	$header .= "Connection:Close\r\n\r\n";
    	$fp = fsockopen($this->TCS_MAS_HOST, $this->TCS_MAS_PORT, $errno, $errstr, 10000) or exit($errno."->".$errstr);
    	fwrite($fp, $header);
    	fflush($fp);
    	while (!feof($fp)) {
	        $data .= fgets($fp,1024);
	    }
	    fclose($fp);

	    $resp_body_offset = strpos($data, "\r\n\r\n")+4;
		$resp_body_offset = strpos($data, "\r\n", $resp_body_offset)+2;//跳过长度
		$resp_body_length = strpos($data, "\r\n", $resp_body_offset) - $resp_body_offset;
		$resp_body = substr($data, $resp_body_offset, $resp_body_length);

	    return $resp_body;
    }
}


?>