$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36"
$session.Cookies.Add((New-Object System.Net.Cookie("_ga", "GA1.2.1254476810.1638562129", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("_gid", "GA1.2.580710830.1638562129", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("ru", "53616c7465645f5f10c5dff6d69ab3356d53b9dfe3d86f274319ef57d4c0c0bd2e9d5b9ec9003af408812408580827b5", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("session", "53616c7465645f5f1bb680ce9385e0655b67e5795087d077f41445b3c5cf431e4b40d28f92f4d70476cdcdff26a4e648", "/", ".adventofcode.com")))
$response = Invoke-WebRequest -UseBasicParsing -Uri "https://adventofcode.com/2021/day/5/input" `
-WebSession $session `
-Headers @{
"method"="GET"
  "authority"="adventofcode.com"
  "scheme"="https"
  "path"="/2021/day/5/input"
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
  "referer"="https://adventofcode.com/2021/day/5"
  "accept-encoding"="gzip, deflate, br"
  "accept-language"="en-US,en;q=0.9"
}

$data = $response.Content.Replace(" ","").split("`n")

$matrix = New-Object 'int32[,]' 1000,1000

$data | foreach{
    if($_)
    {
     $sets = $_.split("->")

     $set1 = [int32[]]$sets[0].split(",")
    
     $set2 = [int32[]]$sets[2].split(",")

     if($set1[0] -eq $set2[0] )
     {
        if($set1[1] -gt $set2[1])
        {
            while($set1[1] -ge $set2[1])
            {
                $matrix[$set1[0],$set1[1]]++
                $set1[1]--
            }
        }else{
             while($set1[1] -le $set2[1])
            {
                $matrix[$set1[0],$set1[1]]++
                $set1[1]++
            }
        }
     }elseif ($set1[1] -eq $set2[1] )
     {
        if($set1[0] -gt $set2[0])
        {
            while($set1[0] -ge $set2[0])
            {
                $matrix[$set1[0],$set1[1]]++
                $set1[0]--
            }
        }else{
             while($set1[0] -le $set2[0])
            {
                $matrix[$set1[0],$set1[1]]++
                $set1[0]++
            }
        }
     }else{
        while($set1[0] -ne $set2[0] -or $set1[1] -ne $set2[1])
        {
            $matrix[$set1[0],$set1[1]]++
            if($set1[0] -lt $set2[0])
            {
                $set1[0]++
            }else
            {
                $set1[0]--
            }
            if($set1[1] -lt $set2[1])
            {
                $set1[1]++
            }else
            {
                $set1[1]--
            }
        }
            $matrix[$set1[0],$set1[1]]++
        }
     
    }
}
$count = 0
 For ($f=0; $f -lt 1000; $f++)
 {
     For ($s=0; $s -lt 1000; $s++)
     {
        if($matrix[$f,$s] -gt 1)
        {
            $count++
        }
     }
 }

 $count

