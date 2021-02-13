#!/bin/bash

# Note: Mininet must be run as root.  So invoke this shell script
# using sudo.

# Solve a problem where cgroups does not start automatically
service cgroup-lite restart 2>&1 > /dev/null

time=10
bwnet=1.5
bwhost=1000
# TODO: If you want the RTT to be 20ms what should the delay on each
# link be?  Set this value correctly.
delay=5

iperf_port=5001

maxq=100
dir=out

# TODO: Add more parameters if needed
qsize=20

# TODO: Run bufferbloat.py here...
python bufferbloat.py -b $bwnet --delay $delay --dir $dir --maxq $qsize --time $time

# TODO: Ensure the input file names match the ones you use in
# bufferbloat.py script.  Also ensure the plot file names match
# the required naming convention when submitting your tarball.
python plot_tcpprobe.py --sport -f $dir/cwnd.txt -o $dir/cwnd-iperf.png -p $iperf_port
python plot_queue.py -f $dir/q.txt -o $dir/q.png
python plot_ping.py -f $dir/ping.txt -o $dir/rtt.png

# TODO: Repeat the same thing above, i.e. run bufferbloat, plots, etc,
# but with PIE turning on. You can pass a switching parameter to your code.
# Put the result in folder dir=n1-pie

# TODO: Similarly, repeat the same thing, but with PIE turning on, 
# AND iperf 10 flows. Put the result in folder dir=n10-pie

# The final code should be just one run.sh script and generates 
# all desired files automatically
