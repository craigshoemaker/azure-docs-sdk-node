function CloneOrPull
{
      param([string]$gitRepo, [string]$branch, [string]$folderName)

      if (Test-Path $folderName\.git)
      {
          Push-Location $folderName
          & git pull
          Pop-Location
      }
      else
      {
          & git clone -c core.longpaths=true -q --branch=$branch $gitRepo $folderName
      }
}

$ErrorActionPreference = 'Stop'

$scriptPath = $MyInvocation.MyCommand.Path
$rootFolder = Split-Path $scriptPath | Split-Path
$src = "src"
md -Force $rootFolder\$src
Push-Location $rootFolder\$src

$url = "https://github.com/Azure/azure-sdk-for-node"
$branch = "jsdoc"
$name = "azure-sdk-for-node"
CloneOrPull $($url) $($branch) $($name)
$url = "https://github.com/Azure/azure-storage-node"
$branch = "master"
$name = "azure-storage-node"
CloneOrPull $($url) $($branch) $($name)

Pop-Location
