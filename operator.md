## Google Cloud SQL for MySQL

Google Cloud SQL for MySQL is a fully-managed database service that simplifies the setup, maintenance, management, and administration of MySQL relational databases on Google Cloud Platform (GCP).

### Design Decisions

1. **Managed Resource Handling**:
   - Use of the `google_sql_database_instance` for creating and configuring Cloud SQL instances.
   - Separate modules for creating CPU, Disk, and Memory utilization alarms to ensure high availability and optimal resource usage.

2. **Maintenance and Backup**:
   - Configurable maintenance windows to ensure updates do not interfere with peak usage times.
   - Enabled automated backups with binary logging for point-in-time recovery.

3. **User Authentication**:
   - Automatic generation and storage of root user credentials using the `massdriver_artifact` resource to facilitate secure database access.

4. **Networking**:
   - IP configuration to allow only private network connections, ensuring secure access within the VPC.

### Runbook

#### Unable to Connect to MySQL Instance

If you cannot connect to your MySQL instance, the following steps can help diagnose and resolve networking or authentication issues.

1. **Verify Instance Status**

Check if the instance is running.

```sh
gcloud sql instances describe [INSTANCE_NAME]
```
Replace `[INSTANCE_NAME]` with your actual instance name. Ensure `state` is `RUNNABLE`.

2. **Check Instance Connectivity**

Ensure your local machine or VM has the necessary network access.

```sh
gcloud sql connect [INSTANCE_NAME] --user=root
```
If connectivity is blocked, verify VPC settings and private network configurations.

#### High CPU Utilization

If experiencing high CPU utilization, you might need to identify resource-intensive queries.

1. **Identify Problematic Queries**

Log into your MySQL instance and run the following SQL command:

```sql
SHOW FULL PROCESSLIST;
```

This will list all running queries and their statuses.

2. **Query Insights**

If query insights are enabled, you can review them in the Google Cloud Console for detailed diagnostics.

#### High Memory Utilization

If memory utilization is high, it's important to check for large dataset operations or inefficiencies.

1. **Identify Memory-Intensive Queries**

Run:

```sql
SHOW STATUS LIKE 'Handler%';
```

Look for high values in `Handler_read_rnd` and `Handler_read_rnd_next`.

2. **Database Configuration**

Check and adjust the database configuration parameters like `innodb_buffer_pool_size`.

```sql
SHOW VARIABLES LIKE 'innodb_buffer_pool_size';
```
You can adjust this parameter in your MySQL configuration file if needed.

#### Backup Failures

If automatic backups are failing, it is essential to diagnose the error from the Google Cloud Console and log files.

1. **Check Backup Configuration**

Ensure backup configuration is set properly.

```sh
gcloud sql instances describe [INSTANCE_NAME] --format='default(settings.backupConfiguration)'
``` 

Verify `enabled` is set to `true`.

2. **Check Logs for Errors**

Review the Cloud SQL instance logs for any errors related to backups.

```sh
gcloud sql operations list --instance=[INSTANCE_NAME]
```

3. **Manual Backup**

Try initiating a manual backup to check and debug the issue.

```sh
gcloud sql backups create --instance=[INSTANCE_NAME]
```

By executing the above steps, you can effectively manage and troubleshoot your Google Cloud SQL for MySQL instances.

