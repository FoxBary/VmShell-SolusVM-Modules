<?php
define("CLIENTAREA", true);
require("../../../init.php");
session_start();
require_once __DIR__ . '/lib/Curl.php';
require_once __DIR__ . '/lib/CaseInsensitiveArray.php';
require_once __DIR__ . '/lib/SolusVM.php';

use Illuminate\Database\Capsule\Manager as Capsule;
use SolusVMPlus\SolusVM;

SolusVM::loadLang();
function setFromGetOrSendError($param)
{
	global $_LANG;
	$res = 0;
	if (isset($_GET[$param])) {
		$res = (int)$_GET[$param];
	}
	if ($res === 0) {
		die($_LANG['solusvmplus_unauthorized']);
	}
	return $res;
}

$adminid = 0;
if (isset($_SESSION['adminid'])) {
	$adminid = (int)$_SESSION['adminid'];
}
if ($adminid === 0) {
	echo $_LANG['solusvmplus_unauthorized'];
	exit();
}
$vserverid = setFromGetOrSendError('id');
$uid = setFromGetOrSendError('userid');
$serverid = setFromGetOrSendError('serverid');
$serviceid = setFromGetOrSendError('serviceid');
$params = SolusVM::getParamsFromServiceID($serviceid, $uid);
if ($params === false) {
	echo $_LANG['solusvmplus_vserverNotFound'];
	exit;
}
if (($params['vserver'] != $vserverid) || ($params['serverid'] != $serverid)) {
	echo $_LANG['solusvmplus_wrongData'];
	exit;
}
$solusvm = new SolusVM($params);
$callArray = array("vserverid" => $vserverid);
$solusvm->apiCall('vserver-infoall', $callArray);
$r = $solusvm->result;
if ($r["status"] == "success") {
	$cparams = $solusvm->clientAreaCalculations($r);
	$graphs = '';
	if ($r["state"] == "online" || $r["state"] == "offline") {
		if ($cparams["displaytrafficgraph"] == 1) {
			$graphs .= '
                <div class="col-md-12 margin-top-20">
                    <img src="' . $cparams["trafficgraphurl"] . '" alt="Traffic Graph Unavailable">
                </div>
            ';
		}
		if ($params['configoption11'] == 'Yes') {
			$natinfo = '
         
                <div class="col-md-3 margin-top-20">
                    ' . $_LANG['solusvmplus_ipAddress'] . '
                </div>
                <div class="col-md-9 margin-top-20">
                    <strong><span>' . $cparams["connaddr"] . '</span></strong>
                </div>
                <div class="col-md-3 margin-top-20">
                    ' . $_LANG['solusvmplus_sshPort'] . '
                </div>
                <div class="col-md-9 margin-top-20">
                    <strong><span>' . $cparams["sshport"] . '</span></strong>
                </div>
                <div class="col-md-3 margin-top-20">
                    ' . $_LANG['solusvmplus_natPorts'] . '
                </div>
                <div class="col-md-9 margin-top-20">
                    <strong><span>' . $cparams["firstport"] . '-' . $cparams["lastport"] . '</span></strong>
                </div>
            ';
		}
		if ($cparams["displayloadgraph"] == 1) {
			$graphs .= '
                <div class="col-md-12 margin-top-20">
                    <img src="' . $cparams["loadgraphurl"] . '" alt="Load Graph Unavailable">
                </div>
            ';
		}
		if ($cparams["displaymemorygraph"] == 1) {
			$graphs .= '
                <div class="col-md-12 margin-top-20">
                    <img src="' . $cparams["memorygraphurl"] . '" alt="Memory Graph Unavailable">
                </div>
            ';
		}
		$bwshow = '
            <div class="col-md-3 margin-top-20">
                 <strong><span>' . $_LANG['solusvmplus_bandwidth'] . '</span></strong>
            </div>
            <div class="col-md-12 margin-top-20">
                ' . $cparams["bandwidthused"] . ' ' . $_LANG["solusvmplus_of"] . '
                ' . $cparams["bandwidthtotal"] . ' ' . $_LANG["solusvmplus_used"] . ' /
                ' . $cparams["bandwidthfree"] . ' ' . $_LANG["solusvmplus_free"] . '
            </div>
            <div class="col-md-12">
                <div class="progress">
                    <div class="progress-bar" id="bandwidthProgressbar" role="progressbar"
                         aria-valuenow="' . $cparams["bandwidthpercent"] . '" aria-valuemin="0" aria-valuemax="100"
                         style="width: ' . $cparams["bandwidthpercent"] . '% ;min-width: 2em; background-color: ' . $cparams["bandwidthcolor"] . '">
                        ' . $cparams["bandwidthpercent"] . '%
                    </div>
                </div>
            </div>
        ';
		$vstatus = $cparams["displaystatus"];
		$vmstatus = '
            <div class="col-md-3 margin-top-20">
                ' . $_LANG['solusvmplus_status'] . '
            </div>
            <div class="col-md-9 margin-top-20">
                ' . $vstatus . '
            </div>
        ';
		$node = '
            <div class="col-md-3 margin-top-20">
                ' . $_LANG['solusvmplus_node'] . '
            </div>
            <div class="col-md-9 margin-top-20">
                <strong><span>' . $cparams["node"] . '</span></strong>
            </div>
        ';
		if ($r["type"] == "openvz") {
			$mem = '
            <div class="col-md-3 margin-top-20">
                 <strong><span>' . $_LANG['solusvmplus_memory'] . '</span></strong>
            </div>
                <div class="col-md-12 margin-top-20">
                    ' . $cparams["memoryused"] . ' ' . $_LANG["solusvmplus_of"] . '
                    ' . $cparams["memorytotal"] . ' ' . $_LANG["solusvmplus_used"] . ' /
                    ' . $cparams["memoryfree"] . ' ' . $_LANG["solusvmplus_free"] . '
                </div>
                <div class="col-md-12">
                    <div class="progress">
                        <div class="progress-bar" id="memoryProgressbar" role="progressbar"
                             aria-valuenow="' . $cparams["memorypercent"] . '" aria-valuemin="0" aria-valuemax="100"
                             style="width: ' . $cparams["memorypercent"] . '% ;min-width: 2em; background-color: ' . $cparams["memorycolor"] . '">
                            ' . $cparams["memorypercent"] . '%
                        </div>
                    </div>
                </div>
            ';
		}
		if ($r["type"] == "openvz" || $r["type"] == "xen") {
			$hdd = '
            <div class="col-md-3 margin-top-20">
                 <strong><span>' . $_LANG['solusvmplus_disk'] . '</span></strong>
            </div>
                <div class="col-md-12 margin-top-20">
                    ' . $cparams["hddused"] . ' ' . $_LANG["solusvmplus_of"] . '
                    ' . $cparams["hddtotal"] . ' ' . $_LANG["solusvmplus_used"] . ' /
                    ' . $cparams["hddfree"] . ' ' . $_LANG["solusvmplus_free"] . '
                </div>
                <div class="col-md-12">
                    <div class="progress">
                        <div class="progress-bar" id="hddProgressbar" role="progressbar"
                             aria-valuenow="' . $cparams["hddpercent"] . '" aria-valuemin="0" aria-valuemax="100"
                             style="width: ' . $cparams["hddpercent"] . '% ;min-width: 2em; background-color: ' . $cparams["hddcolor"] . '">
                            ' . $cparams["hddpercent"] . '%
                        </div>
                    </div>
                </div>
            ';
		}
		if ($r["type"] == "openvz" || $r["type"] == "xen") {
			$html5Console = '<button type="button" style="width: 165px" class="btn btn-default" onclick="window.open(\'../modules/servers/solusvmplus/html5console.php?id=' . $serviceid . '&uid=' . $uid . '\', \'_blank\',\'width=880,height=600,status=no,resizable=yes,copyhistory=no,location=no,toolbar=no,menubar=no,scrollbars=1\')">
            ' . $_LANG['solusvmplus_html5Console'] . '</button>';
		}
		if ($r["type"] == "openvz" || $r["type"] == "xen") {
			$console = '<button type="button" class="btn btn-default" onclick="window.open(\'../modules/servers/solusvmplus/console.php?id=' . $serviceid . '&uid=' . $uid . '\', \'_blank\',\'width=830,height=750,status=no,location=no,toolbar=no,scrollbars=1,menubar=no\')">' . $_LANG["solusvmplus_serialConsole"] . '</button>';
			$cpass = '';
		} else {
			$console = '<button type="button" class="btn btn-default" onclick="window.open(\'../modules/servers/solusvmplus/vnc.php?id=' . $serviceid . '\', \'_blank\',\'width=800,height=600,status=no,location=no,toolbar=no,menubar=no,,scrollbars=1,resizable=yes\')">' . $_LANG['solusvmplus_vnc'] . '</button>';
			$cpass = '
                <script type="text/javascript" src="/modules/servers/solusvmplus/js/vncpassword.js"></script>
                <script type="text/javascript">
                    window.solusvmplus_vncpassword(vserverid, {"solusvmplus_invalidVNCpassword": "' . $_LANG['solusvmplus_invalidVNCpassword'] . '","solusvmplus_change":"' . $_LANG['solusvmplus_change'] . '","solusvmplus_confirmVNCPassword":"' . $_LANG['solusvmplus_confirmVNCPassword'] . '","solusvmplus_confirmErrorPassword":"' . $_LANG['solusvmplus_confirmErrorPassword'] . '","solusvmplus_confirmPassword":"' . $_LANG['solusvmplus_confirmPassword'] . '"}, token);
                </script>

                <div class="panel panel-default margin-btm-20" id="displayvncpassword">
                    <div class="panel-heading" role="tab" id="headingFive">
                        <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#solusvmplus_accordion" href="#solusvmplus_collapseFive" aria-expanded="false" aria-controls="solusvmplus_collapseFive">
                                ' . $_LANG['solusvmplus_vncPassword'] . '
                            </a>
                        </h4>
                    </div>
                    <div id="solusvmplus_collapseFive" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFive">
                        <div class="panel-body">

                            <div class="row">
                                <div id="vncpasswordMsgSuccess" class="alert alert-success" role="alert" style="display: none"></div>
                                <div id="vncpasswordMsgError" class="alert alert-danger" role="alert" style="display: none"></div>
                            </div>
                            <div class="row margin-10">
                                <div class="col-xs-2"></div>
                                <div class="col-xs-8">
                                    <div class="form-group">
                                        <label for="newvncpassword">' . $_LANG['solusvmplus_newPassword'] . '</label>
                                        <input type="password" class="form-control" name="newvncpassword" id="newvncpassword"
                                               placeholder="' . $_LANG['solusvmplus_enterVNCPassword'] . '" value="">
                                    </div>
                                </div>
                                <div class="col-xs-2"></div>
                            </div>
                            <div class="row margin-10">
                                <div class="col-xs-2"></div>
                                <div class="col-xs-8">
                                    <div class="form-group">
                                        <label for="confirmnewvncpassword">' . $_LANG['solusvmplus_confirmPassword'] . '</label>
                                        <input type="password" class="form-control" name="confirmnewvncpassword" id="confirmnewvncpassword"
                                               placeholder="' . $_LANG['solusvmplus_confirmVNCPassword'] . '" value="">
                                    </div>
                                    <button type="button" id="changevncpassword" class="btn btn-action">' . $_LANG['solusvmplus_change'] . '</button>
                                </div>
                                <div class="col-xs-2"></div>
                            </div>

                        </div>
                    </div>
                </div>
            ';
		}
		if ($r["type"] == "openvz" || $r["type"] == "xen") {
			$rpass = '
                <script type="text/javascript" src="/modules/servers/solusvmplus/js/rootpassword.js"></script>
                <script type="text/javascript">
                    window.solusvmplus_rootpassword(vserverid, {"solusvmplus_invalidRootpassword": "' . $_LANG['solusvmplus_invalidRootpassword'] . '","solusvmplus_change":"' . $_LANG['solusvmplus_change'] . '","solusvmplus_confirmRootPassword":"' . $_LANG['solusvmplus_confirmRootPassword'] . '","solusvmplus_confirmErrorPassword":"' . $_LANG['solusvmplus_confirmErrorPassword'] . '","solusvmplus_confirmPassword":"' . $_LANG['solusvmplus_confirmPassword'] . '"}, token);
                </script>
                <div class="panel panel-default margin-btm-20" id="displayrootpassword">
                    <div class="panel-heading" role="tab" id="headingOne">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#solusvmplus_accordion" href="#solusvmplus_collapseOne" aria-expanded="false" aria-controls="solusvmplus_collapseOne">
                                ' . $_LANG['solusvmplus_rootPassword'] . '
                            </a>
                        </h4>
                    </div>
                    <div id="solusvmplus_collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                        <div class="panel-body">

                            <div class="row">
                                <div id="rootpasswordMsgSuccess" class="alert alert-success" role="alert" style="display: none"></div>
                                <div id="rootpasswordMsgError" class="alert alert-danger" role="alert" style="display: none"></div>
                            </div>
                            <div class="row margin-10">
                                <div class="col-xs-2"></div>
                                <div class="col-xs-8">
                                    <div class="form-group">
                                        <label for="newrootpassword">' . $_LANG['solusvmplus_newPassword'] . '</label>
                                        <input type="password" class="form-control" name="newrootpassword" id="newrootpassword"
                                               placeholder="' . $_LANG['solusvmplus_enterRootPassword'] . '" value="">
                                    </div>
                                </div>
                                <div class="col-xs-2"></div>
                            </div>
                            <div class="row margin-10">
                                <div class="col-xs-2"></div>
                                <div class="col-xs-8">
                                    <div class="form-group">
                                        <label for="confirmnewrootpassword">' . $_LANG['solusvmplus_confirmPassword'] . '</label>
                                        <input type="password" class="form-control" name="confirmnewrootpassword" id="confirmnewrootpassword"
                                               placeholder="' . $_LANG['solusvmplus_confirmRootPassword'] . '" value="">
                                    </div>
                                    <button type="button" id="changerootpassword" class="btn btn-action">' . $_LANG['solusvmplus_change'] . '</button>
                                </div>
                                <div class="col-xs-2"></div>
                            </div>

                        </div>
                    </div>
                </div>
            ';
		}
		if ($r["type"] == "openvz" || $r["type"] == "xen") {
			$chostname = '
                <script type="text/javascript" src="/modules/servers/solusvmplus/js/hostname.js"></script>
                <script type="text/javascript">
                    window.solusvmplus_hostname(vserverid, {"solusvmplus_invalidHostname": "' . $_LANG['solusvmplus_invalidHostname'] . '","solusvmplus_change":"' . $_LANG['solusvmplus_change'] . '"}, token);
                </script>
                <div class="panel panel-default margin-btm-20" id="displayhostname">
                    <div class="panel-heading" role="tab" id="headingThree">
                        <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#solusvmplus_accordion" href="#solusvmplus_collapseThree" aria-expanded="false" aria-controls="solusvmplus_collapseThree">
                                ' . $_LANG['solusvmplus_hostname'] . '
                            </a>
                        </h4>
                    </div>
                    <div id="solusvmplus_collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                        <div class="panel-body">

                            <div class="row">
                                <div id="hostnameMsgSuccess" class="alert alert-success" role="alert" style="display: none"></div>
                                <div id="hostnameMsgError" class="alert alert-danger" role="alert" style="display: none"></div>
                            </div>
                            <div class="row margin-10">
                                <div class="col-xs-2"></div>
                                <div class="col-xs-8">
                                    <div class="form-group">
                                        <label for="newhostname">' . $_LANG['solusvmplus_newHostname'] . '</label>
                                        <input type="text" class="form-control" name="newhostname" id="newhostname"
                                               placeholder="' . $_LANG['solusvmplus_enterHostname'] . '" value="">
                                    </div>
                                    <button type="button" id="changehostname" class="btn btn-action">' . $_LANG['solusvmplus_change'] . '</button>
                                </div>
                                <div class="col-xs-2"></div>
                            </div>
                        </div>
                    </div>
                </div>
            ';
		}
		if ($solusvm->getExtData("controlpanelbutton-admin") != "") {
			$cpbutton = '<button type="button" class="btn btn-default" onclick="window.open(\'' . $solusvm->getExtData("controlpanelbutton-admin") . '\', \'_blank\')">' . $_LANG['solusvmplus_controlPanel'] . '</button>';
		}
		if ($solusvm->getExtData("controlpanelbutton-manage") != "") {
			$cpmanagebutton = '<button type="button" class="btn btn-default" onclick="window.open(\'' . $solusvm->getExtData("controlpanelbutton-manage") . '/manage.php?id=' . $vserverid . '\', \'_blank\')">' . $_LANG['solusvmplus_manage'] . '</button>';
		}
		echo '
            <style>
                .margin-top-20 {
                    margin-top: 20px;
                }
                .margin-btm-20 {
                    margin-bottom: 20px !important;
                }
                .margin-button button {
                    margin-top: 5px;
                    margin-bottom: 5px;
                    margin-right: 5px;
                }
            </style>
            <div class="row">
	            <div class="col-md-12 margin-button margin-btm-20">
	                ' . $console . $html5Console . $cpbutton . $cpmanagebutton . '
	            </div>
            </div>

            <script type="text/javascript">
                var vserverid = ' . $vserverid . ';
                token = "' . generate_token("link") . '";
            </script>
            
            <div class="panel-group" id="solusvmplus_accordion" role="tablist" aria-multiselectable="true">
                ' . $rpass . $chostname . $cpass . '
            </div>

            ' . $vmstatus . $natinfo . $node . $mem . $hdd . $bwshow . $graphs;
	} else {
		if ($r["state"] == "disabled") {
			echo '<span style="color: #000"><strong>' . $_LANG['solusvmplus_suspended'] . '</strong></span>';
		} else {
			echo $vstatus;
		}
	}
} else {
	echo $_LANG['solusvmplus_connectionError'];
	exit();
}