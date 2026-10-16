# Mirai Botnet and the 2016 Dyn DDoS Attack: An IoT-Based DDoS Case Study

Cyber Security, Continuous Assessment II (Case Study), Group G-8
Department of E&TC, Symbiosis Institute of Technology, Pune. B.Tech 2023-27, Semester VII
Submitted to: Dr. Mangal Singh

| Name | PRN |
|---|---|
| Saaj Mulik | 23070123109 |
| Shloka Patel | 23070123120 |
| Shrey Raj | 23070123123 |
| Swayam Patel | 23070123165 |

GitHub: https://github.com/<your-username>/mirai-case-study   <-- replace with your repo link

## What this project is

An analytical case study of the Mirai botnet and the 21 October 2016 Dyn DNS attack. It maps five course topics
(digital forensics, darknet/dark web, malware analysis, intrusion detection, security tools) onto a 7-stage attack
lifecycle, and validates the reconnaissance, detection and forensic stages in a small, isolated virtual lab.

**No Mirai code, malware or attack tool is built, run or distributed.** There are no executables in this package;
everything is a shell script or a text rules file. The static-analysis demo uses the benign binary `/bin/ls`.

## Contents

```
README.md
report/CBS_Case_Study_CA2_Group8_Updated.pdf   full report
scripts/lab_audit.sh                           Nmap port check, /24 sweep, Telnet login check (Sec 4.5)
scripts/capture.sh                             tcpdump capture to ~/lab_capture.pcap (Sec 4.9)
scripts/forensics_workflow.sh                  hash, filter tcp.port==23, TCP conversations (Sec 4.9)
scripts/static_analysis_demo.sh                file / sha256sum / strings / readelf on /bin/ls (Sec 4.7)
scripts/run_snort.sh                           run Snort with the teaching rules (Sec 4.8)
snort/local.rules                              the two teaching rules (Telnet SYN flood, DNS rate)
evidence/                                      put your screenshots / pcap here (Figures 1-7)
```

## Requirements

- VirtualBox (or VMware Workstation)
- Kali Linux VM (Nmap, tcpdump, Wireshark/tshark, Snort 2, binutils)
- Metasploitable 2 VM (the stand-in "IoT device" with Telnet enabled)
- A **host-only** network, `192.168.56.0/24`, with no internet access and no bridged/NAT adapter

## How to run

1. **Build the lab.** In VirtualBox create a host-only network and attach both VMs to it (Adapter 1: Host-only,
   Promiscuous Mode: Deny). In the report Kali was 192.168.56.102 and Metasploitable 2 was 192.168.56.103.
   Check with `ip a` and `ping -c 3 192.168.56.103`.
2. **Copy this folder to the Kali VM**, then `chmod +x scripts/*.sh`.
3. **Start a capture** (terminal 1): `./scripts/capture.sh eth0`
4. **Run the audit** (terminal 2): `./scripts/lab_audit.sh 192.168.56.103`
   The script refuses any target outside 192.168.56.0/24.
   Expected: 23/tcp open and 2323/tcp closed on .103; port 23 open on .103 only in the /24 sweep.
   Then run `telnet 192.168.56.103` and log in with `msfadmin` / `msfadmin` (Figure 7).
5. **Stop the capture** (Ctrl+C), then: `./scripts/forensics_workflow.sh ~/lab_capture.pcap`
   Expected: a SHA-256 hash, the filtered Telnet packets, and the TCP conversations to port 23 (Figure 6).
   Your hash and counts will differ from the report's because your capture differs.
6. **Static-analysis demo:** `./scripts/static_analysis_demo.sh /bin/ls`
7. **Snort (optional):** `./scripts/run_snort.sh eth0`, then repeat the /24 sweep from another terminal.
   In our run **no alert was recorded** (Sections 4.8 and 5.5), so the rules are documented as detection logic,
   not a confirmed detector. Rule syntax also differs between Snort 2 and Snort 3.

## Safety and ethics

Run everything only on your own isolated VMs. Do not point these scripts at any network you do not own.
Google dorks were run only against the institute's own domain, and no dark-web sites were accessed.

## Limitations

Based on public sources; peak attack sizes are reported estimates. The lab uses a stand-in device, Snort ran on the
same host as the scanner and raised no alert, and no malware was executed.
