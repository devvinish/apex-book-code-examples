# Oracle APEX 26.1 API by Example — the API Lab

The **API Lab** is the Oracle APEX application in which every example of the book **Oracle APEX 26.1 API by Example: JavaScript and PL/SQL Built-ins with Practical Examples** by Vinish Kapoor runs. Install it to try the examples and recipes of the book in your own workspace.

- 📘 **Paperback** on Amazon: [amazon.com/dp/B0HL1R8HLP](https://www.amazon.com/dp/B0HL1R8HLP)
- 📱 **Kindle edition** on Amazon: [amazon.com/dp/B0HKZXR17R](https://www.amazon.com/dp/B0HKZXR17R)

The examples themselves — more than 1,850 JavaScript and PL/SQL APIs, each with an example and its real output, and 32 recipes — are in the book.

## Contents

| File | Contents |
|---|---|
| `setup/api-lab.sql` | Installs the API Lab as application 200 (Chapter 2 of the book) |
| `setup/f200.sql` | The export of the API Lab application |

The API Lab is the Orbit Sales application of the first book, *Oracle APEX 26.1: The Complete Guide*, with a few additions for the examples: HTML DOM IDs on its main regions, row selection in a report, and the Ajax callbacks that the examples call. It runs on the Orbit Outfitters sample schema in [`../sql/orbit`](../sql/orbit).

## Setting Up

1. Install the ORBIT sample schema as the [main README](../README.md#installing-the-sample-schema) describes.
2. Connected as the schema owner, run the API Lab script from the `setup` folder:

   ```bash
   cd api-book/setup
   sql orbit@localhost:1521/FREEPDB1 @api-lab.sql
   ```

   Change `APEXBOOK` and `ADMIN` in the script first if your workspace or workspace user has another name.
3. Run the application from App Builder, or open `/ords/r/<workspace>/api-lab/home`, and sign in with your workspace user.

## Corrections

If you find an error in the book or the lab, please open an issue in this repository or write through [vinish.dev](https://vinish.dev).
