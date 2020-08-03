# Create New Manual Checklist Script Files
# Run Compare-ManualCHeckRules.ps1 first

$rules = Get-Content "$PSScriptRoot\NewManualRules.txt"
foreach ($rule in $rules){
    $name = ($rule -split " ")[0]
    $id = ($rule -split " ")[2]
    $content = New-Object -TypeName System.Collections.ArrayList
    [void]$content.Add("#!/bin/bash")
    [void]$content.Add("`n`n")
    [void]$content.Add("# $rule")
    [void]$content.Add("`n")
    [void]$content.Add("# Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed")
    [void]$content.Add("`n")
    [void]$content.Add("result=`'Not_Reviewed`'")
    [void]$content.Add("`n`n`n`n")
    [void]$content.Add("echo `"$id - $name - `$result - `$finding`" ")
    [void]$content.Add("`n")
    New-Item -Path $PSScriptRoot -Name "$name.sh" -ItemType File -Value $content -Force | Out-Null
    }