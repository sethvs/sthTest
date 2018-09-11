Remove-Module -Name sthPipelineTools -Force -ErrorAction 'SilentlyContinue'
Import-Module "$PSScriptRoot\..\sthTest.psd1"
# Write-Host $PSScriptRoot 
Describe 'sthTest Tests' {
    Context "Format string as currency" {

        It "Should return <Culture> currency: <Result>" -TestCases @(
            # @{Culture = 'ru-RU'; Number = 123; Result = '123,00 ₽'},
            @{Culture = 'ru-RU'; Number = 123; Result = [System.Text.Encoding]::UTF8.GetString(@(49,50,51,44,48,48,32,226,130,189))},
            # @{Culture = 'nl-NL'; Number = 123; Result = '€ 123,00'}
            @{Culture = 'nl-NL'; Number = 123; Result = [System.Text.Encoding]::UTF8.GetString(@(226,130,172,32,49,50,51,44,48,48))},
            # @{Culture = 'en-US'; Number = 123; Result = '$123.00'}
            @{Culture = 'en-US'; Number = 123; Result = [System.Text.Encoding]::UTF8.GetString(@(36,49,50,51,46,48,48))}
        )   {
            Param($Culture, $Number, $Result)
            Invoke-sthUsingCulture -Culture $Culture -ScriptBlock {"{0:c}" -f $Number} | Should -BeExactly $Result
        }
    }

    Context "Get Current Culture" {

        It "Should return Culture <Culture>" -TestCases @(
            @{CultureInfo = [System.Globalization.CultureInfo]'ru-RU'; Culture = 'ru-RU'},
            @{CultureInfo = [System.Globalization.CultureInfo]'nl-NL'; Culture = 'nl-NL'},
            @{CultureInfo = [System.Globalization.CultureInfo]'en-US'; Culture = 'en-US'}
        )   {
            Param([System.Globalization.CultureInfo]$CultureInfo, [String]$Culture)
            Invoke-sthUsingCulture -Culture $CultureInfo -ScriptBlock {[System.Threading.Thread]::CurrentThread.CurrentCulture.Name} | Should -BeExactly $Culture
            Invoke-sthUsingCulture -Culture $CultureInfo -ScriptBlock {[System.Threading.Thread]::CurrentThread.CurrentCulture.Name} | Should -BeExactly $Culture
        }
    }
}