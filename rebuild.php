<?php
define('WHMCS', '');
require("../../../init.php");
session_start();
require_once __DIR__ . '/lib/Curl.php';
require_once __DIR__ . '/lib/CaseInsensitiveArray.php';
require_once __DIR__ . '/lib/SolusVM.php';

use Illuminate\Database\Capsule\Manager as Capsule;
use SolusVMPlus\SolusVM;

$userid = (int)$_POST["userid"];
$vserverid = (int)$_POST["vserverid"];
$template = $_POST["template"];
SolusVM::loadLang();
$params = SolusVM::getParamsFromVserviceID($vserverid, $userid);
if (!$params) {
	$result = array('status' => 'error', 'displaystatus' => $_LANG['solusvmplus_vserverNotFound'],);
	echo json_encode($result);
	exit();
}
if ($vserverid && $userid) {
	try {
		$solusvm = new SolusVM($params);
		$callArray = array("vserverid" => $vserverid, "template" => $template);
		$solusvm->apiCall('vserver-rebuild', $callArray);
		$r = $solusvm->result;
		if ($r["status"] == "success" && $r["rootpassword"]) {
			$solusvm->setCustomfieldsValue('rootpassword', $r["rootpassword"]);
		}
		echo json_encode($r);
	} catch (Exception $e) {
		logModuleCall('rebuild', __FUNCTION__, $params, $e->getMessage(), $e->getTraceAsString());
		echo $e->getMessage();
	}
}