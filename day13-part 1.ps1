$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36"
$session.Cookies.Add((New-Object System.Net.Cookie("_ga", "GA1.2.1254476810.1638562129", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("session", "53616c7465645f5f1bb680ce9385e0655b67e5795087d077f41445b3c5cf431e4b40d28f92f4d70476cdcdff26a4e648", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("_gid", "GA1.2.1837616298.1639365316", "/", ".adventofcode.com")))
$response = Invoke-WebRequest -UseBasicParsing -Uri "https://adventofcode.com/2021/day/13/input" `
-WebSession $session `
-Headers @{
"method"="GET"
  "authority"="adventofcode.com"
  "scheme"="https"
  "path"="/2021/day/13/input"
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
  "referer"="https://adventofcode.com/2021/day/13"
  "accept-encoding"="gzip, deflate, br"
  "accept-language"="en-US,en;q=0.9"
}

$data = ($response.Content -split "`n`n")

$pointsraw=$data[0].split("`n")

$folds = $data[1].split("`n")
cls



$maxy =0
$maxx = 0

$points = New-Object -TypeName "System.Collections.ArrayList"

function display($points,$sizex, $sizey)
{

    [System.Collections.ArrayList]$display = @()
    for ($y = 0; $y -lt $sizey; $y++) {
        [System.Collections.ArrayList]$line = @()
        for ($i = 0; $i -lt $sizex; $i++) {
            [void]$line.Add(".")
        }
        [void]$display.Add($line)
    }

    for ($i = 0; $i -lt $points.Count; $i++) {
        $display[$points[$i][1]][$points[$i][0]] = "#"
    
    }
    $count= 0
    $display | %{ 
        $_ -join "" 
        $charCount = ($_ | Where-Object {$_ -eq '#'} | Measure-Object).Count
        $count+=$charCount
    }

    $count
}

$pointsraw | %{
 $point = $_.Split(",")   
 $x= [int32]::Parse($point[0])
 $y= [int32]::Parse($point[1])

 [void]$points.Add(@($x,$y))
 if($x -gt $maxx)
 {
    $maxx = $x
 }
 if($y -gt $maxy)
 {
    $maxy = $y
 }
}
$maxx++
$maxy++

for($f=0;$f -lt 1;$f++)
{
    $fold = $folds[$f].Split(" ")[2].Split("=")

    if($fold[0] -eq "y")
    {
        $foldy= [int32]::Parse($fold[1])
        for($i= 0; $i -lt $points.Count;$i++)
        {
            $y = $points[$i][1]
            if($y -gt $foldy)
            {
                $points[$i][1] = $foldy - ($y-$foldy)
            }
        }
        $maxy = $foldy
    } 
    elseif($fold[0] -eq "x")
    {
        $foldx= [int32]::Parse($fold[1])
        for($i= 0; $i -lt $points.Count;$i++)
        {
            $x = $points[$i][0]
            if($x -gt $foldx)
            {
                $points[$i][0] = $foldx - ($x-$foldx)
            }
        }
        $maxx = $foldx
    }
    "----------------------------------------------"
    display $points $maxx $maxy 
    "----------------------------------------------"
}


