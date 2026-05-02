<script type="text/javascript" src="modules/servers/solusvmplus/js/get_user_data.js?v66"></script>
<script type="text/javascript" src="modules/servers/solusvmplus/js/rebuild.js?5"></script>
<script type="text/javascript" src="modules/servers/solusvmplus/js/hostname.js"></script>
{if $info['type'] != 'kvm'}
<script type="text/javascript" src="modules/servers/solusvmplus/js/rootpassword.js"></script>
{/if}
<script type="text/javascript" src="modules/servers/solusvmplus/js/vncpassword.js"></script>
<link rel="stylesheet" href="modules/servers/solusvmplus/templates/assets/css/style.css?4">
<link rel="stylesheet" href="modules/servers/solusvmplus/templates/assets/css/sweetalert.css?v66">
<script type="text/javascript" src="modules/servers/solusvmplus/js/uilang.js"></script>
<script type="text/javascript" src="modules/servers/solusvmplus/js/sweetalert.min.js?v65"></script>

<style>
    /* Professional UI Framework */
    .solusvm-container { font-family: 'Inter', 'Segoe UI', Roboto, sans-serif; color: #334155; background: #f8fafc; padding: 25px; border-radius: 20px; }
    .card-custom { background: #fff; border-radius: 16px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); border: 1px solid #e2e8f0; margin-bottom: 24px; overflow: hidden; }
    .card-header-custom { padding: 18px 24px; border-bottom: 1px solid #f1f5f9; background: #fff; display: flex; align-items: center; }
    .card-header-custom i { margin-right: 12px; font-size: 18px; color: #3b82f6; }
    .card-header-custom h4 { margin: 0; font-weight: 700; color: #1e293b; font-size: 16px; }
    .card-body-custom { padding: 24px; }
    
    /* Stat Cards Grid - Single Row */
    .stat-grid { display: flex; flex-wrap: nowrap; gap: 15px; margin-bottom: 24px; overflow-x: auto; }
    .stat-card { flex: 1; min-width: 180px; text-align: center; padding: 20px; border-radius: 16px; background: #fff; border: 1px solid #e2e8f0; transition: all 0.3s ease; }
    .stat-card i { font-size: 28px !important; color: #3b82f6 !important; margin-bottom: 12px; display: block !important; }
    .stat-card .title { font-size: 11px; color: #64748b; text-transform: uppercase; font-weight: 700; letter-spacing: 0.05em; margin-bottom: 8px; }
    .stat-card .info { font-size: 18px; font-weight: 800; color: #0f172a; }

    /* Big Icon Action Buttons */
    .action-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(110px, 1fr)); gap: 12px; margin-top: 24px; }
    .btn-big-icon { display: flex; flex-direction: column; align-items: center; justify-content: center; padding: 16px 8px; background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 12px; transition: all 0.2s; text-decoration: none !important; color: #475569; cursor: pointer; }
    .btn-big-icon i { font-size: 26px !important; margin-bottom: 8px; display: block !important; }
    .btn-big-icon span { font-size: 11px; font-weight: 700; text-align: center; text-transform: uppercase; }
    .btn-big-icon:hover { background: #fff; border-color: #3b82f6; transform: translateY(-2px); box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1); color: #1e293b; }
    .btn-big-icon.btn-reboot:hover i { color: #3b82f6 !important; }
    .btn-big-icon.btn-boot:hover i { color: #10b981 !important; }
    .btn-big-icon.btn-shutdown:hover i { color: #ef4444 !important; }
    .btn-big-icon.btn-network:hover i { color: #06b6d4 !important; }
    .btn-big-icon.btn-vnc:hover i { color: #8b5cf6 !important; }
    .btn-big-icon.btn-telegram:hover i { color: #0088cc !important; }

    /* Enhanced Progress Bars */
    .progress-container { margin-bottom: 20px; }
    .progress-label { display: flex; justify-content: space-between; font-size: 13px; margin-bottom: 8px; color: #1e293b; font-weight: 600; }
    .progress-custom { height: 12px; border-radius: 6px; background-color: #f1f5f9; overflow: hidden; box-shadow: inset 0 1px 2px rgba(0,0,0,0.1); }
    .progress-bar-enhanced { height: 100%; border-radius: 6px; transition: width 0.6s ease; position: relative; overflow: hidden; }
    
    /* Info Lists with Icons */
    .list-info-custom { margin: 0; padding: 0; list-style: none; }
    .list-info-custom li { display: flex; align-items: center; padding: 14px 0; border-bottom: 1px solid #f1f5f9; }
    .list-info-custom li:last-child { border-bottom: none; }
    .list-info-custom li i { width: 32px; font-size: 16px; color: #3b82f6 !important; text-align: left; display: inline-block !important; }
    .list-info-custom li .label-text { flex: 1; color: #64748b; font-weight: 500; font-size: 14px; }
    .list-info-custom li .value-text { font-weight: 700; color: #0f172a; font-size: 14px; text-align: right; }
    
    /* Control Panel Link Styling */
    .cp-link-container { display: inline-flex; align-items: center; background: #eff6ff; padding: 4px 12px; border-radius: 8px; border: 1px solid #dbeafe; color: #2563eb; font-weight: 700; text-decoration: none !important; transition: all 0.2s; }
    .cp-link-container:hover { background: #dbeafe; transform: scale(1.05); }
    .cp-link-container img { height: 16px; margin-right: 8px; }

    .accordion-custom .panel { border: 1px solid #e2e8f0; border-radius: 12px; margin-bottom: 12px; overflow: hidden; box-shadow: none; }
    .accordion-custom .panel-title a { display: block; padding: 16px 24px; color: #1e293b; font-weight: 700; text-decoration: none; background: #fff; }
    
    .loading-overlay { padding: 80px; text-align: center; background: #fff; border-radius: 20px; border: 1px solid #e2e8f0; }
    .meta-main { margin-bottom: 24px !important; }
    .product-title { font-size: 24px; font-weight: 900; color: #0f172a; margin: 0; }
    .server-domain { font-size: 16px; font-weight: 600; color: #64748b; margin-top: 4px; }
    
    /* Graph Image Auto-stretch - Force Full Width */
    .graph-img-full { width: 100% !important; max-width: 100% !important; height: auto !important; border-radius: 12px; border: 1px solid #e2e8f0; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); display: block; margin: 0 auto; }
    
    /* Usage Graphs Panel Style */
    .usage-graph-panel { border: 1px solid #e2e8f0; border-radius: 12px; margin-bottom: 12px; overflow: hidden; background: #fff; }
    .usage-graph-header { padding: 16px 24px; color: #1e293b; font-weight: 700; background: #fff; border-bottom: 1px solid #f1f5f9; display: flex; align-items: center; }
	</style>

{literal}
<script>
    $(function () {
        var reload = false;
        var url = window.location.href;
        patPre = '&serveraction=custom&a=';
        patAr = ['shutdown', 'reboot', 'boot'];
        for (var testPat in patAr) {
            pat = patPre + patAr[testPat];
            if(url.indexOf(pat) > 0){
                alertModuleCustomButtonSuccess = $('#alertModuleCustomButtonSuccess');
                if(alertModuleCustomButtonSuccess){
                    url = url.replace(pat,'');
                    window.location.href = url;
                    reload = true;
                }
                break;
            }
        }

        if(!reload){
            var vserverid = {/literal}{$data.vserverid}{literal};
            window.solusvmplus_get_and_fill_client_data(vserverid);
            window.solusvmplus_hostname(vserverid, {'solusvmplus_invalidHostname': '{/literal}{$LANG.solusvmplus_invalidHostname}{literal}','solusvmplus_change':'{/literal}{$LANG.solusvmplus_change}{literal}'});
            {/literal}
            {if $info['type'] != 'kvm'}
            {literal}
            window.solusvmplus_rootpassword(vserverid, {'solusvmplus_invalidRootpassword': '{/literal}{$LANG.solusvmplus_invalidRootpassword}{literal}','solusvmplus_change':'{/literal}{$LANG.solusvmplus_change}{literal}','solusvmplus_confirmRootPassword':'{/literal}{$LANG.solusvmplus_confirmRootPassword}{literal}','solusvmplus_confirmErrorPassword':'{/literal}{$LANG.solusvmplus_confirmErrorPassword}{literal}','solusvmplus_confirmPassword':'{/literal}{$LANG.solusvmplus_confirmPassword}{literal}'});
            {/literal}
            {/if}
            {literal}
            window.solusvmplus_vncpassword(vserverid, {'solusvmplus_invalidVNCpassword': '{/literal}{$LANG.solusvmplus_invalidVNCpassword}{literal}','solusvmplus_change':'{/literal}{$LANG.solusvmplus_change}{literal}','solusvmplus_confirmVNCPassword':'{/literal}{$LANG.solusvmplus_confirmVNCPassword}{literal}','solusvmplus_confirmErrorPassword':'{/literal}{$LANG.solusvmplus_confirmErrorPassword}{literal}','solusvmplus_confirmPassword':'{/literal}{$LANG.solusvmplus_confirmPassword}{literal}'});

                // Bandwidth Analysis Logic
                setTimeout(function() {
                    try {
                        var usedStr = "{$info['bandwidthused']}";
                        var totalStr = "{$info['bandwidthtotal']}";
                        var freeStr = "{$info['bandwidthfree']}";
                        
                        function parseSize(sizeStr) {
                            var num = parseFloat(sizeStr);
                            if (sizeStr.indexOf('TB') > -1) return num * 1024;
                            if (sizeStr.indexOf('GB') > -1) return num;
                            if (sizeStr.indexOf('MB') > -1) return num / 1024;
                            return num;
                        }

                        var used = parseSize(usedStr);
                        var total = parseSize(totalStr);
                        var free = parseSize(freeStr);

                        if (total > 0) {
                            var now = new Date();
                            var dayOfMonth = now.getDate();
                            var daysInMonth = new Date(now.getFullYear(), now.getMonth() + 1, 0).getDate();
                            
                            var monthPercent = (used / total * 100).toFixed(2) + '%';
                            var dailyAvg = (used / dayOfMonth).toFixed(2);
                            var daysLeft = dailyAvg > 0 ? Math.floor(free / dailyAvg) : '∞';
                            
                            $('#bw-month-percent').text(monthPercent);
                            $('#bw-daily-avg').text(dailyAvg + ' GB');
                            $('#bw-days-left').text(daysLeft + ' 天');
                            $('#bandwidth-analysis').fadeIn();
                        }
                    } catch(e) { console.log('BW Analysis Error:', e); }
                }, 1000);

            // Usage Statistics Graphs Accordion Logic Removed
        }
    });
{/literal}
{if $info['type'] == 'kvm'}
{literal}
    var completeFlag = true;
    function KVMChangeRootPassword(userID, vserverID) {
        swal({
            title: "Reset Root Password",
            type: "info",
            showCancelButton: true,
            closeOnConfirm: false,
            showLoaderOnConfirm: true,
            cancelButtonText: "Cancel",
            confirmButtonText: "Confirm",
        },
        function(){
            if(!completeFlag) {
                return;
            }
            $.ajax({
                method: "POST",
                url: "modules/servers/solusvmplus/password.php",
                data: {userid: userID, vserverid: vserverID},
                dataType: 'json',
                cache: false,
                beforeSend:function() {
                    completeFlag = false;
                },
                complete:function() {
                    completeFlag = true;
                },
                success: function(value) {
                    if(value.status=='success') {
                        swal({
                            title: "Password Reset Successfully",
                            text: value.rootpassword,
                            type: "success"
                        });
                        $('#password').html(value.rootpassword);
                    } else if (value.status=='error') {
                        swal({
                            title: "Password Reset Failed",
                            text: value.statusmsg,
                            type: "error"
                        });
                    };
                },
                error:function() {
                    swal("Server Busy, Please Try Again Later");
                }
            });
        });
    }
{/literal}
{/if}
</script>

<div class="solusvm-container">
    <!-- Header Section -->
    <div class="row">
        <div class="col-md-12">
            <div class="meta-main clearfix">
                <div class="pull-left">
                    <h1 class="product-title" style="display: flex; align-items: center; gap: 10px; margin-bottom: 8px;">
                        <i class="fa fa-server" style="color: #3b82f6; font-size: 20px;"></i>
                        <span style="font-size: 14px; color: #64748b; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; white-space: nowrap;">Virtual Server Type:</span>
                        <span style="color: #0f172a;">{$product}</span>
                    </h1>
                    <div class="server-domain" style="display: flex; align-items: center; gap: 10px;">
                        <i class="fa fa-globe" style="color: #3b82f6; font-size: 18px;"></i>
                        <span style="font-size: 13px; color: #64748b; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; white-space: nowrap;">Virtual Server HostName:</span>
                        <span style="color: #1e293b; font-weight: 600;">{$domain}</span>
                    </div>
                </div>
                <div class="pull-right" style="margin-top: 15px;">
                    <div class="btn-group">
                        <a href="javascript:location.reload()" class="btn btn-default btn-sm"><i class="fa fa-refresh"></i> Refresh</a>
                        <a href="index.php?m=UnlimitedGeninvoices" class="btn btn-default btn-sm"><i class="fa fa-credit-card"></i> Renew</a>
                        <a href="index.php?m=push" class="btn btn-default btn-sm"><i class="fa fa-exchange"></i> Transfer</a>
                        {if $showcancelbutton || $packagesupgrade}
                            {if $packagesupgrade}
                                <a href="upgrade.php?type=package&amp;id={$id}" class="btn btn-success btn-sm"><i class="fa fa-arrow-up"></i> Upgrade</a>
                            {/if}
                            <a href="clientarea.php?action=cancel&amp;id={$id}" class="btn btn-danger btn-sm {if $pendingcancellation}disabled{/if}"><i class="fa fa-times"></i> Cancel</a>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Loading State -->
    <div id="displayState" class="loading-overlay">
        <div class="loading"><span></span><span></span><span></span><span></span><span></span></div>
        <p style="margin-top: 20px; color: #64748b; font-weight: 600;">Fetching Real-time Data...</p>
    </div>

    <div id="displayStateUnavailable" class="alert alert-warning card-custom" style="display: none; text-align: center; padding: 50px;">
        <i class="fa fa-exclamation-triangle fa-3x" style="color: #f59e0b; margin-bottom: 20px;"></i><br>
        <strong style="font-size: 18px;">Server Connection Unavailable</strong>
    </div>

    <!-- Main Content -->
    <div class="row solusvm" style="display: none">
        <!-- Quick Stats Grid - Single Row -->
        <div class="col-md-12">
            <div class="stat-grid">
                <div class="stat-card"><i class="fa fa-microchip"></i><div class="title">CPU Cores</div><div class="info">{$info['cpus']} vCPU</div></div>
                <div class="stat-card"><i class="fa fa-tasks"></i><div class="title">Memory Capacity</div><div class="info">{$info['memory']}</div></div>
                <div class="stat-card"><i class="fa fa-database"></i><div class="title">Disk Storage</div><div class="info">{$info['disk']}</div></div>
                <div class="stat-card"><i class="fa fa-cube"></i><div class="title">Virtualization</div><div class="info">{$info['type']}</div></div>
            </div>
        </div>

        <div class="col-md-12 detail" style="display: none">
            <div class="row">
                <!-- Server Details Card -->
                <div class="col-md-6">
                    <div class="card-custom">
                        <div class="card-header-custom"><i class="fa fa-info-circle"></i><h4>Server Information</h4></div>
                        <div class="card-body-custom">
                            <ul class="list-info-custom">
                                <li><i class="fa fa-heartbeat"></i><span class="label-text">Server Status</span> <span class="value-text">{$info['displaystatus']}</span></li>
                                <li><i class="fa fa-server"></i><span class="label-text">Node</span> <span class="value-text">{$info['node']}</span></li>
                                <li><i class="fa fa-barcode"></i><span class="label-text">Mac Address</span> <span class="value-text">{$info['mac']}</span></li>
                                <li><i class="fa fa-globe"></i><span class="label-text">Main IP Address</span> <span class="value-text">{$info['connaddr']}</span></li>
                                {foreach from=$info['ipcsv'] item=extip}<li><i class="fa fa-plus-square"></i><span class="label-text" style="font-size: 12px;">Additional IP</span> <span class="value-text" style="font-size: 12px;">{$extip}</span></li>{/foreach}
                                {if ($isnat == 'Yes')}
                                    <li><i class="fa fa-plug"></i><span class="label-text">SSH Port</span> <span class="value-text">{$info['sshport']}</span></li>
                                    <li><i class="fa fa-random"></i><span class="label-text">NAT Port Range</span> <span class="value-text">{$info['firstport']} - {$info['lastport']}</span></li>
                                {/if}
                                <li><i class="fa fa-terminal"></i><span class="label-text">Operating System</span> <span class="value-text templates">{$info['template']}</span></li>
                                {if $cp['view']!='disable'}
                                    <li><i class="fa fa-exclamation-circle" style="color: #ef4444 !important;"></i><span class="label-text">Control Panel</span> <span class="value-text"><a href="{$cp['url']}" target="_blank" class="cp-link-container"><img src="https://www.google.com/s2/favicons?domain=vmshell.com&sz=32" alt="CP"> Login Panel</a></span></li>
                                    <li><i class="fa fa-user-circle"></i><span class="label-text">Panel Username</span> <span class="value-text">{$cp['username']}</span></li>
                                    <li><i class="fa fa-shield"></i><span class="label-text">Panel Password</span> <span class="value-text"><a href="javascript:void(0)" style="color:#3b82f6" onclick="javascript:$(this).hide();$('#password').show();">[ Show Password ]</a><span id="password" style="display: none; font-family: 'JetBrains Mono', monospace; background: #f1f5f9; padding: 2px 8px; border-radius: 4px; border: 1px solid #e2e8f0;">{$cp['password']}</span></span></li>
                                {/if}
                                <li><i class="fa fa-exchange"></i><span class="label-text">TUN/TAP Support</span> <span class="value-text"><a href="javascript:if(confirm('Enable TUN/TAP?'))location='clientarea.php?action=productdetails&id={$serviceid}&serveraction=custom&a=ontun';" class="text-success" style="font-weight: 700;">[ Enable ]</a> <a href="javascript:if(confirm('Disable TUN/TAP?'))location='clientarea.php?action=productdetails&id={$serviceid}&serveraction=custom&a=offtun';" class="text-danger" style="font-weight: 700;">[ Disable ]</a></span></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Resource Usage & Actions Card -->
                <div class="col-md-6">
                    <div class="card-custom">
                        <div class="card-header-custom"><span style="background: #3b82f6; color: #fff; padding: 2px 8px; border-radius: 6px; font-size: 12px; font-weight: 800; font-family: 'JetBrains Mono', monospace; display: inline-flex; align-items: center; justify-content: center; min-width: 65px; box-shadow: 0 2px 4px rgba(59, 130, 246, 0.3);"><i class="fa fa-calendar" style="font-size: 10px; margin-right: 4px;"></i>{"Y-m"|date}</span><h4 style="margin-left: 12px;">Resource Usage</h4><span style="margin-left: auto; color: #10b981; font-weight: 800; font-size: 14px; display: flex; align-items: center;"><i class="fa fa-pie-chart" style="margin-right: 6px;"></i>{$info['bandwidthpercent']}%</span></div>
                        <div class="card-body-custom">
                            {if ($info['type'] == 'openvz')}
                                <div class="progress-container">
                                    <div class="progress-label"><span><i class="fa fa-microchip"></i> Memory Usage</span><span>{$info['memoryused']} / {$info['memorytotal']}</span></div>
                                    <div class="progress progress-custom"><div class="progress-bar-enhanced {$info['memorycolor']}" style="width: {$info['memorypercent']}%;"></div></div>
                                </div>
                            {/if}

                            {if $info['type'] == 'openvz' || $info['type'] == 'xen'}
                                <div class="progress-container">
                                    <div class="progress-label"><span><i class="fa fa-hdd-o"></i> Disk Usage</span><span>{$info['hddused']} / {$info['hddtotal']}</span></div>
                                    <div class="progress progress-custom"><div class="progress-bar-enhanced {$info['hddcolor']}" style="width: {$info['hddpercent']}%;"></div></div>
                                </div>
                            {/if}

<div class="progress-container">
                                    <div class="progress-label"><span><i class="fa fa-cloud-download"></i> Bandwidth Usage</span><span>{$info['bandwidthused']} / {$info['bandwidthtotal']}</span></div>
                                    <div class="progress progress-custom"><div class="progress-bar-enhanced {$info['bandwidthcolor']}" style="width: {$info['bandwidthpercent']}%;"></div></div>
                                    
                                    <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px; margin-top: 15px;">
                                        <div style="background: #fff; padding: 10px; border-radius: 10px; border: 1px solid #f1f5f9; text-align: center;">
                                            <div style="font-size: 10px; color: #64748b; text-transform: uppercase; font-weight: 700; margin-bottom: 4px;">Used</div>
                                            <div style="font-size: 13px; font-weight: 800; color: #0f172a;">{$info['bandwidthused']}</div>
                                            <div style="margin-top: 5px; height: 3px; background: #f1f5f9; border-radius: 2px; overflow: hidden;">
                                                <div style="width: {$info['bandwidthpercent']}%; height: 100%; background: #3b82f6;"></div>
                                            </div>
                                        </div>
                                        <div style="background: #fff; padding: 10px; border-radius: 10px; border: 1px solid #f1f5f9; text-align: center;">
                                            <div style="font-size: 10px; color: #64748b; text-transform: uppercase; font-weight: 700; margin-bottom: 4px;">Total</div>
                                            <div style="font-size: 13px; font-weight: 800; color: #0f172a;">{$info['bandwidthtotal']}</div>
                                            <div style="margin-top: 5px; height: 3px; background: #f1f5f9; border-radius: 2px; overflow: hidden;">
                                                <div style="width: 100%; height: 100%; background: #e2e8f0;"></div>
                                            </div>
                                        </div>
                                        <div style="background: #fff; padding: 10px; border-radius: 10px; border: 1px solid #f1f5f9; text-align: center;">
                                            <div style="font-size: 10px; color: #64748b; text-transform: uppercase; font-weight: 700; margin-bottom: 4px;">Free</div>
                                            <div style="font-size: 13px; font-weight: 800; color: #0f172a;">{$info['bandwidthfree']}</div>
                                            <div style="margin-top: 5px; height: 3px; background: #f1f5f9; border-radius: 2px; overflow: hidden;">
                                                <div style="width: {100 - $info['bandwidthpercent']}%; height: 100%; background: #10b981;"></div>
                                            </div>
                                        </div>
                                    </div>

                                    <div id="bandwidth-analysis" style="margin-top: 15px; padding: 12px; background: #f8fafc; border-radius: 12px; border: 1px solid #e2e8f0; font-size: 12px; display: none;">
                                        <div style="display: flex; justify-content: space-between; margin-bottom: 6px;">
                                            <span style="color: #64748b;"><i class="fa fa-pie-chart" style="margin-right: 5px;"></i> Monthly Usage:</span>
                                            <span id="bw-month-percent" style="font-weight: 700; color: #0f172a;">-</span>
                                        </div>
                                        <div style="display: flex; justify-content: space-between; margin-bottom: 6px;">
                                            <span style="color: #64748b;"><i class="fa fa-line-chart" style="margin-right: 5px;"></i> Daily Average:</span>
                                            <span id="bw-daily-avg" style="font-weight: 700; color: #0f172a;">-</span>
                                        </div>
                                        <div style="display: flex; justify-content: space-between;">
                                            <span style="color: #64748b;"><i class="fa fa-calendar-check-o" style="margin-right: 5px;"></i> Estimated Days Left:</span>
                                            <span id="bw-days-left" style="font-weight: 700; color: #10b981;">-</span>
                                        </div>
                                    </div>
                                </div>

                            <!-- Big Icon Action Bar -->
                            <div class="action-grid">
                                {if $info['displayreboot'] == 1}
                                    <a href="javascript:if(confirm('Are You Sure You Want To Reboot This Server?'))location='clientarea.php?action=productdetails&id={$serviceid}&serveraction=custom&a=reboot';" class="btn-big-icon btn-reboot"><i class="fa fa-repeat"></i><span>Reboot</span></a>
                                {/if}
                                {if $info['displayboot'] == 1}
                                    <a href="javascript:if(confirm('Are You Sure You Want To Boot This Server?'))location='clientarea.php?action=productdetails&id={$serviceid}&serveraction=custom&a=boot';" class="btn-big-icon btn-boot"><i class="fa fa-play"></i><span>Boot</span></a>
                                {/if}
                                {if $info['displayshutdown'] == 1}
                                    <a href="javascript:if(confirm('Are You Sure You Want To Shutdown This Server?'))location='clientarea.php?action=productdetails&id={$serviceid}&serveraction=custom&a=shutdown';" class="btn-big-icon btn-shutdown"><i class="fa fa-power-off"></i><span>Shutdown</span></a>
                                {/if}
                                <a href="javascript:if(confirm('Are You Sure You Want To Reconfigure Network?'))location='clientarea.php?action=productdetails&id={$serviceid}&serveraction=custom&a=renetwork';" class="btn-big-icon btn-network"><i class="fa fa-wifi"></i><span>Network</span></a>
                                <a href="javascript:window.open('modules/servers/solusvmplus/vnc.php?id={$serviceid}', '_blank','width=800,height=600,status=no,location=no,toolbar=no,menubar=no,scrollbars=1,resizable=yes,titlebar=no')" class="btn-big-icon btn-vnc"><i class="fa fa-desktop"></i><span>VNC</span></a>
                                <a href="https://t.me/vmsus" target="_blank" class="btn-big-icon btn-telegram"><i class="fa fa-paper-plane"></i><span>TeleGram</span></a>
                            </div>
                            <!-- Friendly Links Section -->
                            <div style="margin-top: 20px; padding-top: 15px; border-top: 1px dashed #e2e8f0; display: flex; flex-wrap: wrap; gap: 15px; justify-content: center;">
                                <a href="https://tototel.com/" target="_blank" style="color: #64748b; font-size: 12px; font-weight: 600; text-decoration: none;"><i class="fa fa-link"></i> ToToTel</a>
                                <a href="https://vmshell.us/" target="_blank" style="color: #64748b; font-size: 12px; font-weight: 600; text-decoration: none;"><i class="fa fa-link"></i> VmShell eSIM</a>
                                <a href="https://vmbanks.com/" target="_blank" style="color: #64748b; font-size: 12px; font-weight: 600; text-decoration: none;"><i class="fa fa-link"></i> VmBanks(USDT)</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Usage Statistics Graphs - Always Expanded -->
        <div class="col-md-12">
            {if $info['displaygraphs'] == 1}
            <div class="usage-graph-panel">
                <div class="usage-graph-header"><i class="fa fa-tachometer" style="margin-right: 8px; color: #3b82f6;"></i><i class="fa fa-signal" style="margin-right: 10px; color: #10b981;"></i> Usage Statistics Graphs</div>
                <div class="panel-body text-center" style="background: #f8fafc; padding: 30px;">
                    <div class="row">
                                {if $info['displaytrafficgraph'] == 1}
                                    <div class="col-md-12" style="margin-bottom: 30px;">
                                        <img src="{$info['trafficgraphurl']|regex_replace:'/https?:\/\/[^\/]+/':'https://admin.vmshell.com'}" class="graph-img-full" alt="Traffic Graph" />
                                    </div>
                                {/if}
                                {if $info['displayloadgraph'] == 1}
                                    <div class="col-md-12" style="margin-bottom: 30px;">
                                        <h5 style="font-weight: 700; color: #475569; margin-bottom: 15px; text-align: left;"><i class="fa fa-line-chart"></i> Load Statistics</h5>
                                        <img src="{$info['loadgraphurl']|regex_replace:'/https?:\/\/[^\/]+/':'https://admin.vmshell.com'}" id="loadgraphurlImg" class="graph-img-full" alt="Load Graph" />
                                    </div>
                                {/if}
                                {if $info['displaymemorygraph'] == 1}
                                    <div class="col-md-12" style="margin-bottom: 30px;">
                                        <h5 style="font-weight: 700; color: #475569; margin-bottom: 15px; text-align: left;"><i class="fa fa-pie-chart"></i> Memory Statistics</h5>
                                        <img src="{$info['memorygraphurl']|regex_replace:'/https?:\/\/[^\/]+/':'https://admin.vmshell.com'}" id="memorygraphurlImg" class="graph-img-full" alt="Memory Graph" />
                                    </div>
                                {/if}
                    </div>
                </div>
            </div>
            {/if}

            <div class="panel-group accordion-custom" id="solusvmplus_accordion" role="tablist">
                {if $info['displayrootpassword'] == 1}
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingOne"><h4 class="panel-title"><a class="collapsed" role="button" data-toggle="collapse" data-parent="#solusvmplus_accordion" href="#solusvmplus_collapseOne"><i class="fa fa-key" style="margin-right: 10px; color: #ef4444;"></i> Change Root Password</a></h4></div>
                    <div id="solusvmplus_collapseOne" class="panel-collapse collapse" role="tabpanel">
                        <div class="panel-body" style="padding: 30px;">
                            <div id="rootpasswordMsgSuccess" class="alert alert-success" style="display: none"></div>
                            <div id="rootpasswordMsgError" class="alert alert-danger" style="display: none"></div>
                            <div class="row">
                                <div class="col-md-6"><div class="form-group"><label style="font-weight: 700; color: #475569;">New Root Password</label><input type="password" class="form-control" name="newrootpassword" id="newrootpassword" placeholder="Enter New Password"></div></div>
                                <div class="col-md-6"><div class="form-group"><label style="font-weight: 700; color: #475569;">Confirm New Password</label><input type="password" class="form-control" name="confirmnewrootpassword" id="confirmnewrootpassword" placeholder="Confirm New Password"></div></div>
                            </div>
                            <button type="button" id="changerootpassword" class="btn btn-primary" style="padding: 12px 30px; font-weight: 700; border-radius: 10px; background: #3b82f6; border: none;">Update Password</button>
                        </div>
                    </div>
                </div>
                {/if}
            </div>
        </div>

        <!-- Billing Details Card -->
        <div class="col-md-12">
            <div class="card-custom">
                <div class="card-header-custom"><i class="fa fa-credit-card"></i><h4>Billing Information</h4></div>
                <div class="card-body-custom">
                    <div class="row">
                        <div class="col-sm-4" style="margin-bottom: 20px;"><i class="fa fa-calendar-check-o" style="color: #3b82f6 !important; margin-right: 8px; display: inline-block !important;"></i><strong style="color: #64748b; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em;">Registration Date</strong><br><span style="font-weight: 700; color: #1e293b; margin-left: 24px;">{$regdate}</span></div>
                        <div class="col-sm-4" style="margin-bottom: 20px;"><i class="fa fa-refresh" style="color: #3b82f6 !important; margin-right: 8px; display: inline-block !important;"></i><strong style="color: #64748b; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em;">Billing Cycle</strong><br><span style="font-weight: 700; color: #1e293b; margin-left: 24px;">{$billingcycle}</span></div>
                        <div class="col-sm-4" style="margin-bottom: 20px;"><i class="fa fa-clock-o" style="color: #3b82f6 !important; margin-right: 8px; display: inline-block !important;"></i><strong style="color: #64748b; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em;">Next Due Date</strong><br><span style="font-weight: 700; color: #1e293b; margin-left: 24px;">{$nextduedate}</span></div>
                        <div class="col-sm-4" style="margin-bottom: 20px;"><i class="fa fa-money" style="color: #3b82f6 !important; margin-right: 8px; display: inline-block !important;"></i><strong style="color: #64748b; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em;">Payment Method</strong><br><span style="font-weight: 700; color: #1e293b; margin-left: 24px;">{$paymentmethod}</span></div>
                        {if $billingcycle != $LANG.orderpaymenttermonetime && $billingcycle != $LANG.orderfree}<div class="col-sm-4" style="margin-bottom: 20px;"><i class="fa fa-usd" style="color: #3b82f6 !important; margin-right: 8px; display: inline-block !important;"></i><strong style="color: #64748b; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em;">Recurring Amount</strong><br><span style="font-weight: 700; color: #1e293b; margin-left: 24px;">{$recurringamount}</span></div>{/if}
                        {if $suspendreason}<div class="col-sm-4 text-danger" style="margin-bottom: 20px;"><i class="fa fa-exclamation-triangle" style="color: #ef4444 !important; margin-right: 8px; display: inline-block !important;"></i><strong style="color: #ef4444; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em;">Suspension Reason</strong><br><span style="font-weight: 700; margin-left: 24px;">{$suspendreason}</span></div>{/if}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
