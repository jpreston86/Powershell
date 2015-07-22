$ip = "IP address of machine on VPN"
$result = gwmi -query "SELECT * FROM Win32_PingStatus WHERE Address = '$ip'"
if ($result.StatusCode -eq 0) {
    Write-Host "$ip is up."
}
else{
    Write-Host "$ip is down."
    Write-Host "Disconnecting..."
    rasdial.exe /DISCONNECT
    Write-Host "Connecting..."
    rasdial.exe "VPN name" "VPN username" "VPN password"
}
