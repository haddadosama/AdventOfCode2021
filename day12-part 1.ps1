$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36"
$session.Cookies.Add((New-Object System.Net.Cookie("_ga", "GA1.2.1254476810.1638562129", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("session", "53616c7465645f5f1bb680ce9385e0655b67e5795087d077f41445b3c5cf431e4b40d28f92f4d70476cdcdff26a4e648", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("_gid", "GA1.2.1837616298.1639365316", "/", ".adventofcode.com")))
$response = Invoke-WebRequest -UseBasicParsing -Uri "https://adventofcode.com/2021/day/12/input" `
-WebSession $session `
-Headers @{
"method"="GET"
  "authority"="adventofcode.com"
  "scheme"="https"
  "path"="/2021/day/12/input"
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
  "referer"="https://adventofcode.com/2021/day/12"
  "accept-encoding"="gzip, deflate, br"
  "accept-language"="en-US,en;q=0.9"
}

$data = $response.content.Split("`n")

cls

$possibilty = New-Object -TypeName "System.Collections.ArrayList"

[void]$possibilty.Add("start")

$notdone = $true




while($notdone)
{
    $notdone=$false
    $removes = New-Object -TypeName "System.Collections.ArrayList"    
    for($i=0;$i -lt $possibilty.Count; $i++)
    {
        $splitline = $possibilty[$i].split("-")

        $last = $splitline[$splitline.count-1]
        if($last -ne "end")
        {
            $data | foreach{
                if($_)
                {
                   $L1 = $_.Split("-")[0]
                   $L2 = $_.Split("-")[1]
                   if($L1 -eq $last)
                   {
                     if($L2 -cmatch “^[A-Z]*$” -or -not $possibilty[$i].Contains($L2))
                     {
                         [void]$possibilty.Add("$($possibilty[$i])-$L2")
                      
                         [void]$removes.Add($i)
                     }
                   }
                   if($L2 -eq $last)
                   {
                     if($L1 -cmatch “^[A-Z]*$” -or -not $possibilty[$i].Contains($L1))
                     {
                         [void]$possibilty.Add("$($possibilty[$i])-$L1")
      
                         [void]$removes.Add($i)
                     }
                     
                   }   
                }
            }
        }
    }

    
}
$final = New-Object -TypeName "System.Collections.ArrayList"

$possibilty | %{
if($_.contains("end"))
    {
    [void]$final.add($_)
    }
}

$final.count