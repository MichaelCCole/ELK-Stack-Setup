## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

Diagrams/ELK-Stack-Network-Diagram.png

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook file may be used to install only certain pieces of it, such as Filebeat.

Ansible/install-elk.yml

This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly reliable, in addition to restricting access to the network.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the logs and system processes.

The configuration details of each machine may be found below.

| Name         | Function               | IP Address | Operating System |
|--------------|------------------------|------------|------------------|
| Jump Box     | Gateway                | 10.1.0.4   | Linux            |
| Web Server 1 | Server                 | 10.1.0.5   | Linux            |
| Web Server 2 | Server                 | 10.1.0.6   | Linux            |
| ELK Stack    | Logging and Monitoring | 10.0.0.4   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from my current personal IP address which I update within my Azure Network Security Group.

Machines within the network can only be accessed by the Jump Box machine or by my personal IP address.

A summary of the access policies in place can be found in the table below.

| Name         | Publicly Accessible | Allowed IP Addresses |
|--------------|---------------------|----------------------|
| Jump Box     | No                  | My personal IP       |
| Web Server 1 | No                  | My personal IP       |
| Web Server 2 | No                  | My personal IP       |
| ELK Stack    | No                  | My personal IP       |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it ensures the exact same steps are performed on all machines.

The playbook implements the following tasks:
- Sets the max memory to be high enough for the ELK stack
- Installs Docker and pip
- Installs the ELK Docker Container
- Ensures the container will always start after a restart

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

Ansible/docker-ps-ELK.png

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- 10.1.0.5
- 10.1.0.6

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat: collects and aggregates system logs and events from the watched machines.
- Metricbeat: collects data related to the system metrics such as CPU and RAM usage from the watched machines.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the configuration file to /etc/ansible.
- Update the hosts file to include the private IP address of your ELK VM
- Run the playbook, and navigate to Kibana to check that the installation worked as expected.