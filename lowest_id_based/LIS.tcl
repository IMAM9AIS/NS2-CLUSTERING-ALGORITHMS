#Create a simulator object
set ns [new Simulator]

#Define different colors for data flows (for NAM)
$ns color 1 Blue
$ns color 2 Red

#Open the NAM trace file
set nf [open out.nam w]
$ns namtrace-all $nf

#Define a 'finish' procedure
proc finish {} {
        global ns nf
        $ns flush-trace
        #Close the NAM trace file
        close $nf
        #Execute NAM on the trace file
        exec nam out.nam &
        exit 0
}

#Create four nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]


#Create links between the nodes
$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n0 $n3 2Mb 10ms DropTail
$ns duplex-link $n0 $n1 1.7Mb 20ms DropTail
$ns duplex-link $n0 $n4 1.7Mb 20ms DropTail
$ns duplex-link $n0 $n5 1.7Mb 20ms DropTail
$ns duplex-link $n2 $n1 1.7Mb 20ms DropTail
$ns duplex-link $n3 $n1 1.7Mb 20ms DropTail
$ns duplex-link $n4 $n5 1.7Mb 20ms DropTail


#making arrays of the connection
array set type {
	0 0
	1 0
	2 0
	3 0
	4 0
	5 0
}
array set node0 {
	0 2
	1 1
	2 3
	3 4
	4 5
}
set count1 0
set count2 0
set n [array size node0]

for {set i 0 } { $i < $n } {incr i} {
	if { $node0($i) > 0 } {
		incr count1
	} else {
	incr count2
	}
}

if { $count1==$n || $count2==1 } {
	$n0 color red 
	incr $type(0)
} else {
	$n0 color blue
}

array set node1 {
	0 2
	1 3
	2 0
}
set count1 0
set count2 0
set n [array size node1]
for {set i 0 } { $i < $n } {incr i} {
	if { $node1($i) > 1 } {
		incr count1
	} else  {
	incr count2
	}
}

if { $count1==$n || $count2==1} {
	$n1 color red
	incr $type(1)
} else  {
	$n1 color blue
}


array set node2 {
        0 0
        1 1
}
set count1 0
set count2 0
set n [array size node2]
for {set i 0 } { $i < $n } {incr i} {
        if { $node2($i) > 2 } {
                incr count1
        } else  {
        incr count2
        }
}

if { $count1==$n || $count2==1} {
        $n2 color red
        incr $type(2)
} else  {
	$n2 color blue
}

array set node3 {
        0 0
        1 1
}
set count1 0
set count2 0
set n [array size node3]
for {set i 0 } { $i < $n } {incr i} {
        if { $node3($i) > 3 } {
                incr count1
        } else  {
        incr count2
        }
}

if { $count1==$n || $count2==1} {
        $n3 color red
        incr $type(3)
} else  {
        $n3 color blue
}

array set node4 {
        0 0
        1 5
}
set count1 0
set count2 0
set n [array size node4]
for {set i 0 } { $i < $n } {incr i} {
        if { $node4($i) > 4 } {
                incr count1
        } else  {
        incr count2
        }
}

if { $count1==$n || $count2==1} {
        $n4 color red
        incr $type(4)
} else  {
        $n4 color blue
}

array set node5 {
        0 0
        1 4
}
set count1 0
set count2 0
set n [array size node5]
for {set i 0 } { $i < $n } {incr i} {
        if { $node4($i) > 5 } {
                incr count1
        } else  {
        incr count2
        }
}

if { $count1==$n || $count2==1} {
        $n5 color red
        incr $type(5)
} else  {
        $n5 color blue
}




#Give node position (for NAM)
$ns duplex-link-op $n0 $n2 orient right-up
$ns duplex-link-op $n0 $n3 orient right-down
$ns duplex-link-op $n0 $n1 orient right
$ns duplex-link-op $n4 $n0 orient right-down
$ns duplex-link-op $n5 $n0 orient right-up
$ns duplex-link-op $n2 $n1 orient right-down
$ns duplex-link-op $n3 $n1 orient right-up
$ns duplex-link-op $n5 $n4 orient up





#Setup a TCP connection
set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink
$ns connect $tcp $sink
$tcp set fid_ 1

#Setup a FTP over TCP connection
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP


#Setup a UDP connection
set udp [new Agent/UDP]
$ns attach-agent $n1 $udp
set null [new Agent/Null]
$ns attach-agent $n3 $null
$ns connect $udp $null
$udp set fid_ 2

#Setup a CBR over UDP connection
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set type_ CBR
$cbr set packet_size_ 1000
$cbr set rate_ 1mb
$cbr set random_ false


#Schedule events for the CBR and FTP agents
$ns at 0.1 "$cbr start"
$ns at 1.0 "$ftp start"
$ns at 4.0 "$ftp stop"
$ns at 4.5 "$cbr stop"

#Detach tcp and sink agents (not really necessary)
$ns at 4.5 "$ns detach-agent $n0 $tcp ; $ns detach-agent $n3 $sink"

#Call the finish procedure after 5 seconds of simulation time
$ns at 5.0 "finish"

#Print CBR packet size and interval
puts "CBR packet size = [$cbr set packet_size_]"
puts "CBR interval = [$cbr set interval_]"

#Run the simulation
$ns run


