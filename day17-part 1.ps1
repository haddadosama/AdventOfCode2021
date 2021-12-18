$minX = 117
$maxX = 164 
$minY = -140
$maxY = -89

cls
$xTotal = 0
$x = 0


$y = 87
$good = $true

while ($good) {
    $good = $false
    $maxtem = 0
    $yTotal = 0 
    $tempy = $y + 1
    while ($yTotal -ge $minY) {
        $yTotal += $tempy
        if ($yTotal -gt $maxtem) {
            $maxtem = $yTotal 
        }
        $tempy--
        if ($yTotal -ge $minY -and $yTotal -le $maxY) {
            $good = $true
            $y++
            $max = $maxtem 
        
        }

    }
    
}

$y

$max