---
title: Installing PostgreSQL on Windows
difficulty: Beginner
estimated_time: 20 Minutes
prerequisites:
  - What is SQL
  - What is PostgreSQL
---

# Installing PostgreSQL on Windows

## Overview

Before writing SQL queries, we need to install PostgreSQL on our computer.

In this guide, you'll learn how to:

- Download PostgreSQL
- Install PostgreSQL Server
- Install pgAdmin
- Set the PostgreSQL password
- Verify the installation
- Connect to the database
- Create your first database

By the end of this guide, you'll have a fully functional PostgreSQL environment.

---

# System Requirements

| Component | Minimum Requirement |
|------------|--------------------|
| Operating System | Windows 10 or Windows 11 |
| RAM | 4 GB (8 GB Recommended) |
| Storage | 1 GB Free Space |
| Processor | Dual Core or Better |

---

# Step 1: Download PostgreSQL

Visit the official PostgreSQL website.

https://www.postgresql.org/download/windows/

Click

> Download the installer

You'll be redirected to the EnterpriseDB installer page.

Download the latest stable version.

---

# Why Use EnterpriseDB Installer?

The EnterpriseDB installer includes:

- PostgreSQL Server
- pgAdmin
- Stack Builder
- Command Line Tools

This makes installation much easier for beginners.

---

# Step 2: Run the Installer

Double-click the downloaded installer.

You'll see the setup wizard.

Click:

Next

---

# Step 3: Installation Directory

Default location:

```text
C:\Program Files\PostgreSQL\17\
```

You can keep the default location.

Click:

Next

---

# Step 4: Select Components

Select all components.

✅ PostgreSQL Server

✅ pgAdmin 4

✅ Command Line Tools

✅ Stack Builder

For beginners, installing every component is recommended.

---

# Step 5: Data Directory

This folder stores your databases.

Example:

```text
C:\Program Files\PostgreSQL\17\data
```

Leave the default location.

---

# Step 6: Set Password

Choose a strong password for the default PostgreSQL superuser (`postgres`).

Example:

```text
Username:
postgres

Password:
********
```

⚠️ **Important:** Remember this password. You'll need it whenever you connect to PostgreSQL.

---

# Step 7: Port Number

Default port:

```text
5432
```

Unless another application is already using this port, keep the default.

---

# Step 8: Locale

Leave the default locale unless you have a specific requirement.

Click:

Next

---

# Step 9: Review Settings

The installer will display a summary of your selections.

Review them and click:

Next

---

# Step 10: Install

Click:

Install

The installation may take several minutes.

Once completed, click:

Finish

---

# What Gets Installed?

| Component | Purpose |
|------------|----------|
| PostgreSQL Server | Stores and manages databases |
| pgAdmin | Graphical interface for PostgreSQL |
| psql | Command-line interface |
| Stack Builder | Optional additional tools |

---

# Verify Installation

Open the Windows Start Menu.

Search for:

```text
pgAdmin 4
```

If pgAdmin opens successfully, the installation is complete.

---

# Opening pgAdmin

Launch pgAdmin.

On first launch, you'll be asked to create a **Master Password**.

### What is the Master Password?

The Master Password protects your saved server connections inside pgAdmin.

It is **not** the same as the PostgreSQL `postgres` user password.

You can choose any secure password.

---

# Connect to PostgreSQL Server

Expand:

```text
Servers
```

Double-click your PostgreSQL server.

Enter the password you created during installation for the `postgres` user.

If the connection succeeds, you'll see:

```text
Servers
└── PostgreSQL 17
    ├── Databases
    ├── Login Roles
    └── Tablespaces
```

---

# Using psql

Open:

```text
SQL Shell (psql)
```

You'll be prompted for several values.

Press **Enter** to accept the defaults until you reach the password prompt.

Example:

```text
Server [localhost]:
Database [postgres]:
Port [5432]:
Username [postgres]:
Password:
```

Enter your password.

If successful, you'll see:

```text
postgres=#
```

This indicates you're connected and ready to execute SQL commands.

---

# Your First SQL Command

In `psql`, run:

```sql
SELECT version();
```

Example output:

```text
PostgreSQL 17.x on x86_64-pc-windows-msvc
```

This confirms PostgreSQL is installed correctly.

---

# Your First Database

Create a database:

```sql
CREATE DATABASE company_db;
```

List databases:

```sql
\l
```

Connect to your new database:

```sql
\c company_db
```

You are now connected to your own database.

---

# Common Installation Problems

## Incorrect Password

If you forget the `postgres` password, you'll need to reset it or reinstall PostgreSQL.

---

## Port Already in Use

If port **5432** is occupied, choose another available port during installation.

---

## pgAdmin Won't Open

Restart your computer and try again.

If the issue persists, reinstall pgAdmin.

---

## Unable to Connect

Verify:

- PostgreSQL service is running.
- Correct password is used.
- Correct port is configured.

---

# Best Practices

- Keep PostgreSQL updated.
- Remember the `postgres` password.
- Use the default port unless necessary.
- Create separate databases for different projects.
- Back up important databases regularly.

---

# Key Takeaways

- PostgreSQL is installed using the EnterpriseDB installer on Windows.
- The installer includes PostgreSQL Server, pgAdmin, and `psql`.
- The default PostgreSQL port is **5432**.
- `pgAdmin` is the graphical interface.
- `psql` is the command-line interface.
- `SELECT version();` verifies your installation.
- `CREATE DATABASE` creates a new database.

---

# Practice Exercises

1. Install PostgreSQL.
2. Open pgAdmin.
3. Connect to the server.
4. Open `psql`.
5. Execute `SELECT version();`.
6. Create a database named `company_db`.
7. Connect to `company_db`.

---

# Next Topic

➡️ Creating Your First Database Objects

In the next chapter, you'll learn how to:

- Create schemas
- Create tables
- Insert data
- View data

This is where we begin writing SQL using a realistic company database.
