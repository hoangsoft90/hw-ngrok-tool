#Set-ExecutionPolicy RemoteSigned
function randomStr($Length){
    $set = "abcdefghijklmnopqrstuvwxyz0123456789".ToCharArray()
    $result = ""
    for ($x = 0; $x -lt $Length; $x++) {
        $result += $set | Get-Random
    }
    return $result
}
function tcpPort($port){
    $null, $null, $null, $null, $netstat = netstat -a -n -o
    [regex]$regexTCP = '(?<Protocol>\S+)\s+((?<LAddress>(2[0-4]\d|25[0-5]|[01]?\d\d?)\.(2[0-4]\d|25[0-5]|[01]?\d\d?)\.(2[0-4]\d|25[0-5]|[01]?\d\d?)\.(2[0-4]\d|25[0-5]|[01]?\d\d?))|(?<LAddress>\[?[0-9a-fA-f]{0,4}(\:([0-9a-fA-f]{0,4})){1,7}\%?\d?\]))\:(?<Lport>\d+)\s+((?<Raddress>(2[0-4]\d|25[0-5]|[01]?\d\d?)\.(2[0-4]\d|25[0-5]|[01]?\d\d?)\.(2[0-4]\d|25[0-5]|[01]?\d\d?)\.(2[0-4]\d|25[0-5]|[01]?\d\d?))|(?<RAddress>\[?[0-9a-fA-f]{0,4}(\:([0-9a-fA-f]{0,4})){1,7}\%?\d?\]))\:(?<RPort>\d+)\s+(?<State>\w+)\s+(?<PID>\d+$)'

    [regex]$regexUDP = '(?<Protocol>\S+)\s+((?<LAddress>(2[0-4]\d|25[0-5]|[01]?\d\d?)\.(2[0-4]\d|25[0-5]|[01]?\d\d?)\.(2[0-4]\d|25[0-5]|[01]?\d\d?)\.(2[0-4]\d|25[0-5]|[01]?\d\d?))|(?<LAddress>\[?[0-9a-fA-f]{0,4}(\:([0-9a-fA-f]{0,4})){1,7}\%?\d?\]))\:(?<Lport>\d+)\s+(?<RAddress>\*)\:(?<RPort>\*)\s+(?<PID>\d+)'

    [psobject]$process = "" | Select-Object Protocol, LocalAddress, Localport, RemoteAddress, Remoteport, State, PID, ProcessName

    foreach ($net in $netstat)
    {
        switch -regex ($net.Trim())
        {
            $regexTCP
            {        
                if($matches.LPort -eq "80" -and ($matches.LAddress -eq "0.0.0.0" -or $matches.LAddress -eq "[::]") ){
                    return $matches.PID
                }
           
            }
        }
    }
}
<##question yes or no
Extend from whm-cpanel-shell/functions.ps1
#>
function questionYesNo($msg, $def=""){  #($msg, $def)
    $message  = 'Hoangweb'
    $question = $msg

    $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
    $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'))
    $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'))

    if(Is-Numeric $def -and -not [string]::IsNullOrEmpty($def) ) {
        $decision=$def
    }
    else{
        $decision = $Host.UI.PromptForChoice($message, $question, $choices, 1)  #[int]$def
    }
    return $decision
}
## check if number
function Is-Numeric ($Value) {
    return $Value -match "^[\d\.]+$"
}
