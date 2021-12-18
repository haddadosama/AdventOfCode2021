$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36"
$session.Cookies.Add((New-Object System.Net.Cookie("_ga", "GA1.2.1254476810.1638562129", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("_gid", "GA1.2.580710830.1638562129", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("session", "53616c7465645f5f1bb680ce9385e0655b67e5795087d077f41445b3c5cf431e4b40d28f92f4d70476cdcdff26a4e648", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("_gat", "1", "/", ".adventofcode.com")))
$response = Invoke-WebRequest -UseBasicParsing -Uri "https://adventofcode.com/2021/day/11/input" `
    -WebSession $session `
    -Headers @{
    "method"                    = "GET"
    "authority"                 = "adventofcode.com"
    "scheme"                    = "https"
    "path"                      = "/2021/day/11/input"
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
    "referer"                   = "https://adventofcode.com/2021/day/11"
    "accept-encoding"           = "gzip, deflate, br"
    "accept-language"           = "en-US,en;q=0.9"
}

$data = $response.content.Split("`n")

$matrix = @((New-Object int[] 10), (New-Object int[] 10), (New-Object int[] 10), (New-Object int[] 10), (New-Object int[] 10), (New-Object int[] 10), (New-Object int[] 10), (New-Object int[] 10), (New-Object int[] 10), (New-Object int[] 10))



for ($i = 0; $i -lt $data.Count; $i++) {
    for ($j = 0; $j -lt $data[$i].Length; $j++) {
        $matrix[$i][$j] = [int32]::Parse($data[$i][$j])
    }
}
cls

$matrix | % { $_ -join "" }

cls

$flashing = New-Object -TypeName "System.Collections.ArrayList"

$done = $false

for ($s = 0; $s -lt 1000; $s++) {
    for ($i = 0; $i -lt $matrix.Length; $i++) {
        for ($j = 0; $j -lt $matrix[$i].Length; $j++) {
            $matrix[$i][$j]++
            if ($matrix[$i][$j] -eq 10) {
                [void]$flashing.Add(@($j, $i))
            }
        }
        
    }
    $count = 0

    while ($flashing.Count -gt 0) {
        $i = $flashing[0][1]
        $j = $flashing[0][0]

        for ($y = $i - 1; $y -le $i + 1; $y++) {
            if ($y -ge 0 -and $y -lt 10) {
                for ($x = $j - 1; $x -le $j + 1; $x++) {
                    if ($x -ge 0 -and $x -lt 10) {
                        $matrix[$y][$x]++
                        if ($matrix[$y][$x] -eq 10) {
                            [void]$flashing.Add(@($x, $y))
                        }
                    }
                }
            }
        }


        $flashing.RemoveAt(0);
        $count++
        if ($count -eq 100) {
            $done = $true
            break
        }
    }
    
  
    for ($i = 0; $i -lt $matrix.Length; $i++) {
        for ($j = 0; $j -lt $matrix[$i].Length; $j++) {
            if ($matrix[$i][$j] -gt 9) {
                $matrix[$i][$j] = 0
            }
        }
        
    }

    $matrix | % { $_ -join "" }
    "------------------------------------------------"
    if ($done) {
        break
    }


}

$s + 1