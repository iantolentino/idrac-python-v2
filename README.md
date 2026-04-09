## iDRAC Temperature Monitor
This utility provides real-time tracking of Dell iDRAC System Inlet temperatures to ensure server room stability. This tool is utilized at **Nanox Philippines Inc.** to manage server health monitoring and inventory logistics. It combines a Python-based hardware monitor with a PHP-based inventory reporting engine.

### Features
* **Automated Discovery:** Crawls Redfish API endpoints to locate temperature sensors across hardware generations.
* **Intelligent Alerting:** Employs a state machine to transition between Normal, Warning, and Critical statuses.
* **Persistence:** Maintains `idrac_state.json` to track alert history and prevent duplicate notifications.
* **Visual Reporting:** Generates 10-minute trend charts attached directly to email alerts.

### Developer Setup
1. **Requirements:** Python 3.8+, `requests`, `flask`, and `matplotlib`.
2. **Configuration:** Define iDRAC credentials and SMTP relay settings in the environment configuration.
3. **Execution:** Use `run_hourly.bat` to schedule automated polling via Windows Task Scheduler.
4. **Dashboard:** Access `idrac.php` for a web-based view of current server health and historical logs.

---

## EMRIS Inventory Management
A robust financial and logistics tool used for auditing stock positions and generating movement reports.

### Inventory Logic
The system reconciles stock using the following formula:
$$Ending\ Stock = (Beginning\ Stock + Received + Other\ In + WIP\ In + Returns) - (Issued + Other\ Out)$$
* **Beginning Stock:** Pulled from the latest non-zero `beg_stock` entry prior to the report period.
* **Ending Cost:** Calculated as $Ending\ Stock \times Unit\ Price$ using the most recent price list entry.

### Components
* **`generate_report.php`**: User interface for selecting year/month and generating CSV exports.
* **`inventory_download_csv.php`**: Backend engine that processes SQL queries and generates standardized CSV files.
* **`inventory_view.php`**: Administrator validation tool with FA Code filtering and stock source tracing.
* **`config.php`**: Database connection handler optimized for performance with a 30-second read timeout.

---

## Deployment Notes
* **Timezone:** All systems are hardcoded to `Asia/Manila` for local business accuracy.
* **Database:** Connects to the `imfsdb` schema via port `3308`.
* **Security:** Ensure `idrac_config.php` and `config.php` are properly secured as they contain infrastructure credentials.

## Actual Screenshots
<img width="1338" height="478" alt="live-graph" src="https://github.com/user-attachments/assets/45c9a73d-0f84-448c-a15a-31bdd357ea3f" />
<img width="1072" height="498" alt="live-and-history-logs" src="https://github.com/user-attachments/assets/0b1013c3-b38f-436a-910e-1016aa8e64ec" />
<img width="1066" height="424" alt="history-graph" src="https://github.com/user-attachments/assets/cb438e49-fc10-46d7-a677-38f0d2140729" />

