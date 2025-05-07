# CS564 Capstone Project - CheckIn App (Firewallers)

This repository contains the final submission for the COMPSCI 564 Capstone Project, developed by the Firewallers group. The project simulates a covert internal check-in system that appears benign on the surface, but silently triggers a command to a simulated Sliver-C2 server. The goal is to demonstrate how internal-facing web apps can be abused for stealthy command-and-control operations.

---

## Project Overview

CheckIn is a JSP-based web application that mimics an employee check-in tool. It displays a calendar and email input field. When a user submits their information, a hidden background request is made to trigger a Sliver-C2 implant. The frontend is intentionally designed to look harmless while acting as a covert access point for attackers.

---

## Repository Contents

firewallers_capstone_project/  
├── index.jsp - Main page with embedded implant trigger  
├── submit.jsp - Backend form handler (email submission)  
├── firewallers_capstone-presentation.pptx - Final presentation slides  
├── WEB-INF/  
│   └── web.xml - Application-level deployment descriptor  
├── etc/  
│   └── tomcat9/  
│       ├── web.xml - Global Tomcat configuration for servlet behavior  
│       └── context.xml - Session persistence and context settings  

---

## index.jsp - Covert Frontend Logic

The index.jsp file serves as the main page users interact with. It includes:

- A branded greeting for Firewallers Inc.
- A calendar and email entry field
- A "Check In" button

When the button is clicked, a JavaScript script silently sends a POST request to the attacker's server (e.g., http://attacker-ip:8000), triggering beacon behavior. This interaction **activetes the Sliver-C2 server**, as if an implant were deployed and actively communicating.

---

## context.xml - Persistent Session Configuration

Located at `/etc/tomcat9/context.xml`, this file ensures session data is saved persistently across server restarts. It is configured as follows:

```xml
<Manager className="org.apache.catalina.session.PersistentManager">
  <Store className="org.apache.catalina.session.FileStore"
         directory="/var/lib/tomcat9/work/session" />
</Manager>
```

This setup can be crucial for preserving attacker footholds in real-world persistence scenarios.

## tomcat web.xml - Exploit Support Configuration

In `etc/tomcat9/web.xml`, the following parameter is added and set:

```xml
<param-name>readonly</param-name>
<param-value>false</param-value>
```
This enables file write operations via HTTP PUT, which is typically blocked or even not inclueded in secure environments. Disabling this protection is necessary to simulate exploits like CVE-2025-24813 that rely on file upload vectors.

## How to Run the Simulation

1. Place the `checkpin` app folder under `/var/lib/tomcat9/webapps/`.
2. Restart Tomcat:  
   `sudo systemctl restart tomcat9`
3. Start the Sliver-C2 listener on port 8080
5. Once the user clicks "Check In", a background beacon is sent and printed to the terminal of the listener.

---

## Presentation

The repository includes the presentation slides: `firewallers_capstone-presentation.pptx`, which detail:

- Scenario
- Threat model
- Exploit methodology
- Implant behavior

---

## Disclaimer

This capstone project was created strictly for academic and educational purposes as part of the COMPSCI 564 - Cyber Effects course at the University of Massachusetts Amherst.  
Do not replicate or use this outside of a controlled, authorized environment.

---

Group: Firewallers  
Course: COMPSCI 564 - Cyber Effects  
Semester: Spring 2025
