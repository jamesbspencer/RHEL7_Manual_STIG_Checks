#Migrate Version 1 Scripts to Version 2



$script_root = $PSScriptRoot

$base_file = "$script_root\*Manual-xccdf.xml"

[xml]$base_xml = Get-Content $base_file

$os = ($base_xml.Benchmark.id -split "_" | where {$_ -ne "STIG"}) -join ""

# Output file encoding
$encoding = New-Object System.Text.UTF8Encoding $false

# Create an array to hold the V2 to V1 rule mappings and add the rules.
$vul_array = New-Object -TypeName System.Collections.ArrayList
[void]$vul_array.Add("V2 Vul ID, V2 Rule ID, V1 Vul ID, V1 Rule ID")
foreach($rule in $base_xml.Benchmark.Group){
    $v2vulid = $rule.id
    $v2ruleid = $rule.Rule.id
    $v1vulid = ($rule.Rule.ident | where {$_.system -eq "http://cyber.mil/legacy" -and $_.'#text' -match "^V-"}).'#text'
    $v1ruleid = ($rule.Rule.ident | where {$_.system -eq "http://cyber.mil/legacy" -and $_.'#text' -match "^SV-"}).'#text'
    [void]$vul_array.Add("$v2vulid, $v2ruleid, $v1vulid, $v1ruleid")

    # Rename the Version 1 script files to Version2 rule names
    $script_file = Get-ChildItem $script_root\..\rules | where {$_.BaseName -match "^$v1ruleid"}
    if ($script_file.Exists -eq $true -and $v1ruleid.length -gt 0 ){
        write-host "$v1ruleid matches $v2ruleid"
        $content = Get-Content -Path $script_file.FullName -Raw
        $new_content = $content -replace "$v1vulid", "$v2vulid"
        $new_content = $new_content -replace "$v1ruleid\S*", "$v2ruleid"
        $new_content | New-Item -Path $script_root\..\rules -Name "$v2ruleid.sh" -ItemType File -ErrorAction SilentlyContinue -Force | Out-Null
        Remove-Item -Path $script_file.FullName -Force
        }
    else {
        write-host "$V1ruleid no-match"
        }
    }

# Output the array to a csv. 
$vul_array | Out-File -FilePath "$script_root\$os-V2-V1_rule_map.csv" -Encoding utf8 -Force

