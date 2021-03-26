#
# Author: Jeremi Albrizio
# Date: 2021-03-26
# Version: 1.0
# powershell get power settings
#
# Sleep settings
#get the current active power plan
Powercfg /List | Select-String "GUID" | select-String "\*" |%{$a=$_.ToString().split(" ")} 
Set-Variable -Name Powerplan -Value $a[3]

#Query the poewr plan and get the GUIDs for the sleep settings and set the variables
Powercfg /Query $Powerplan | select-String "(Sleep)" | select-string "Subgroup GUID" |%{$a=$_.ToString().split(" ")} 
Set-Variable -Name sleepSubgroup -Value $a[4]
Powercfg /Query $Powerplan | select-String "(Sleep after)" |%{$a=$_.ToString().split(" ")} 
Set-Variable -Name sleeppowersettingGUID -Value $a[7]

#Query the poewr plan for the sleep settings, convert the results from hext to decimal, then set the results for DC as variables 
Powercfg /Q $Powerplan $sleepSubgroup $sleeppowersettingGUID | select-String "Current DC Power Setting Index" |%{$a=$_.ToString().split(" ")}
Set-Variable -Name sdc -Value $a[9]
[Convert]::ToString($sdc,10) | %{$a=$_.ToString().split(" ")}
Set-Variable -Name sdc1 -Value $a[0]

#Query the poewr plan for the sleep settings, convert the results from hext to decimal, then set the results for AC as variables 
Powercfg /Q $Powerplan $sleepSubgroup $sleeppowersettingGUID | select-String "Current AC Power Setting Index" |%{$a=$_.ToString().split(" ")}
Set-Variable -Name sac -Value $a[9]
[Convert]::ToString($sac,10) | %{$a=$_.ToString().split(" ")}
Set-Variable -Name sac1 -Value $a[0]

# Display settings
#get the current active power plan
Powercfg /List | Select-String "GUID" | select-String "\*" |%{$a=$_.ToString().split(" ")} 
Set-Variable -Name Powerplan -Value $a[3]

#Query the poewr plan and get the GUIDs for the display settings and set the variables
Powercfg /Query $Powerplan | select-String "(display)" | select-string "Subgroup GUID" |%{$a=$_.ToString().split(" ")} 
Set-Variable -Name displaySubgroup -Value $a[4]
Powercfg /Query $Powerplan | select-String "(display after)" |%{$a=$_.ToString().split(" ")} 
Set-Variable -Name displaypowersettingGUID -Value $a[7]

#Query the poewr plan for the display settings, convert the results from hext to decimal, then set the results for DC as variables 
Powercfg /Q $Powerplan $displaySubgroup $displaypowersettingGUID | select-String "Current DC Power Setting Index" |%{$a=$_.ToString().split(" ")}
Set-Variable -Name ddc -Value $a[9]
[Convert]::ToString($ddc,10) | %{$a=$_.ToString().split(" ")}
Set-Variable -Name ddc1 -Value $a[0]

#Query the poewr plan for the diaplay settings, convert the results from hext to decimal, then set the results for AC as variables 
Powercfg /Q $Powerplan $displaySubgroup $displaypowersettingGUID | select-String "Current AC Power Setting Index" |%{$a=$_.ToString().split(" ")}
Set-Variable -Name dac -Value $a[9]
[Convert]::ToString($dac,10) | %{$a=$_.ToString().split(" ")}
Set-Variable -Name dac1 -Value $a[0]

#Run an if then statement and echo a message if the sleep settings are greater than 0
if ( $sdc1 -gt 0 ){
echo "your Sleep settings need to be adjusted"
echo "DC sleep settings are set to $sdc1 seconds"
echo "AC sleep settings are set to $sac1 seconds"
echo "DC Display timeout settings are set to $ddc1 seconds"
echo "AC Display timeout settings are set to $dac1 seconds"
} elseif ( $sac1 -gt 0 ){
echo "your Sleep settings need to be adjusted"
echo "DC sleep settings are set to $sdc1 seconds"
echo "AC sleep settings are set to $sac1 seconds"
echo "DC Display timeout settings are set to $ddc1 seconds"
echo "AC Display timeout settings are set to $dac1 seconds"
} else {
echo "DC sleep settings are set to $sdc1 seconds"
echo "AC sleep settings are set to $sac1 seconds"
echo "DC Display timeout settings are set to $ddc1 seconds"
echo "AC Display timeout settings are set to $dac1 seconds"
}
