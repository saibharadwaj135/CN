set ns [new Simulator]

$ns color 1 Blue
$ns color 2 Red
$ns color 3 Green
$ns color 4 Black
$ns color 5 #ff00e9

set nf [open out.nam w]
$ns namtrace-all $nf

proc finish {} {
	global ns nf
	$ns flush-trace
	close $nf
	exec nam out.nam &
	exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail
$ns duplex-link $n3 $n4 1Mb 10ms DropTail
$ns duplex-link $n4 $n5 1Mb 10ms DropTail
$ns duplex-link $n5 $n0 1Mb 10ms DropTail


$ns duplex-link-op $n0 $n1 orient right-up
$ns duplex-link-op $n1 $n2 orient right
$ns duplex-link-op $n2 $n3 orient right-down
$ns duplex-link-op $n3 $n4 orient left-down
$ns duplex-link-op $n4 $n5 orient left
$ns duplex-link-op $n5 $n0 orient left-up

$ns duplex-link-op $n0 $n1 queuePos 0.5

set udp0 [new Agent/UDP]
$udp0 set class_ 1
$ns attach-agent $n0 $udp0

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetsize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

set udp1 [new Agent/UDP]
$udp1 set class_ 2
$ns attach-agent $n1 $udp1

set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetsize_ 500
$cbr1 set interval_ 0.005
$cbr1 attach-agent $udp1

set udp2 [new Agent/UDP]
$udp2 set class_ 3
$ns attach-agent $n2 $udp2

set cbr2 [new Application/Traffic/CBR]
$cbr2 set packetsize_ 500
$cbr2 set interval_ 0.005
$cbr2 attach-agent $udp2

set udp3 [new Agent/UDP]
$udp3 set class_ 4
$ns attach-agent $n3 $udp3

set cbr3 [new Application/Traffic/CBR]
$cbr3 set packetsize_ 500
$cbr3 set interval_ 0.005
$cbr3 attach-agent $udp3

set udp4 [new Agent/UDP]
$udp4 set class_ 5
$ns attach-agent $n4 $udp4

set cbr4 [new Application/Traffic/CBR]
$cbr4 set packetsize_ 500
$cbr4 set interval_ 0.005
$cbr4 attach-agent $udp4

set null0 [new Agent/Null]
$ns attach-agent $n5 $null0

$ns connect $udp0 $null0
$ns connect $udp1 $null0
$ns connect $udp2 $null0
$ns connect $udp3 $null0
$ns connect $udp4 $null0

$ns at 0.0 "$cbr0 start"
$ns at 0.5 "$cbr1 start"
$ns at 1.0 "$cbr2 start"
$ns at 1.5 "$cbr3 start"
$ns at 2.0 "$cbr4 start"
$ns at 3.5 "$cbr4 stop"
$ns at 4.0 "$cbr3 stop"
$ns at 4.5 "$cbr2 stop"
$ns at 5.0 "$cbr1 stop"
$ns at 5.5 "$cbr0 stop"


$ns at 6.0 "finish"

$ns run
