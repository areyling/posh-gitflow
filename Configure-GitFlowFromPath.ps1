﻿<# 
.SYNOPSIS 
    Adds PowerShell GitFlow extensions to GitHub for Windows
.DESCRIPTION
    This script adds support for PowerShell GitFlow to GitHub for Windows. The GitFlow scripts were developed
    by nvie (https://github.com/nvie/gitflow). This script is itself a modified version of a script developed 
    by Howard van Rooijen and documented in a fantastic series of blog posts about using GitHub with TeamCity: 
    http://blogs.endjin.com/2013/03/a-step-by-step-guide-to-using-gitflow-with-teamcity-part-1-different-branching-models/
.LINK 
    http://github.com/jhoerr/posh-gitflow
#>
Function Configure-GitFlow
{
	$currentPath = Split-Path ${function:Configure-GitFlow}.File -Parent

	$gitExe = Get-Command git -ea SilentlyContinue
	if($gitExe)
	{
		$gitPath = Join-Path (Split-Path -Parent (Split-Path -Parent $gitExe.Definition)) 'bin'
		Write-Host "Installing extensions to Git binaries in '$gitPath'" -ForegroundColor Green

		Write-Host "Copying Required supporting binaries"
		Copy-Item (Join-Path $currentPath "Dependencies\*.*") -Destination $gitPath -Verbose
			
		Write-Host "Copying GitFlow extensions"
		Copy-Item (Join-Path $currentPath "GitFlowExtensions\**") -Destination $gitPath -Verbose
			
		Write-Host "Copying Git components"
		Copy-Item (Join-Path $gitPath "libiconv-2.dll") -Destination (Join-Path $gitPath "libiconv2.dll") -Verbose
	}
	else
	{
		Write-Error 'git not found! Please add git to your PATH environment variable and try again.'
	}

	Write-Host "Press Enter to finish"
	Read-Host
}

Configure-GitFlow
