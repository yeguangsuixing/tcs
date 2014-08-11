<?php
namespace Home\Controller;

class InnerfController extends TcsController {

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

	public function node_edit($nid){
		$data = '';//$this->conn_application_server($nid);
		$this->show("修改".I("nid")."成功！".$data);
	}

    public function test(){
    	$this->show('test!');
    }

    public function conn_application_server($nid){
    	$errno = '';
    	$errstr = '';
    	$data = '';
    	$header = "GET /?type=node&id=$nid&mode=1 HTTP/1.1\r\n";
    	$header .= "Host:127.0.0.1:8316\r\n";
    	$header .= "Connection:Close\r\n\r\n";
    	$fp = fsockopen("127.0.0.1", 8316, $errno, $errstr, 100) or exit($errno."--->".$errstr);
    	fwrite($fp, $header);
    	fflush($fp);
    	while (!feof($fp)) {
	        $data .= fgets($fp,1024);
	    }
	    fclose($fp);
	    return $data;
    }
}


?>