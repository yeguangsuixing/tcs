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
    	$m = M('NodeView');
    	$cond['baidu_id'] = I('baidu_id');
    	$list = $m->where($cond)->find();
    	$dis = "{result:'nrsl',id:'nid',name:'nname',location:'nlng,nlat',position:'npos',mode:'tmode',scale:'nscale',level:'nlevel',freq:'nfreq',nh3:'nnh3',h2s:'nh2s'}";
    	if($list != null){
    		$dis = str_replace('nrsl', '1', $dis);
    		$dis = str_replace('nid', $list['nid'], $dis);
    		$dis = str_replace('nname', $list['nname'], $dis);
    		$dis = str_replace('nlng', ($list['lng']), $dis);
    		$dis = str_replace('nlat', ($list['lat']), $dis);
    		$dis = str_replace('npos', $list['vname'].$list['cname'].$list['dname'], $dis);
    		$dis = str_replace('tmode', $list['nmode'], $dis);
    		$dis = str_replace('nscale', $list['auto_mix_scale']==null?"":$list['auto_mix_scale'], $dis);
    		$dis = str_replace('nlevel', $list['auto_mix_level']==null?"":$list['auto_mix_level'], $dis);
    		$dis = str_replace('nfreq', $list['auto_mix_freq']==null?"":$list['auto_mix_freq'], $dis);
    		$dis = str_replace('nnh3', $list['nnh3'], $dis);
    		$dis = str_replace('nh2s', $list['nh2s'], $dis);
    	} else {
    		$dis = str_replace('nrsl', '0', $dis);
    	}
    	$this->show($dis);
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

	public function node_edit($pnid,$pnmode,$pnname=0,
		$pmix_scale=0,$pmix_level=0,$pmix_freq=0,$pnh3=0,$ph2s=0){
		$nid = I('get.pnid');
		$nname = I('get.pnname');
		$nmode = I('get.pnmode');
		$scale = I('get.pmix_scale');
		$level = I('get.pmix_level');
		$freq = I('get.pmix_freq');
		$nh3 = I('get.pnh3');
		$h2s = I('get.ph2s');

		$m = M('Node');
		$nodedata['nid'] = $nid;
		$nodedata['nname'] = $nname;
		$m->save($nodedata);

		if($nmode == '0'){
			$url = "/?type=ctrl&nid=$nid&mode=0&nh3=$nh3&h2s=$h2s&freq=$freq&scale=$scale&";
			$resp = $this->conn_middle_application_server($url);
			if($resp == "result:1"){
				$nodedata['nmode'] = '0';
				$nodedata['nnh3'] = $nh3;
				$nodedata['nh2s'] = $h2s;
				$nodedata['auto_mix_level'] = 0;
				$nodedata['auto_mix_freq'] = $freq;
				$nodedata['auto_mix_scale'] = $scale;
				$m->save($nodedata);
				$this->show("设置节点".$nid."为自动模式成功！");
			} else {
				$this->show("设置节点".$nid."为自动模式失败！错误信息：".$resp);
			}
		} else if($nmode == '1'){
			$url = "/?type=ctrl&nid=$nid&mode=1";
			$resp = $this->conn_middle_application_server($url);
			if($resp == "result:1"){
				$nodedata['nmode'] = '1';
				$m->save($nodedata);
				$this->show("设置节点".$nid."为手动模式成功！");
			} else {
				$this->show("设置节点".$nid."为手动模式失败！错误信息：".$resp);
			}
		} else if($nmode == '2'){
			$url = "/?type=ctrl&nid=$nid&mode=2&scale=$scale&level=$level&";
			$resp = $this->conn_middle_application_server($url);
			if($resp == "result:1"){
				$nodedata['nmode'] = '1';
				$nodedata['auto_mix_level'] = $level;
				$nodedata['auto_mix_scale'] = $scale;
				$m->save($nodedata);
				$this->show("节点".$nid."启动混合成功！");
			} else {
				$this->show("节点".$nid."启动混合失败！错误信息：".$resp);
			}
		} else if($nmode == '3'){
			$url = "/?type=ctrl&nid=$nid&mode=3&freq=$freq&";
			$resp = $this->conn_middle_application_server($url);
			if($resp == "result:1"){
				$nodedata['nmode'] = '1';
				$nodedata['auto_mix_freq'] = $freq;
				$m->save($nodedata);
				$this->show("节点".$nid."启动喷洒成功！");
			} else {
				$this->show("节点".$nid."启动喷洒失败！错误信息：".$resp);
			}
		} else {
			$this->show("修改节点".$nid."信息失败！错误信息：模式错误！");
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
    	$fp = '';
    	if(!($fp = fsockopen($this->TCS_MAS_HOST, $this->TCS_MAS_PORT, $errno, $errstr, 10000)))
    		return ($errno);
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