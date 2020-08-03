#Compare the rules from the current version to the previous version.

$rule_lists = Get-ChildItem $PSScriptRoot\ManualCheckRules*.txt | Sort-Object Name -Descending

$new_list = (Get-Content $rule_lists[0]).TrimStart("-").TrimStart()
$new = @()
foreach($new_item in $new_list){
    $new = $new + ($new_item -split " ")[0]
    }


$old_list = (Get-Content $rule_lists[1]).TrimStart("-").TrimStart()
$old = @()
foreach ($old_item in $old_list){
    $old = $old + ($old_item -split " ")[0]
    }

$new_rules = $new | where {$_ -notin $old }
$new_rules_array = @()
foreach($rule in $new_rules){
    $new_rules_array = $new_rules_array + ($new_list | where {$_ -match $rule})
    }
$new_rules_array | Out-File "$PSScriptRoot\NewManualRules.txt"

$old_rules = $old | where {$_ -notin $new }
$old_rules_array = @()
foreach($old_rule in $old_rules){
    $old_rules_array = $old_rules_array + ($old_list | where {$_ -match $old_rule})
    }
$old_rules_array | Out-File "$PSScriptRoot\OldManualRules.txt"