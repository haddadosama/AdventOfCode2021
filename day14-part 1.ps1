$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36"
$session.Cookies.Add((New-Object System.Net.Cookie("_ga", "GA1.2.1254476810.1638562129", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("session", "53616c7465645f5f1bb680ce9385e0655b67e5795087d077f41445b3c5cf431e4b40d28f92f4d70476cdcdff26a4e648", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("_gid", "GA1.2.1837616298.1639365316", "/", ".adventofcode.com")))
$response = Invoke-WebRequest -UseBasicParsing -Uri "https://adventofcode.com/2021/day/14/input" `
    -WebSession $session `
    -Headers @{
    "method"                    = "GET"
    "authority"                 = "adventofcode.com"
    "scheme"                    = "https"
    "path"                      = "/2021/day/14/input"
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
    "referer"                   = "https://adventofcode.com/2021/day/14"
    "accept-encoding"           = "gzip, deflate, br"
    "accept-language"           = "en-US,en;q=0.9"
}
$data = $response.Content.Split("`n")
$sentense = $data[0]
$template = $data[2..101]
cls
            
$steps = 10

$pairs = New-Object string[] $template.Length;
$values = New-Object char[] $template.Length;
$unique = New-Object -TypeName "System.Collections.ArrayList"
$counts = New-Object int64[] $template.Length;

for ($i = 0; $i -lt $template.Length; $i++) {
    $line = $template[$i].Split(" -> ")
    $pairs[$i] = $line[0]
    $values[$i] = $line[4]
    if (-not $unique.Contains($line[4])) {
        [void]$unique.Add($line[4])
    }
}

for ($j = 0; $j -lt $sentense.length - 1; $j++) {
    $L1 = $sentense[$j]
    $L2 = $sentense[$j + 1]
    $counts[$pairs.IndexOf("$L1$L2")]++
}

for ($i = 0; $i -lt $steps; $i++) {

    $temp = $counts.PSObject.Copy()
    for ($j = 0; $j -lt $template.Length; $j++) {

        if ($counts[$j] -gt 0) {
            $temp[$j] -= $counts[$j] 
            $temp[$pairs.IndexOf("$($pairs[$j][0])$($values[$j])")] += $counts[$j]
            $temp[$pairs.IndexOf("$($values[$j])$($pairs[$j][1])")] += $counts[$j]
            
        }

    }
    $counts = $temp.PSObject.Copy()

   
 
}

$max = 0
$min = 0
for ($i = 0; $i -lt $unique.count; $i++) {
    $charCount = 0
    if ($unique[$i] -eq $sentense[$sentense.Length - 1]) {
        $charCount++
    }
    for ($j = 0; $j -lt $template.Length; $j++) {
    
        if ($pairs[$j][0] -eq $unique[$i]) {
            $charCount += $counts[$j]
        }
    }
    if ($charCount -gt $max) {
        $max = $charCount
    }
    if ($charCount -lt $min -or $min -eq 0) {
        $min = $charCount
    }
}

$max - $min 



