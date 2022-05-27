# TrafficGenerator
This is a collection of scripts and systemd services that facilitate simulated traffic flows leveraging IPERF3

In short, iperf3 listener services are started on the following TCP ports (21,23,80,143,443,1433,3306,3389, and 8080).
A client service (client_traffic_generator) can be turned on/off to generate periodic 1K file transfers randomly to a server in the configured list.

By default, 5 threads are created every 30 minutes - each transferring 1K of data. 

This is not a replacement for more robust solutions like T-REX, but does cause randomly generated traffic to flow.
## Installation
Installation can be done by simply installing the RPM package from the RPMs folder. Both binary and source RPMs are GPG signed. The RPMs only distribute the systemd and bash scripts, you may need to also install iperf3.

#Install pre-requisites
yum install iperf3

#Download and install RPM.
wget https://github.com/mgillespie-aviatrix/TrafficGenerator/raw/main/RPMs/trafficgenerator-0.0.1-1.amzn2.noarch.rpm
sudo rpm -i trafficgenerator-0.0.1-1.amzn2.noarch.rpm 

#Add the list of servers you're installing the traffic generator/receiver on, 1 per line with no comments or whitespace and save the file.
sudo vim /usr/local/etc/client_traffic_generator.servers

#Lastly, start the client service to generate traffic
sudo systemctl start client_traffic_generator

