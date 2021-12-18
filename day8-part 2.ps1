$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36"
$session.Cookies.Add((New-Object System.Net.Cookie("_ga", "GA1.2.1254476810.1638562129", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("_gid", "GA1.2.580710830.1638562129", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("session", "53616c7465645f5f1bb680ce9385e0655b67e5795087d077f41445b3c5cf431e4b40d28f92f4d70476cdcdff26a4e648", "/", ".adventofcode.com")))
$response = Invoke-WebRequest -UseBasicParsing -Uri "https://adventofcode.com/2021/day/8/input" `
    -WebSession $session `
    -Headers @{
    "method"                    = "GET"
    "authority"                 = "adventofcode.com"
    "scheme"                    = "https"
    "path"                      = "/2021/day/8/input"
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
    "referer"                   = "https://adventofcode.com/2021/day/8"
    "accept-encoding"           = "gzip, deflate, br"
    "accept-language"           = "en-US,en;q=0.9"
}

$data = $response.content.Split("`n")
cls
$sum = 0
$knowndigits = @(2, 4, 3, 7)

$data | foreach {
    $items = $_.split("|")[0]
    $arr = New-Object string[] 10
    if ($items) {
        $digits = $items.split(" ") | sort { $_.length } 
        $arr[8] = ([char[]]$digits[10] | sort ) -join ""
        $arr[7] = ([char[]]$digits[2] | sort ) -join ""
        $arr[4] = ([char[]]$digits[3] | sort ) -join ""
        $arr[1] = ([char[]]$digits[1] | sort ) -join ""
        for ($x = 7; $x -le 9; $x++) {
            if (( $digits[$x] -notmatch $arr[1][0]) -or ($digits[$x] -notmatch $arr[1][1] )) {
                $arr[6] = ([char[]]$digits[$x] | sort ) -join ""
            }
            elseif (( $digits[$x] -match $arr[4][0]) -and ($digits[$x] -match $arr[4][1] ) -and ($digits[$x] -match $arr[4][2] ) -and ($digits[$x] -match $arr[4][3] )) {
                $arr[9] = ([char[]]$digits[$x] | sort ) -join ""
            }
            else {
                $arr[0] = ([char[]]$digits[$x] | sort ) -join ""
            }
        }
        for ($x = 4; $x -le 6; $x++) {
            if (( $digits[$x] -match $arr[1][0]) -and ($digits[$x] -match $arr[1][1] )) {
                $arr[3] = ([char[]]$digits[$x] | sort ) -join ""
            }
            elseif (( $arr[6] -match $digits[$x][0]) -and ($arr[6] -match $digits[$x][1] ) -and ($arr[6] -match $digits[$x][2] ) -and ($arr[6] -match $digits[$x][3] ) -and ($arr[6] -match $digits[$x][4] )) {
                $arr[5] = ([char[]]$digits[$x] | sort ) -join ""
            }
            else {
                $arr[2] = ([char[]]$digits[$x] | sort ) -join ""
            }
        }     
    }


    $RESULTS = $_.split("|")[1]
    if ($RESULTS) {
        $digits = $RESULTS.split(" ")
        $x = 0
        $number = 0
        $digits | foreach {
            if ($_) {
                $digit = ([char[]]$_ | sort ) -join ""
                $number *= 10
                $number += $arr.IndexOf($digit)
               
                $x++
               
            }
        }
        $sum += $number

    }
}

$sum