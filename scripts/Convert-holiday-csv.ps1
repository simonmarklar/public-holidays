function Import-HolidayCsv {
<#
    .SYNOPSIS 
    Imports and formats the CSV file obtained from data.gov.au
    .PARAMETER CsvPath 
    The path to the CSV file
    .PARAMETER JsonPath
    The path to the output JSON file
    .DESCRIPTION
    Get the CSV file from https://data.gov.au/data/dataset/australian-holidays-machine-readable-dataset

    then run this function to convert it to JSON.
#>
    param(
        [Parameter(Mandatory=$true)]
        [string]$CsvPath,
        [Parameter(Mandatory=$true)]
        [string]$JsonPath
    )

    import-csv -Path $CsvPath | 
        Select-Object -Property  @{label="holidayName"; Expression={$_."Holiday Name"}}, 
            @{label="information"; Expression={$_.Information}},
            @{label="State"; Expression={$_.Jurisdiction}}, 
            @{label="Year";expression={[int]$_.Date.substring(0,4)}}, 
            @{label="Month";expression={[int]$_.Date.substring(4,2)}}, 
            @{label="Day";expression={[int]$_.Date.substring(6, 2)}} | 
        ConvertTo-Json | 
        Out-File -FilePath $JsonPath
}

Import-HolidayCsv