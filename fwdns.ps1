# make empty rule with name "access:<domain>" and add this script to scheduler

$ddnsRules = Get-NetFirewallRule | Where-Object {$_.DisplayName -match '^access:' -and $_.Enabled -eq $true}

foreach ($rule in $ddnsRules) {
    $date = Get-Date -Format "HH:mm:ss dd.MM.yyyy";
    $description = "Rule updated $($date): ";

    $domain = $rule.DisplayName.Substring(7);

    try {
        $ips = Resolve-DnsName $domain -Type A -ErrorAction Stop | ForEach-Object { $_.IPAddress };
    } catch {
         Write-Host "[$($date)] [E] Applying rule $($rule.Name): domain=$($domain) ERROR: cannot resolve dns name, continue";
         $description += "cannot resolve dns name";
         $rule | Set-NetFirewallRule -Description $description;
         continue;
    }

    $description += "success";
    $rule | Set-NetFirewallRule -RemoteAddress $ips -Description $description;
    Write-Host "[$($date)] [I] Applying rule $($rule.Name): domain=$($domain) ips=$($ips)";
}
