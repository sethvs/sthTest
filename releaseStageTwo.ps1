Param (
    $ReleaseDefinitionName,
    $ReleasePrimaryArtifactSourceAlias,
    $SystemDefaultWorkingDirectory,
    $NuGetApiKey
)
# $ModuleName = 'sthInvokeUsingCulture'

# $SourcePath = Join-Path -Path $(System.DefaultWorkingDirectory) -ChildPath "_$ModuleName"
# $SourcePath = Join-Path -Path $(System.DefaultWorkingDirectory) -ChildPath $(Release.PrimaryArtifactSourceAlias)
$SourcePath = Join-Path -Path $SystemDefaultWorkingDirectory -ChildPath $ReleasePrimaryArtifactSourceAlias
$ModulePath = Join-Path -Path $SystemDefaultWorkingDirectory -ChildPath $ReleaseDefinitionName
# $ModulePath = Join-Path -Path $(System.DefaultWorkingDirectory) -ChildPath $(Release.DefinitionName)
# $ModulePath = Join-Path -Path $(System.DefaultWorkingDirectory) -ChildPath $ModuleName

New-Item -ItemType Directory -Path $ModulePath | Out-Null
Copy-Item -Path $SourcePath\* -Include *.psd1, *.psm1, *.ps1,*.ps1xml -Exclude *_* -Destination $ModulePath
Copy-Item -Path $SourcePath\Tests -Destination $ModulePath -Exclude *_* -Recurse
Copy-Item -Path $SourcePath\en-us -Destination $ModulePath -Exclude *_* -Recurse
Copy-Item -Path $SourcePath\ru-ru -Destination $ModulePath -Exclude *_* -Recurse

Update-Module -Name PowerShellGet -Force
Write-Output '-------------'
Write-Output $NuGetApiKey
# Write-Output $(NuGetApiKey)
# Publish-Module -Path $ModulePath -NuGetApiKey $(NuGetApiKey) -Verbose
# Publish-Module -Path $ModulePath -NuGetApiKey $NuGetApiKey -Verbose