## Create manual check scripts

# Where are we?
$script_root = $PSScriptRoot

# Our STIG 
$base_file = "$script_root\*Manual-xccdf.xml"

# Our SCAP Benchmark file.
$bench_file = "$script_root\*Benchmark.xml"

# Read both files as XML.
[xml]$base_xml = Get-Content $base_file
[xml]$bench_xml = Get-Content $bench_file


#Get the rules from our Benchmark file and put them in an array.
$bench_rules = ($bench_xml.'data-stream-collection'.component | where {$_.id -match "xccdf"}).Benchmark.Group
$bench_array = New-Object -TypeName System.Collections.ArrayList
foreach($bench_rule in $bench_rules){
    [void]$bench_array.Add(($bench_rule.Rule.id -split "rule_")[1])
    }


# Get the rules from our base STIG file and put them in an array also. 
$base_rules = $base_xml.Benchmark.Group
$base_array = New-Object -TypeName System.Collections.ArrayList
foreach($base_rule in $base_rules){
    [void]$base_array.Add($base_rule.Rule.id)
    }

# Subtract the items in our Benchmark array from the items in our Base array. This gives us our manual checks.
$man_array = Compare-Object -ReferenceObject $base_array -DifferenceObject $bench_array -PassThru

$description_array = New-Object -TypeName System.Collections.ArrayList
foreach($man_rule in $man_array){
    $rule_id = ($base_rules | where {$_.Rule.id -match $man_rule}).id
    $rule_title = ($base_rules | where {$_.Rule.id -match $man_rule}).Rule.title
    Write-host $man_rule $rule_id $rule_title
    [void]$description_array.Add("- $man_rule - $rule_id - $rule_title")
    }

# Variables for our file name.
$ver = $base_xml.Benchmark.version
$rel = ((($base_xml.Benchmark.'plain-text'.'#text' -split ":")[1]).Trim() -split " ")[0]

$description_array | Out-File -FilePath "$script_root\ManualCheckRulesV$ver`R$rel.txt" -Force