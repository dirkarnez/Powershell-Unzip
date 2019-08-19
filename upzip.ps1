Add-Type -Path ".\ICSharpCode.SharpZipLib.dll"

$outFolder = ".\unzip"

$wc = [System.Net.WebClient]::new()

$zipStream = $wc.OpenRead("https://download.sysinternals.com/files/ProcessExplorer.zip")

$zipInputStream = [ICSharpCode.SharpZipLib.Zip.ZipInputStream]::New($zipStream)

do {
	$entry = $zipInputStream.GetNextEntry()
	
	if ($entry -and $entry.Name -eq "procexp64.exe") {
		$fileName = $entry.Name
		$buffer = New-Object byte[] 4096
		$sw = [System.IO.File]::Create("$outFolder\$fileName")
		[ICSharpCode.SharpZipLib.Core.StreamUtils]::Copy($zipInputStream, $sw, $buffer)
		$sw.Close()
		break
	}
} while ($true)