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

# STIG info
$id = ($base_xml.Benchmark.id -split "_" | where {$_ -ne "STIG"}) -join ""

# Output directory
$dest_folder = Join-Path $script_root $id

# Does it exist?
if( -not (Test-Path $dest_folder)){
    New-Item -ItemType Directory -Path $script_root -Name $id
    }

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

# Now let's create a file for each manual check rule.
foreach($rule in $man_array){
    # BUT first we need some content.
    $rule_data = $base_rules | where {$_.Rule.id -eq $rule}
    $content = New-Object -TypeName System.Collections.ArrayList
    [void]$content.Add("#!/bin/bash")
    [void]$content.Add("`n`n")
    [void]$content.Add("# $($rule_data.id) - $($rule_data.Rule.id) - $($rule_data.Rule.title)")
    [void]$content.Add("# Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed")
    [void]$content.Add("`n")
    [void]$content.Add("result=`'Not_Reviewed`'")
    [void]$content.Add("`n`n`n`n")
    [void]$content.Add("echo `"$($rule_data.id) - $($rule_data.Rule.id) - `$result`" ")
    [void]$content.Add("`n")
    #[void]$content.Add("export result")
    Write-Host "Creating file for $rule"

    New-Item -Path $dest_folder -Name "$rule.sh" -ItemType File -Value $content -ErrorAction SilentlyContinue -Force | Out-Null

    }
