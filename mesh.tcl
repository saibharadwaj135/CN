#Create a simulator object
set ns [new Simulator]

$ns color 1 Red
$ns color 2 Blue
$ns color 3 Green
 
#Open the nam trace file
set nf [open out.nam w] 
$ns namtrace-all $nf

#Define a ‘finish’ procedure
proc finish {} {
	global ns nf
	$ns flush-trace
	#Close the trace file
	close $nf
	#Executenam on the trace file
	exec nam out.nam &
	exit 0
}

#Create four nodes
set n0 [$ns node] 
set n1 [$ns node] 
set n2 [$ns node] 
set n3 [$ns node]

#Create links between the nodes
$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n0 $n3 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n1 $n3 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail


$ns duplex-link-op $n0 $n1 orient right-down
$ns duplex-link-op $n0 $n2 orient left-down
$ns duplex-link-op $n1 $n2 orient right
$ns duplex-link-op $n2 $n3 orient right-up
$ns duplex-link-op $n1 $n3 orient left-up


set udp0 [new Agent/UDP] 
$udp0 set class_ 1
$ns attach-agent $n0 $udp0

set cbr0 [new Application/Traffic/CBR] 
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.01
$cbr0 attach-agent $udp0

set udp1 [new Agent/UDP] 
$udp1 set class_ 2
$ns attach-agent $n1 $udp1

set cbr1 [new Application/Traffic/CBR] 
$cbr1 set packetSize_ 500
$cbr1 set interval_ 0.01
$cbr1 attach-agent $udp1

set udp2 [new Agent/UDP] 
$udp2 set class_ 3
$ns attach-agent $n2 $udp2

set cbr2 [new Application/Traffic/CBR] 
$cbr2 set packetSize_ 500
$cbr2 set interval_ 0.01
$cbr2 attach-agent $udp2

set null0 [new Agent/Null]
$ns attach-agent $n3 $null0

$ns connect $udp0 $null0
$ns connect $udp1 $null0
$ns connect $udp2 $null0

#Schedule events for the CBR agents
$ns at 0.5 "$cbr0 start"
$ns at 1.0 "$cbr1 start"
$ns at 1.5 "$cbr2 start"
$ns at 3.5 "$cbr2 stop"
$ns at 4.0 "$cbr1 stop"
$ns at 4.5 "$cbr0 stop"
$ns at 5.0 "finish"

$ns run
