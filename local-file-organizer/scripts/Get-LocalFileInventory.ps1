[CmdletBinding()]
param([Parameter(Mandatory)][string]$Root,[Parameter(Mandatory)][string]$StateDir)
$ErrorActionPreference='Stop';$rootFull=[IO.Path]::GetFullPath($Root).TrimEnd([IO.Path]::DirectorySeparatorChar);New-Item -ItemType Directory -Path $StateDir -Force|Out-Null
$csv=Join-Path $StateDir 'inventory.csv';$options=[IO.EnumerationOptions]::new();$options.RecurseSubdirectories=$true;$options.IgnoreInaccessible=$false;$options.AttributesToSkip=[IO.FileAttributes]0
$writer=[IO.StreamWriter]::new($csv,$false,[Text.UTF8Encoding]::new($false));$writer.WriteLine('"SourcePath","RelativePath","Name","Extension","SizeBytes","ModifiedUtc","Attributes"');[long]$count=0;[long]$bytes=0
function Q([object]$v){'"'+([string]$v).Replace('"','""')+'"'}
try{foreach($path in [IO.Directory]::EnumerateFiles($rootFull,'*',$options)){$f=[IO.FileInfo]::new($path);$rel=[IO.Path]::GetRelativePath($rootFull,$path);$writer.WriteLine((@($path,$rel,$f.Name,$f.Extension,$f.Length,$f.LastWriteTimeUtc.ToString('o'),$f.Attributes)|ForEach-Object{Q $_})-join',');$count++;$bytes+=$f.Length;if(($count%1000)-eq0){$writer.Flush()}}}finally{$writer.Flush();$writer.Dispose()}
$summary=[ordered]@{root=$rootFull;fileCount=$count;totalBytes=$bytes;generatedAt=(Get-Date).ToString('o');contentRead=$false;hashStored=$false};[IO.File]::WriteAllText((Join-Path $StateDir 'inventory-summary.json'),($summary|ConvertTo-Json),[Text.UTF8Encoding]::new($false));$summary|ConvertTo-Json
