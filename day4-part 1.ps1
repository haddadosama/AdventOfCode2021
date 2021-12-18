$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36"
$session.Cookies.Add((New-Object System.Net.Cookie("_ga", "GA1.2.1254476810.1638562129", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("_gid", "GA1.2.580710830.1638562129", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("ru", "53616c7465645f5f10c5dff6d69ab3356d53b9dfe3d86f274319ef57d4c0c0bd2e9d5b9ec9003af408812408580827b5", "/", ".adventofcode.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("session", "53616c7465645f5f1bb680ce9385e0655b67e5795087d077f41445b3c5cf431e4b40d28f92f4d70476cdcdff26a4e648", "/", ".adventofcode.com")))
$response = Invoke-WebRequest -UseBasicParsing -Uri "https://adventofcode.com/2021/day/4/input" `
-WebSession $session `
-Headers @{
"method"="GET"
  "authority"="adventofcode.com"
  "scheme"="https"
  "path"="/2021/day/4/input"
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
  "referer"="https://adventofcode.com/2021/day/4"
  "accept-encoding"="gzip, deflate, br"
  "accept-language"="en-US,en;q=0.9"
}
$trials = [System.Int32[]]$response.Content.Split("`n")[0].split(",")
$bingocards = $response.Content -split "`n"
$x = 0
$y = 0
$data = @()

For ($i=2; $i -lt $bingocards.Length; $i++) {
        if($bingocards[$i] -eq "")
        {

            $x++

            $y = 0
        }else
        {
            $bingocards[$i].split(" ") | foreach {
                if($_ -ne "")
                {
                    $myObject = [PSCustomObject]@{
                        number     = [System.Int32]$_
                        selected =  $false
                        line = $y
                        group = $x

                    }
                    $data += $myObject
                }
            }

            $y++
        }

    }


$bingocount = 0
$bingo = $false
$bingobingo = $false
$bingogroup = -1
$winningnum =-1


 For ($i=0; $i -lt $trials.Length; $i++) {
     For ($j=0; $j -lt $data.Length; $j++) {
        if($trials[$i] -eq $data[$j].number)
        {
            $data[$j].selected = $true


        }

     }
     
     $subcount = 0
     $subcolumncount = @(0,0,0,0,0)
     $culmncounts = 0
     $subnotcount = 0

            For ($x=0; $x -lt $data.Length; $x++) {
                
                 
                if($data[$x].selected)
                {
                    $subcount++
                    $subcolumncount[$subnotcount]++
                    if($subcount -eq 5)
                    {
                        $bingogroup = $data[$x].group
                        $winningnum = $data[$x].number
                        $bingocount++
 
                        
                        if($bingocount -eq 100)
                        {
                           $bingobingo = $true
                           $bingogroup = $data[$x].group
                           $winningnum = $trials[$i]
                           break
                        } else {
                    
                                For ($f=0; $f -lt $data.Length; $f++)
                                {
                                    if($data[$f].group -eq $bingogroup)
                                    {
                                        $data[$f].number = -1 
                                        $data[$f].selected = $false
                                    }
                                }
                            For ($y=0; $y -lt 5; $y++)
                            {
                                $subcolumncount[$y] = 0
                            } 

                        } 
                        if($bingogroup -eq 40)
                        {
                            $data
                            $trials[$i] 
                        }
                    }
                    
                }
                $subnotcount++  
                $culmncounts++
                if($subnotcount -eq 5)
                {
                    $subnotcount = 0
                    $subcount = 0
                }

                if($culmncounts -eq 25)
                {

                        For ($y=0; $y -lt 5; $y++)
                        {
                         
                            if($subcolumncount[$y] -eq 5)
                            {
                                 $bingo = $true
                                 $bingogroup = $data[$x].group
                                 $winningnum = $trials[$i]
                                                             For ($y=0; $y -lt 5; $y++)
                            {
                                $subcolumncount[$y] = 0
                            } 
                                 break
                            }
                            $subcolumncount[$y] = 0

                        }
                        $culmncounts =0
                        if($bingo)
                        {
                            $bingocount++
                            if($bingocount -eq 100)
                            {
                               $bingobingo = $true
                               $bingogroup = $data[$x].group
                               $winningnum = $trials[$i]
                               break
                            } else {
                    
                                    For ($f=0; $f -lt $data.Length; $f++)
                                    {
                                        if($data[$f].group -eq $bingogroup)
                                        {
                                            $data[$f].number = -1 
                                            $data[$f].selected = $false
                                        }
                                    }
                            }
                           
                        }
                    }
                     $bingo = $false
                
            }
            if($bingobingo)
            {
                break
            }
 }

$sum = 0
For ($x=0; $x -lt $data.Length; $x++) {
    if($data[$x].group -eq $bingogroup -and $data[$x].selected -eq $false)
    {
        $sum += $data[$x].number
    }
                
}

  
$winningnum *  $sum 