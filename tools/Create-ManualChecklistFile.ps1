## Create manual checklist file. 

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
$id = $base_xml.Benchmark.id
$ver = $base_xml.Benchmark.version
$rel = ((($base_xml.Benchmark.'plain-text'.'#text' -split ":")[1]).Trim() -split " ")[0]
$title = $base_xml.Benchmark.title
$key = $base_xml.Benchmark.Group[0].Rule.reference.identifier

$out_filename = $id + "-V" + $ver +"R$rel-ManualChecks.ckl"
$out_fullpath = Join-Path $script_root $out_filename

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



# New XML writer to store the output.
    $xmlWriterSettings = [System.Xml.XmlWriterSettings]::new()
    $xmlWriterSettings.Indent = $true
    $xmlWriterSettings.IndentChars = " "
    $xmlWriterSettings.NewLineChars = "`n"
    $writer = [System.Xml.XmlWriter]::Create($out_fullpath, $xmlWriterSettings)

$writer.WriteComment("Possible STATUS values are: Open, NotAFinding, Not_Applicable, Not_Reviewed")
$writer.WriteComment("Possible TECH_AREA values are: UNIX OS, Windows OS")
$writer.WriteStartElement("CHECKLIST")
$writer.WriteStartElement("ASSET")
$writer.WriteElementString("ROLE", "Member Server")
$writer.WriteElementString("ASSET_TYPE", "Computing")
$writer.WriteElementString("HOST_NAME", "server_name")
$writer.WriteElementString("HOST_IP", "0.0.0.0")
$writer.WriteElementString("HOST_MAC", "00:00:00:00:00:00")
$writer.WriteElementString("HOST_FQDN", "server_name.domain.tld")
$writer.WriteElementString("TECH_AREA", "UNIX OS")
$writer.WriteElementString("TARGET_KEY", "$key")
$writer.WriteElementString("WEB_OR_DATABASE", "false")
$writer.WriteStartElement("WEB_DB_SITE")
$writer.WriteFullEndElement(<#WEB_DB_SITE#>)
$writer.WriteStartElement("WEB_DB_INSTANCE")
$writer.WriteFullEndElement(<#WEB_DB_INSTANCE#>)
$writer.WriteEndElement(<#ASSET#>)
$writer.WriteStartElement("STIGS")
$writer.WriteStartElement("iSTIG")
$writer.WriteStartElement("STIG_INFO")
$writer.WriteStartElement("SI_DATA")
$writer.WriteElementString("SID_NAME", "title")
$writer.WriteElementString("SID_DATA", "$title")
$writer.WriteEndElement(<#SI_DATA#>)
$writer.WriteEndElement(<#STIG_INFO#>)

foreach($rule in $man_array){
    $writer.WriteStartElement("VULN")
    $writer.WriteStartElement("STIG_DATA")
    $writer.WriteElementString("VULN_ATTRIBUTE", "Rule_ID")
    $writer.WriteElementString("ATTRIBUTE_DATA", "$rule")
    $writer.WriteEndElement(<#STIG_DATA#>)
    $writer.WriteElementString("STATUS", "Not_Reviewed")
    $writer.WriteElementString("FINDING_DETAILS", "details")
    $writer.WriteElementString("COMMENTS", "comment")
    $writer.WriteStartElement("SEVERITY_OVERRIDE")
    $writer.WriteFullEndElement(<#SEVERITY_OVERRIDE#>)
    $writer.WriteStartElement("SEVERITY_JUSTIFICATION")
    $writer.WriteFullEndElement(<#SEVERITY_JUSTIFICATION#>)
    $writer.WriteEndElement(<#VULN#>)
    }

$writer.WriteEndElement(<#iSTIG#>)
$writer.WriteEndElement(<#STIGS#>)
$writer.WriteEndElement(<#CHECKLIST#>)



$writer.Flush()
$writer.Close()