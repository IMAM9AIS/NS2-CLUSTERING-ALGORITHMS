#reate a simulator object
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


#marking nodes
array set node0 {
        0 2
        1 1
        2 3
        3 4
        4 5
}

array set node1 {
        0 2
        1 3
        2 0
}

array set node2 {
        0 0
        1 1
}

array set node3 {
        0 0
        1 1
}

array set node4 {
        0 0
        1 5
}


array set node5 {
        0 0
        1 4
}
array set cluster {
	0 0
	1 0
	2 0
	3 0
	4 0
	5 0
}
set c0 [array size node0]
set c1 [array size node1]
set c2 [array size node2]
set c3 [array size node3]
set c4 [array size node4]
set c5 [array size node5]

set y 0
set got 0
for { set i 0 } {$i< $c0} {incr i} {
	set to $node0($i)
	if { $to==0 } {
		set got $c0
	}
	if { $to==1 } {
	set got $c1
	}
	if { $to==2 } {
	set got $c2
	}
	if { $to==3 } {
	set got $c3
	}
	if { $to==4} {
	set got $c4
	}
	if { $to==5} {
	set got $c5
	}
	
	if { $got> $c0} {
		incr y
	}
}
if { $y==0 } {
	$n0 color red
	#puts here
	set cluster(0) 1
} else {
	$n0 color blue
}

set y 0
set got 0
for { set i 0 } {$i< $c1} {incr i} {
        set to $node1($i)
        if { $to==0 } {
                set got $c0
        }
        if { $to==1 } {
        set got $c1
        }
        if { $to==2 } {
        set got $c2
        }
        if { $to==3 } {
        set got $c3
        }
        if { $to==4} {
        set got $c4
        }
        if { $to==5} {
        set got $c5
        }

        if { $got> $c1} {
                incr y
        }
}
if { $y==0 } {
        $n1 color red
	set cluster(1) 1
} else {
        $n1 color blue
}
		
set y 0
set got 0
for { set i 0 } {$i< $c2} {incr i} {
        set to $node2($i)
        if { $to==0 } {
                set got $c0
        }
        if { $to==1 } {
        set got $c1
        }
        if { $to==2 } {
        set got $c2
        }
        if { $to==3 } {
        set got $c3
        }
        if { $to==4} {
        set got $c4
        }
        if { $to==5} {
        set got $c5
        }

        if { $got> $c2} {
                incr y
        }
}
if { $y==0 } {
        $n2 color red
	set cluster(2) 1
} else {
        $n2 color blue
}


set y 0
set got 0
for { set i 0 } {$i< $c3} {incr i} {
        set to $node3($i)
        if { $to==0 } {
                set got $c0
        }
        if { $to==1 } {
        set got $c1
        }
        if { $to==2 } {
        set got $c2
        }
        if { $to==3 } {
        set got $c3
        }
        if { $to==4} {
        set got $c4
        }
        if { $to==5} {
        set got $c5
        }

        if { $got> $c3} {
                incr y
        }
}
if { $y==0 } {
	set cluster(3) 1
        $n3 color red
} else {
        $n3 color blue
}


set y 0
set got 0
for { set i 0 } {$i< $c4} {incr i} {
        set to $node4($i)
        if { $to==0 } {
                set got $c0
        }
        if { $to==1 } {
        set got $c1
        }
        if { $to==2 } {
        set got $c2
        }
        if { $to==3 } {
        set got $c3
        }
        if { $to==4} {
        set got $c4
        }
        if { $to==5} {
        set got $c5
        }

        if { $got> $c4} {
                incr y
        }
}
if { $y==0 } {
	set cluster(4) 1

        $n4 color red
} else {
        $n4 color blue
}

set y 0
set got 0
for { set i 0 } {$i< $c5} {incr i} {
        set to $node5($i)
        if { $to==0 } {
                set got $c0
        }
        if { $to==1 } {
        set got $c1
        }
        if { $to==2 } {
        set got $c2
        }
        if { $to==3 } {
        set got $c3
        }
        if { $to==4} {
        set got $c4
        }
        if { $to==5} {
        set got $c5
        }

        if { $got> $c5} {
                incr y
        }
}
if { $y==0 } {
        $n5 color red
	set cluster(5) 1

} else {
        $n5 color blue
}


 	set ar(0,0) 2
        set ar(0,1) 1
        set ar(0,2) 3
        set ar(0,3) 4
        set ar(0,4) 5
        set ar(1,0) 2
        set ar(1,1) 3
        set ar(1,2) 0
        set ar(2,0) 0
        set ar(2,1) 1
        set ar(3,0) 0
        set ar(3,1) 1
        set ar(4,0) 0
        set ar(4,1) 5
        set ar(5,0) 0
        set ar(5,1) 4
set lt [array size cluster]
for { set i 0 } { $i < 6} { incr i } {
	if { $cluster($i) == 0 } {
		puts "at"
		puts $i
		set numclus 0
		set numgre 0
	if { $i==0 } {
                set col 5
        }
        if { $i==1 } {
                set col 3
        }
        if { $i==2 } {
                set col 2
        }
        if { $i==3 } {
                set col 2
        }
        if { $i==4 } {
                set col 2
        }
        if { $i==5 } {
                set col 2
        }
	for { set j 0 }  { $j < $col } {incr j } {
		if { $cluster($ar($i,$j))==1 } {
		incr numclus
	}
	}
	puts "got"
	puts $numclus
	if { $numclus==1 } {
		if { $i==0 } {
		 $n0 color red
		incr cluster(0)
		}
		if { $i==1 } {
		 $n1 color red 
		incr cluster(1)
		}
		if { $i==2 } {
		$n2 color  red
		incr cluster(2)
		}
		if { $i==3 } {
		$n3 color  red
		incr cluster(3)
		}
		if {$i==4 } {
		$n4 color red
		incr cluster(4)
		}
		if {$i==5 } {
			incr cluster(5)	
			$n5 color  red
		}
	}

		
		
}
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
