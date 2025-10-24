$bin = [System.IO.File]::ReadAllBytes("build/os.bin")
$pad = New-Object Byte[] (510 - $bin.Length)
$sig = [Byte[]](0x55,0xAA)
$final = $bin + $pad + $sig
[System.IO.File]::WriteAllBytes("build/final.bin", $final)
