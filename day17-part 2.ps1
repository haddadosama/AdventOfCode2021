$minX = 117
$maxX = 164 
$minY = -140
$maxY = -89

cls
$xTotal = 0
$x=0

$minYab = [math]::Abs($minY)
$count=0
for($i=$minY;$i -le $minYab; $i++)
{
    for($j=5;$j -le $maxX; $j++)
    {
     $x= $j
     $y = $i
     $yTotal=0
     $xTotal = 0
     while($xTotal -le $maxX -and $yTotal -ge $minY)
     {
        $yTotal+= $y
        $y--
        $xTotal+= $x
        if($x-gt 0) {$x--}
        if($xTotal -le $maxX -and $xTotal -ge $minX -and $yTotal -ge $minY -and $yTotal -le $maxY)
        {
          $count++
          break
        }
     } 
    }
}

$count