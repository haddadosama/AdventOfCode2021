$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36"
$session.Cookies.Add((New-Object System.Net.Cookie("_ga", "GA1.2.1254476810.1638562129", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("session", "53616c7465645f5f1bb680ce9385e0655b67e5795087d077f41445b3c5cf431e4b40d28f92f4d70476cdcdff26a4e648", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("_gid", "GA1.2.1837616298.1639365316", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("_gat", "1", "/", ".adventofcode.com")))
$resposne = Invoke-WebRequest -UseBasicParsing -Uri "https://adventofcode.com/2021/day/16/input" `
    -WebSession $session `
    -Headers @{
    "method"                    = "GET"
    "authority"                 = "adventofcode.com"
    "scheme"                    = "https"
    "path"                      = "/2021/day/16/input"
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
    "referer"                   = "https://adventofcode.com/2021/day/16"
    "accept-encoding"           = "gzip, deflate, br"
    "accept-language"           = "en-US,en;q=0.9"
}

$msg = $resposne.content


cls

$Bits = ""

For ($i = 0; $i -lt $msg.Length; $i++) {
    $current = ([Convert]::ToString([convert]::ToInt32($msg[$i], 16), 2))
    $binstring = $current

  
    For ($j = 0; $j -lt 4 - $current.Length ; $j++) {
        $binstring = $binstring.Insert(0, "0")
    }
    $Bits += $binstring
}

cls

$Bits
function readcode([string]$line) {

    $pos = 0
    #$line  >> C:\Experements\log.txt
    $numbers = 3
    $version = [Convert]::ToInt32($line.Substring($pos, $numbers), 2)
    
    $pos += $numbers
    $numbers = 3
    $type = [Convert]::ToInt32($line.Substring($pos, $numbers), 2)
    $pos += $numbers
   
    if ($type -ne 4) {
  
        $numbers = 1
        $opt = [Convert]::ToInt32($line.Substring($pos, $numbers), 2)
        $pos += $numbers
        if ($opt -eq 0) {
            $numbers = 15
            $numberofchars = [Convert]::ToInt32($line.Substring($pos, $numbers), 2)
            $pos += $numbers
            $processed = 0
            $subline = $line.Substring($pos, $line.length - $pos)
       
            while ( $processed -lt $numberofchars) {
                $results = readcode($subline)
                $version += $results.version
                $subline = $results.line
                $pos += $results.length
                $processed += $results.length
            }
            $line = $subline
        }
        else {
            $numbers = 11
            $numberofmsgs = [Convert]::ToInt32($line.Substring($pos, $numbers), 2)
            $pos += $numbers

            $subline = $line.Substring($pos, $line.length - $pos)
            for ($i = 0; $i -lt $numberofmsgs; $i++) {
      
                $results = readcode($subline)
                $version += $results.version
                $subline = $results.line
                $pos += $results.length
            }

            $line = $subline
        }

    }
    else {
        $notdone = $true
        while ($notdone) {
            $numbers = 1
            $opt = [Convert]::ToInt32($line.Substring($pos, $numbers), 2)
            $pos += $numbers
            if ($opt -eq 0) {
                $notdone = $false
            }
            $numbers = 4
            $value = [Convert]::ToInt32($line.Substring($pos, $numbers), 2)
            $pos += $numbers
        }
        $line = $line.Substring($pos, $line.length - $pos)
    }

    return [PSCustomObject]@{
        version = $version
        line    = $line
        length  = $pos + 1
        value   = $value
    }
}



readcode($Bits)


