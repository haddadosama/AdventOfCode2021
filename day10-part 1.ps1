$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36"
$session.Cookies.Add((New-Object System.Net.Cookie("_ga", "GA1.2.1254476810.1638562129", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("_gid", "GA1.2.580710830.1638562129", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("session", "53616c7465645f5f1bb680ce9385e0655b67e5795087d077f41445b3c5cf431e4b40d28f92f4d70476cdcdff26a4e648", "/", ".adventofcode.com")))
$respose = Invoke-WebRequest -UseBasicParsing -Uri "https://adventofcode.com/2021/day/10/input" `
-WebSession $session `
-Headers @{
"method"="GET"
  "authority"="adventofcode.com"
  "scheme"="https"
  "path"="/2021/day/10/input"
  "cache-control"="max-age=0"
  "sec-ch-ua"="`" Not A;Brand`";v=`"99`", `"Chromium`";v=`"96`", `"Google Chrome`";v=`"96`""
  "sec-ch-ua-mobile"="?0"
  "sec-ch-ua-platform"="`"Windows`""
  "upgrade-insecure-requests"="1"
  "accept"="text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"
  "sec-fetch-site"="same-origin"
  "sec-fetch-mode"="navigate"
  "sec-fetch-user"="?1"
  "sec-fetch-dest"="document"
  "referer"="https://adventofcode.com/2021/day/10"
  "accept-encoding"="gzip, deflate, br"
  "accept-language"="en-US,en;q=0.9"
}

$data = $respose.Content.split("`n")

cls


$counts = @(0,0,0,0)

$closingsigns = ')]}>'
$openingsigns = '({<['




for($x = 0; $x -lt $data.Count; $x++)
{
    $y =0
    $goodline = $true
    
    $open = ""
    $close = ""
    while($goodline -and $y -lt $data[$x].length)
    {
        $current = $data[$x][$y]
        if($openingsigns.Contains($current))
        {
            $open+=$current
        }else{
            $currentint = [int32]([char]$current)
            $lastopeningint = [int32]([char]$open[$open.Length-1])
            if([Math]::Abs($currentint-$lastopeningint) -le 2)
            {
               $open =  $open.Substring(0,$open.Length-1)
            }
            else
            {
                $counts[$closingsigns.IndexOf($current)]++
                $goodline = $false
            }
        }
        
        $y++
    }
}

$counts[0] *= 3
$counts[1] *= 57
$counts[2] *= 1197
$counts[3] *= 25137

$counts | Measure-Object -Sum