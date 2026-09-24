# Oracle APEX 26.1: The Complete Guide — Code Examples

The scripts, data files, and code examples of the book **Oracle APEX 26.1: The Complete Guide** by Vinish Kapoor.

<a href="https://vinish.dev/oracle-apex-26-1-book-the-complete-guide"><img src="https://vinish.dev/wp-content/uploads/2026/09/apex-book-cover.webp" alt="Cover of Oracle APEX 26.1: The Complete Guide by Vinish Kapoor" width="220" align="right"></a>

## Get the Book

- 📘 **About the book, sample pages, and contents:** [vinish.dev/oracle-apex-26-1-book-the-complete-guide](https://vinish.dev/oracle-apex-26-1-book-the-complete-guide)
- 📖 **Paperback** on Amazon: [amazon.com/dp/B0HKWGLMXD](https://www.amazon.com/dp/B0HKWGLMXD)
- 📱 **Kindle edition** on Amazon: [amazon.com/dp/B0HKW571TW](https://www.amazon.com/dp/B0HKW571TW)

828 pages, 48 chapters, from installation to production: pages and reports, forms and grids, security, workflows, REST services with ORDS, and generative AI.

<br clear="right">

Throughout the book you build **Orbit Sales**, an order management application for the fictional outdoor-gear retailer Orbit Outfitters. This repository contains everything you need to follow along.

Download it with **Code ▸ Download ZIP**, or clone it:

```bash
git clone https://github.com/devvinish/apex-book-code-examples.git
```

## Contents

| Folder | Contents |
|---|---|
| `sql/orbit` | The Orbit Outfitters sample schema (Chapter 12) |
| `sql/orbit/parts` | The sample data split into six scripts for SQL Workshop ▸ SQL Scripts |
| `sql/orbit/data` | `orbit-stores.csv` (Chapter 11) and the product images |
| `sql/orbit/quicksql` | The data model in Quick SQL shorthand |
| `sql/examples` | The code examples of the chapters, named `chNN-description` by chapter |
| `sql/examples/static` | `orbit.js` and `orbit.css`, the static application files of Chapter 32 |
| `sql/examples/translations` | The German translation file of Chapter 41 |
| `sql/examples/data` | `price-update.csv`, the data load file of Chapter 40 |
| `apex/f100.sql` | An export of the finished Orbit Sales application |

## Installing the Sample Schema

Requirements: Oracle APEX 26.1 on Oracle AI Database 26ai (the schema uses the `BOOLEAN` data type and a JSON relational duality view). Chapters 2 to 8 of the book describe the installation.

1. Create a schema, for example `ORBIT`, and a workspace that uses it (Chapter 9).
2. As `SYS`, grant the schema the package that the password checking of Chapter 35 needs:

   ```sql
   grant execute on sys.dbms_crypto to orbit;
   ```

3. Install the schema with SQLcl, connected as the schema owner:

   ```bash
   cd sql/orbit
   sql orbit@localhost:1521/FREEPDB1 @install.sql
   ```

   Without SQLcl, upload and run the scripts in **SQL Workshop ▸ SQL Scripts** instead: `01_tables.sql`, `02_logic.sql`, `parts/03_data_part01.sql` to `parts/03_data_part06.sql` in order, then `06_auth.sql` and `07_duality.sql`.

`04_stores.sql` creates the `ORB_STORES` table for readers who skipped the Data Workshop exercise of Chapter 11, and `05_product_images.sql` optionally loads the product images. `uninstall.sql` removes every `ORB_` object.

The sample data is generated relative to the current date, so the orders always span the two years up to the day you install it. Your numbers therefore differ slightly from the book's screenshots.

## Importing the Finished Application

`apex/f100.sql` is the Orbit Sales application as it stands at the end of the book. After installing the schema:

1. In **App Builder**, click **Import**, choose `apex/f100.sql`, and click **Next**.
2. Choose the schema of the sample data as the **Parsing Schema**, choose **Auto Assign New Application ID** if application 100 already exists in your instance, and click **Install Application**.
3. Sign in with a user of your workspace. The application uses **Oracle APEX Accounts**.

Some features need configuration that an application export cannot carry:

- **Generative AI** (Chapter 44) needs an AI service in **Workspace Utilities ▸ Generative AI**. Select it in the application's **Shared Components ▸ AI Attributes**.
- **E-mail** (Chapter 43) needs an SMTP server configured by the instance administrator.
- **Automations** are disabled after an import; enable them in **Shared Components ▸ Automations**.
- **Maps, REST data sources, and AI services** need network access for the APEX engine (Chapters 3 and 48).
- **Approvals and workflows** (Chapter 42) use the **Approver** role; assign it in **Shared Components ▸ Application Access Control**.
- The REST services of Chapter 45 are defined in ORDS, not in the application; run `sql/examples/ch45-rest-sales-module.sql` and `sql/examples/ch45-autorest-client.sql` to create them.

## Code Examples

Each file in `sql/examples` belongs to the chapter in its name, for example `ch31-get-customer-info.sql` for the Ajax callback of Chapter 31 or `ch44-order-lookup.sql` for the AI tool of Chapter 44. The chapters show where each one goes.

## Corrections

If you find an error in the book or the code, please open an issue in this repository or write through [vinish.dev](https://vinish.dev). Corrections are listed here and fixed in later printings.
