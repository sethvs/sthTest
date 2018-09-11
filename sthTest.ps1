function Invoke-sthUsingCulture
{
    Param(
        [System.Globalization.CultureInfo]$Culture,
        [ScriptBlock]$ScriptBlock
    )

    $CurrentCulture = [System.Threading.Thread]::CurrentThread.CurrentCulture
    $CurrentUICulture = [System.Threading.Thread]::CurrentThread.CurrentUICulture

    try
    {
        [System.Threading.Thread]::CurrentThread.CurrentCulture = $Culture
        [System.Threading.Thread]::CurrentThread.CurrentUICulture = $Culture
        Invoke-Command -ScriptBlock $ScriptBlock
    }
    finally
    {
        [System.Threading.Thread]::CurrentThread.CurrentCulture = $CurrentCulture
        [System.Threading.Thread]::CurrentThread.CurrentUICulture = $CurrentUICulture
    }
}
