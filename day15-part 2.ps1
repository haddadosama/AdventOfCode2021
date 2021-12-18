$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36"
$session.Cookies.Add((New-Object System.Net.Cookie("_ga", "GA1.2.1254476810.1638562129", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("session", "53616c7465645f5f1bb680ce9385e0655b67e5795087d077f41445b3c5cf431e4b40d28f92f4d70476cdcdff26a4e648", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("_gid", "GA1.2.1837616298.1639365316", "/", ".adventofcode.com")))
$response = Invoke-WebRequest -UseBasicParsing -Uri "https://adventofcode.com/2021/day/15/input" `
    -WebSession $session `
    -Headers @{
    "method"                    = "GET"
    "authority"                 = "adventofcode.com"
    "scheme"                    = "https"
    "path"                      = "/2021/day/15/input"
    "cache-control"             = "max-age=0"
    "sec-ch-ua"                 = "`" Not A;Brand`";v=`"99`", `"Chromium`";v=`"96`", `"Google Chrome`";v=`"96`""
    "sec-ch-ua-mobile"          = "?0"
    "sec-ch-ua-platform"        = "`"Windows`""
    "upgrade-insecure-requests" = "1"
    "accept"                    = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"
    "sec-fetch-site"            = "same-origin"
    "sec-fetch-mode"            = "navigate"
    "sec-fetch-user"            = "?1"
    "sec-fetch-dest"            = "document"
    "referer"                   = "https://adventofcode.com/2021/day/15"
    "accept-encoding"           = "gzip, deflate, br"
    "accept-language"           = "en-US,en;q=0.9"
}

$data = $response.Content.split("`n")

cls
$matrix = New-Object -TypeName "System.Collections.ArrayList"
$pendning = @{}

for ($f = 0; $f -lt 5; $f++) {
    for ($i = 0; $i -lt $data.Length - 1; $i++) {
        $length = $data[$i].Length * 5
        $line = New-Object int[] $length;
        for ($j = 0; $j -lt $data[$i].Length; $j++) {
            for ($s = 0; $s -lt 5; $s++) {
                $pos = (($data[$i].Length) * $s) + $j
                $r = ([int32]::Parse($data[$i][$j]) + $s + $f)
                $line[$pos] = [math]::Floor( $r / 10) + ( $r % 10)
            }
       
        }
        [void]$matrix.add($line)
    }
    
    
}



$done = New-Object -TypeName "System.Collections.ArrayList"





$x = 0
$y = 0
$pendning.add(";$x;$y;", 0)

While ($x -ne $matrix[0].Count - 1 -or $y -ne $matrix.Count - 1) {

    [void]$done.add(";$y;$x;")
    
    $sum = $pendning[";$y;$x;"]
    $pendning.Remove(";$y;$x;")

    $i = $y
    $j = $x + 1
    if (-not $done.Contains(";$i;$j;") -and $j -ge 0 -and $j -le $matrix[0].Count - 1) {
        if ($pendning.ContainsKey(";$i;$j;")) {
            if ( $sum + $matrix[$i][$j] -lt $pendning[";$i;$j;"] ) {
                $pendning[";$i;$j;"] = $sum + $matrix[$i][$j]           
            }
        }
        else {
            $pendning.add(";$i;$j;", [int64]($sum + $matrix[$i][$j] ))
        }
    }
    $i = $y
    $j = $x - 1
    if (-not $done.Contains(";$i;$j;") -and $j -ge 0 -and $j -le $matrix[0].Count - 1) {
        if ($pendning.ContainsKey(";$i;$j;")) {
            if ( $sum + $matrix[$i][$j] -lt $pendning[";$i;$j;"] ) {
                $pendning[";$i;$j;"] = $sum + $matrix[$i][$j]           
            }
        }
        else {
            $pendning.add(";$i;$j;", [int64]($sum + $matrix[$i][$j] ))
        }
    }

    $i = $y + 1
    $j = $x
    if (-not $done.Contains(";$i;$j;") -and $i -ge 0 -and $i -le $matrix.Count - 1) {
        if ($pendning.ContainsKey(";$i;$j;")) {
            if ( $sum + $matrix[$i][$j] -lt $pendning[";$i;$j;"] ) {
                $pendning[";$i;$j;"] = $sum + $matrix[$i][$j]           
            }
        }
        else {
            $pendning.add(";$i;$j;", [int64]($sum + $matrix[$i][$j] ))
        }
    }

    $i = $y - 1
    $j = $x
    if (-not $done.Contains(";$i;$j;") -and $i -ge 0 -and $i -le $matrix.Count - 1) {
        if ($pendning.ContainsKey(";$i;$j;")) {
            if ( $sum + $matrix[$i][$j] -lt $pendning[";$i;$j;"] ) {
                $pendning[";$i;$j;"] = $sum + $matrix[$i][$j]           
            }
        }
        else {
            $pendning.add(";$i;$j;", [int64]($sum + $matrix[$i][$j] ))
        }
    }

    $c = 0
    $min = [int64]::MaxValue
    $minI = -1
    foreach ($v in $pendning.values) {
        if ($v -le $min) { 
            $min = $v
            $minI = $c
        } 
        $c++ 
    }


    $next = $($pendning.Keys)[$minI].Split(";")

    $y = [int]::Parse($next[1])
    $x = [int]::Parse($next[2])
}


$($pendning.Values)[$minI]