# Azure SQL Terraform Deployment

This guide walks you through deploying an Azure SQL Database using Terraform, executing a schema SQL script, configuring for free-tier usage, and running a complete local React + SQLite app with offline sync.

---

## 📦 What This Does

- Creates a Resource Group
- Deploys Azure SQL Server (Basic SKU)
- Deploys a SQL Database
- Configures firewall to allow all IPs
- Runs a SQL script (`azure_sql_schema.sql`) to create tables + dummy data
- Initializes a ReactJS frontend for advisor login and CRUD operations
- Creates a local SQLite DB matching Azure SQL schema
- Syncs data between local and cloud

---

## 🛠️ Prerequisites

Install the following tools:

### 1. Terraform
- https://developer.hashicorp.com/terraform/downloads

### 2. Azure CLI
- https://learn.microsoft.com/en-us/cli/azure/install-azure-cli

### 3. `sqlcmd` Utility
| OS      | Install Command                                                                  |
| ------- | -------------------------------------------------------------------------------- |
| macOS   | `brew install msodbcsql mssql-tools`                                             |
| Ubuntu  | `sudo apt install mssql-tools unixodbc-dev`                                      |
| Windows | [Download](https://learn.microsoft.com/en-us/sql/tools/sqlcmd-utility) installer |

### 4. Node.js & npm
- https://nodejs.org

### 5. SQLite CLI
- https://www.sqlite.org/download.html

---

## 🔐 Azure Authentication

To authenticate using the Azure CLI:

```bash
az login
az account set --subscription "Free Trial"
```

You can list your available subscriptions with:
```bash
az account list --output table
```

---

## 📁 Setup Instructions

### 1. Clone or Create Directory

Place the following files:
- `main.tf` (Terraform script)
- `azure_sql_schema.sql` (SQL table creation script for Azure SQL)
- `sqlite_schema.sql` (SQL script for local SQLite)
- `frontend/` (ReactJS app)

### 2. Optional: Create `terraform.tfvars`
```hcl
sql_password = "YourStrongPassword123!"
client_ip    = "0.0.0.0"
```

---

## 🚀 Run Terraform
```bash
terraform init
terraform apply
```

When prompted, type `yes` to proceed.

---

## 🧠 Local SQLite Setup

Run the following to initialize your local DB:
```bash
sqlite3 local.db < sqlite_schema.sql
```

Run your sync script (included in `frontend/src/utils/sync.js`) to push/pull with Azure.

---

## 💻 Run React Frontend

```bash
cd frontend
npm install
npm start
```

Features:
- Advisor Login
- Dashboard with tabs for Contacts, Leads, Orders, Activities
- Offline support using local SQLite
- Manual or automatic sync with Azure SQL

---

## 📂 Project Structure
```
project/
├── main.tf
├── terraform.tfvars
├── azure_sql_schema.sql
├── sqlite_schema.sql
├── local.db
├── frontend/
│   ├── public/
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   ├── utils/sync.js
│   │   ├── App.js
│   │   ├── index.js
│   ├── package.json
```

---

## ✅ After Deployment

- Go to Azure Portal → Resource Group → SQL Database
- Use output `connection_string` to connect from your app
- Ensure `local.db` is up to date via sync

---

## ⚠️ Notes

- **Free-tier limit:** Azure Basic SQL DB allows up to 2GB.
- **Firewall:** By default, allows all IPs. Update in production for security.
- **SQLite Script:** Creates local tables with the same schema.
- **Sync:** Script available in `frontend/src/utils/sync.js`

---

## 📬 Support

Need help? Reach out with logs and error details.

---

## Windows SQLCMD Installation (Detailed Instructions)

### ✅ Windows Installation
1. **Install ODBC Driver**  
👉 https://learn.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server

2. **Install sqlcmd Utility**  
👉 https://learn.microsoft.com/en-us/sql/tools/sqlcmd-utility

   - Download `.msi` from **ENU/x64/** or **ENU/x86/** folders

3. **Add to PATH**  
`C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\<version>\Tools\Binn\`

4. **Test**
```bash
sqlcmd -?
```