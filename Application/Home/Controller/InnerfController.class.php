<?php
namespace Home\Controller;

class InnerfController extends TcsController {

	
    public function __construct(){
        parent::__construct();
        $this->mas_port = $this->TCS_MAS_PORT;
        if(session('uid') == null) {
            $this->redirect('Home/Index/login', 0, 0, '');
            return;
        }
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
    	$dis = "{result:'nrsl',id:'nid',name:'nname',location:'nlng,nlat',position:'npos',mode:'tmode',scale:'nscale',level:'nlevel',freq:'nfreq',cleanup_time:'ncleanup_time',nh3:'nnh3',h2s:'nh2s'}";
    	if($list != null){
    		$dis = str_replace('nrsl', '1', $dis);
    		$dis = str_replace('nid', $list['nid'], $dis);
    		$dis = str_replace('nname', $list['nname'], $dis);
    		$dis = str_replace('nlng', ($list['lng']), $dis);
    		$dis = str_replace('nlat', ($list['lat']), $dis);
    		$dis = str_replace('npos', $list['vname'].$list['cname'].$list['dname'], $dis);
    		$dis = str_replace('tmode', $list['nmode'], $dis);
    		$dis = str_replace('nscale', $list['auto_mix_scale']==null?"0":$list['auto_mix_scale'], $dis);
    		$dis = str_replace('nlevel', $list['auto_mix_level']==null?"0":$list['auto_mix_level'], $dis);
    		$dis = str_replace('nfreq', $list['auto_mix_freq']==null?"0":$list['auto_mix_freq'], $dis);
    		$dis = str_replace('ncleanup_time', $list['auto_cleanup_time']==null?"0":$list['auto_cleanup_time'], $dis);
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

	public function node_edit($pnid,$pnmode,$pnname=0,
		$pmix_scale=0,$pmix_level=0,$pmix_freq=0,$pcleanup_time=0,$pnh3=0,$ph2s=0){
		$nid = I('pnid');
		$nname = I('pnname');
		$nmode = I('pnmode');
		$scale = I('pmix_scale');
		$level = I('pmix_level');
		$freq = I('pmix_freq');
		$cleanup_time = I('pcleanup_time');
		$nh3 = I('pnh3');
		$h2s = I('ph2s');

		if(!$this->perm_check(session('uid'),$nid)){
			$this->show('权限受限，修改失败！');
			return;
		}

		$m = M('Node');
		$nodedata['nid'] = $nid;
		$record = $m->where($nodedata)->find();
		$has_display = false;
		if($record){
			//echo $m->_sql();
			if($record['nname'] != $nname){
				$baidu_id = $record['baidu_id'];
				$url = "/?type=mdy&mode=name&nid=$baidu_id&newname=".urlencode($nname);
				$resp = $this->conn_middle_application_server($url);
				if($resp == 'result:1'){
					$nodedata['nname'] = $nname;
					$m->save($nodedata);
					$this->show("修改节点名称成功！");
				} else {
					$this->show("修改节点名称失败！".$resp);
				}
				$has_display = true;
			}
		}
		

		$o = M('NodeOp');
		$opdata['nid'] = $nid;
		$opdata['otype'] = $nmode;
		$opdata['otime'] = date('Y-m-d H:i:s', time());
		$opdata['mix_scale'] = $scale;
		$opdata['mix_level'] = $level;
		$opdata['mix_freq'] = $freq;
		$opdata['onh3'] = $nh3;
		$opdata['oh2s'] = $h2s;
		$opdata['oresult'] = 0;
		$opid = $o->add($opdata);
		$opdata['oid'] = $opid;

		if($nmode == '0'){
			/*
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
				$opdata['oresult'] = 1;
				$o->save($opdata);
				$this->show("设置节点".$nid."为自动模式成功！");
			} else {
				$this->show("设置节点".$nid."为自动模式失败！错误信息：".$resp);
			}//*/
			if(!$has_display){
				$this->show('节点数据未修改！');
			}
		} else if($nmode == '1'){/*
			$url = "/?type=ctrl&nid=$nid&mode=1";
			$resp = $this->conn_middle_application_server($url);
			if($resp == "result:1"){
				$nodedata['nmode'] = '1';
				$m->save($nodedata);
				$opdata['oresult'] = 1;
				$o->save($opdata);
				$this->show("设置节点".$nid."为手动模式成功！");
			} else {
				$this->show("设置节点".$nid."为手动模式失败！错误信息：".$resp);
			}//*/
			if(!$has_display){
				$this->show('节点数据未修改！');
			}
		} else if($nmode == '2'){
			$url = "/?type=ctrl&nid=$nid&mode=2&scale=$scale&level=$level&";
			$resp = $this->conn_middle_application_server($url);
			$nodedata['nmode'] = '1';
			$nodedata['auto_mix_level'] = $level;
			$nodedata['auto_mix_scale'] = $scale;
			$m->save($nodedata);
			$opdata['oresult'] = 1;
			$o->save($opdata);
			if($resp == "result:1"){
				$this->show("节点".$nid."设置混合参数成功！");
			} else if($resp == "10061"){
				$this->show("节点".$nid."设置混合参数失败！错误信息：无法连接到中间服务器$this->TCS_MAS_HOST:".
					$this->TCS_MAS_PORT." 。请超级管理员设置中间服务器参数！");
			} else {
				$this->show("节点".$nid."设置混合参数失败！错误信息：".$resp);
			}
		} else if($nmode == '3'){
			$url = "/?type=ctrl&nid=$nid&mode=3&freq=$freq&time=$cleanup_time";
			$resp = $this->conn_middle_application_server($url);
			$nodedata['nmode'] = '1';
			$nodedata['auto_mix_freq'] = $freq;
			$m->save($nodedata);
			$opdata['oresult'] = 1;
			$o->save($opdata);
			if($resp == "result:1"){
				$this->show("节点".$nid."设置喷洒参数成功！");
			} else if($resp == "10061"){
				$this->show("节点".$nid."设置喷洒参数失败！错误信息：无法连接到中间服务器$this->TCS_MAS_HOST:".
					$this->TCS_MAS_PORT." 。请超级管理员设置中间服务器参数！");
			} else {
				$this->show("节点".$nid."设置喷洒参数失败！错误信息：".$resp);
			}
		} else {
			$this->show("修改节点".$nid."信息失败！错误信息：模式错误！");
		}
	}

	private function perm_check($uid='',$nid=''){
		if($nid == '' || $uid == ''){
			return false;
		}
		$m = M('PermNodeView');
		$lim['uid'] = $uid;
		$lim['nid'] = $nid;
		$tt = $m->where($lim)->find();
		//echo $m->_sql();
		if($tt){
			return true;
		} else {
			return false;
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
    	if(!($fp = fsockopen($this->TCS_MAS_HOST, $this->TCS_MAS_PORT, $errno, $errstr, 20*1000)))
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