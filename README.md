# iDRAC Temperature Monitor (PHP)

A lightweight, PHP-based monitoring solution for Dell iDRAC systems. This tool utilizes the Redfish API to fetch real-time temperature data, provides historical logging, and features an automated email alert system for thermal management.

---

## Features

* **Real-time Monitoring:** Fetches temperature data via iDRAC Redfish API.
* **Automated Alerts:** Sends email notifications for status changes (Normal, Warning, Critical).
* **Persistence Tracking:** Detects and alerts if a warning or critical state persists for more than 5 minutes.
* **Logging System:** * **CSV Logs:** High-level status and temperature history.
    * **Storage Logs:** Detailed technical logs including timestamps and IP addresses.
* **Responsive Dashboard:** A dark-mode, mobile-first web interface with live graph updates.
* **Reporting:** Automated hourly status reports and manual report generation.

---

## Technical Architecture



The system operates by sending authenticated CURL requests to the iDRAC endpoint. It processes the JSON response, applies a temperature offset (configured for specific sensor accuracy), and stores the state in a local JSON file to prevent redundant alert firing.

---

## Installation and Setup

### Prerequisites

* PHP 7.4 or higher
* PHP CURL extension enabled
* A Dell server with iDRAC (Enterprise or Express) and Redfish API enabled
* Access to an SMTP server or local mail relay

### Configuration

1.  Create a file named `idrac_config.php` in the root directory.
2.  Define the following configuration parameters:

```php
$CONFIG = [
    'idrac_url'      => 'https://your-idrac-ip',
    'idrac_user'     => 'admin',
    'idrac_pass'     => 'password',
    'warning_temp'   => 35.0,
    'critical_temp'  => 45.0,
    'timezone'       => 'Asia/Manila',
    'email_to'       => 'admin@example.com',
    'email_from'     => 'monitor@example.com',
    'email_from_name'=> 'iDRAC Monitor',
    'transport'      => 'smtp',
    'smtp_host'      => 'your.smtp.relay',
    'smtp_port'      => 25
];
```

---

## Developer Usage

### API Endpoints

The system provides several JSON endpoints via the `action` GET parameter:

* `?action=get_temp`: Triggers a new poll and returns current sensor data.
* `?action=get_graph_data`: Returns filtered historical data for Chart.js integration.
* `?action=test_email`: Validates SMTP configuration.
* `?action=download_logs&type=csv`: Exports the main temperature log.

### CLI and Automation

For continuous monitoring and hourly reports, set up a cron job on your server:

**Hourly Report:**
```bash
0 * * * * /usr/bin/php /path/to/idrac_monitor.php --hourly
```

**High-Frequency Polling (Every 5 minutes):**
```bash
*/5 * * * * /usr/bin/php /path/to/idrac_monitor.php --get_temp
```

---

## Directory Structure

* `idrac_monitor.php`: Main application logic and UI.
* `idrac_config.php`: User-defined settings (not included).
* `idrac_state.json`: Internal state tracker for alerts.
* `idrac_log.csv`: General temperature history.
* `/storage/temperature.log`: Detailed raw logs.
* `/assets/`: UI dependencies (e.g., Chart.js).

---

## User Interface Guide

* **Temperature Panel:** Displays the current Celsius reading and a color-coded status badge.
* **Analytics Graph:** Visualizes temperature trends over time.
* **Manual Controls:** * **Refresh:** Force an immediate sensor update.
    * **Send Report:** Manually trigger a status email to the configured administrator.
    * **Logs:** Access the log viewer to filter data by date range.

## Actual Screenshots
<img width="1338" height="478" alt="live-graph" src="https://github.com/user-attachments/assets/45c9a73d-0f84-448c-a15a-31bdd357ea3f" />
<img width="1072" height="498" alt="live-and-history-logs" src="https://github.com/user-attachments/assets/0b1013c3-b38f-436a-910e-1016aa8e64ec" />
<img width="1066" height="424" alt="history-graph" src="https://github.com/user-attachments/assets/cb438e49-fc10-46d7-a677-38f0d2140729" />

