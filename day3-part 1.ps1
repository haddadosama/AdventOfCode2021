$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36"
$session.Cookies.Add((New-Object System.Net.Cookie("_ga", "GA1.2.1254476810.1638562129", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("_gid", "GA1.2.580710830.1638562129", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("ru", "53616c7465645f5f10c5dff6d69ab3356d53b9dfe3d86f274319ef57d4c0c0bd2e9d5b9ec9003af408812408580827b5", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("session", "53616c7465645f5f1bb680ce9385e0655b67e5795087d077f41445b3c5cf431e4b40d28f92f4d70476cdcdff26a4e648", "/", ".adventofcode.com")))
$response = Invoke-WebRequest -UseBasicParsing -Uri "https://adventofcode.com/2021/day/3/input" `
  -WebSession $session `
  -Headers @{
  "method"                    = "GET"
  "authority"                 = "adventofcode.com"
  "scheme"                    = "https"
  "path"                      = "/2021/day/3/input"
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
  "referer"                   = "https://adventofcode.com/2021/day/3"
  "accept-encoding"           = "gzip, deflate, br"
  "accept-language"           = "en-US,en;q=0.9"
}

$data = $response.content.Split("`n")
$zerocount = @(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
$onecount = @(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

$data | foreach {

  For ($f = 0; $f -lt $_.length; $f++) {
    if ($_[$f] -eq "0") {
      $zerocount[$f]++   
    }
    else {
      $onecount[$f]++
    }
  }   

}

$gamma = ""
$epsilon = ""

For ($f = 0; $f -lt 12; $f++) {
  if ($zerocount[$f] -gt $onecount[$f]) {
    $gamma += "0"
    $epsilon += "1"   
  }
  else {
    $gamma += "1"
    $epsilon += "0" 
  }
}   
$gamma = [Convert]::ToInt32($gamma, 2)
$epsilon = [Convert]::ToInt32($epsilon, 2)

$gamma * $epsilon