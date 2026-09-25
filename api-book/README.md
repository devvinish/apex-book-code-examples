# Oracle APEX 26.1 API by Example — Code Examples

The API Lab application and every example of the book **Oracle APEX 26.1 API by Example: JavaScript and PL/SQL Built-ins with Practical Examples** by Vinish Kapoor: a runnable example, with its real output, for every method and event of the Oracle APEX 26.1 JavaScript API and every procedure and function of its PL/SQL packages — 518 files in all.

- 📘 **Book page:** coming soon

The examples run on the Orbit Outfitters sample schema in [`../sql/orbit`](../sql/orbit), the same schema as the first book, *Oracle APEX 26.1: The Complete Guide*.

## Contents

| Folder | Contents |
|---|---|
| `setup` | `api-lab.sql` installs the API Lab, application 200, from `f200.sql` (Chapter 2) |
| `examples/js` | The JavaScript examples of Chapters 3 to 16, one folder per namespace, interface, or widget |
| `examples/js/recipes` | The recipes at the end of Chapters 4 to 16: tasks that combine several APIs |
| `examples/plsql` | The PL/SQL examples of Chapters 17 to 32, one folder per package |

Each example is a `.js` or `.sql` file named after the API it shows, for example `examples/js/item/setValue.js` or `examples/plsql/apex_json/parse-get.sql`. The `.out` file beside it holds the output the example produced when it ran for the book, so you can compare it with yours. Dates, counts, and IDs differ slightly: the sample data is generated relative to the day you install it.

## Setting Up

1. Install the ORBIT sample schema as the [main README](../README.md#installing-the-sample-schema) describes.
2. Connected as the schema owner, run the API Lab script from the `setup` folder:

   ```bash
   cd api-book/setup
   sql orbit@localhost:1521/FREEPDB1 @api-lab.sql
   ```

   Change `APEXBOOK` and `ADMIN` in the script first if your workspace or workspace user has another name.
3. Run the application from App Builder, or open `/ords/r/<workspace>/api-lab/home`, and sign in with your workspace user.

## Running an Example

**JavaScript** — open the page of the API Lab that the first line names, open the browser's developer tools, and paste the code into the console. `// @page orders` means the page with the alias `orders`: `/ords/r/<workspace>/api-lab/orders`. A few examples start on one page and go on after a line `// --- on the next page ---`: run the part below it once the next page has loaded.

**PL/SQL** — run the example as the schema owner in SQL Commands, SQL Developer, or SQLcl. When the first line is `-- @session app=200 page=1`, the example needs an APEX session: create one first, for example

```sql
begin
    apex_session.create_session(p_app_id => 200, p_page_id => 1, p_username => 'ADMIN');
end;
/
```

**Recipes** — the code is split into labeled blocks. A label such as `// === Page › Execute when Page Loads ===` says where the block goes in your application. A block labeled `// === Try it: ... ===` does what a user would do, so the recipe can run in the console by itself.

The examples of web services call the ORBIT schema's REST services at `http://host.docker.internal:8080/ords/orbit/` — the address at which a database running in Docker reaches ORDS on the same computer — and the public test service `https://httpbin.org`. Use the address of your own ORDS where it differs.

The other lines that start with `// @` or `-- @` — `@shot`, `@wait`, `@setup`, `@after` — are instructions for the program that ran the examples for the book, and you can ignore them.

## JavaScript Examples by Chapter

| Chapter | Title | Folders in `examples` |
|---|---|---|
| 3 | The apex Namespace and Global Functions | `js/apex`, `js/global` |
| 4 | Items: apex.item | `js/item`, `js/numberFieldItem`, `js/apex.item` |
| 5 | Regions: apex.region | `js/region`, `js/apex.region` |
| 6 | Region Types: Cards, Facets, Reports, and Maps | `js/templateReportRegion`, `js/interactiveReportRegion`, `js/cardsRegion`, `js/facetsRegion`, `js/mapRegion` |
| 7 | Pages, Navigation, Dialogs, and Themes | `js/apex.page`, `js/apex.navigation`, `js/apex.navigation.dialog`, `js/apex.navigation.popup`, `js/apex.theme` |
| 8 | Messages, Languages, Locales, and Dates | `js/apex.message`, `js/apex.lang`, `js/apex.locale`, `js/apex.date` |
| 9 | Server Calls, Dynamic Actions, Events, and Debugging | `js/apex.server`, `js/apex.da`, `js/apex.event`, `js/apex.debug` |
| 10 | Storage and Progressive Web Apps | `js/apex.storage`, `js/apex.pwa` |
| 11 | Utilities, Templates, and Widgets | `js/apex.util`, `js/apex.util.delayLinger`, `js/apex.widget`, `js/htmlBuilder` |
| 12 | Actions | `js/actions`, `js/apex.actions` |
| 13 | The Data Model: apex.model | `js/apex.model`, `js/model` |
| 14 | The Interactive Grid | `js/interactiveGrid`, `js/interactiveGridView` |
| 15 | Grid, Table Model View, and Record View | `js/grid`, `js/tableModelView`, `js/recordView` |
| 16 | Trees, Menus, and Icon Lists | `js/treeView`, `js/treeNodeAdapter`, `js/menu`, `js/iconList` |

## Recipes

| Chapter | Recipe | File in `examples/js/recipes` |
|---|---|---|
| 4 | Require an Item Only in Some Cases | `item-required-when.js` |
| 4 | Set Cascading Lists from Code | `item-cascading-set.js` |
| 4 | Lock a Form When Its Record Is Closed | `item-lock-form.js` |
| 5 | Refresh a Region on a Timer | `region-auto-refresh.js` |
| 5 | Show a Loading Indicator over a Region | `region-loading.js` |
| 6 | Act on the Selected Rows of an Interactive Report | `ir-approve-selected.js` |
| 6 | Fly a Map to a Feature | `map-show-store.js` |
| 7 | Refresh a Report When Its Dialog Closes | `dialog-refresh-report.js` |
| 7 | Open a Dialog Page from JavaScript | `dialog-open-js.js` |
| 7 | Ask Before Leaving a Page with Unsaved Changes | `page-confirm-leave.js` |
| 8 | Check a Date Range as the User Types | `date-range-check.js` |
| 8 | Default a Date to a Number of Working Days Later | `date-business-days.js` |
| 9 | Look Up a Record as the User Types | `server-lookup-typing.js` |
| 9 | Run Several Calls at Once and Wait for All | `server-parallel.js` |
| 10 | Remember a User's Choice for the Next Visit | `storage-remember-choice.js` |
| 10 | Keep a Draft Until the Form Is Saved | `storage-draft.js` |
| 11 | Show Server Data with a Template | `template-order-card.js` |
| 11 | Draw Simple Bars Without a Chart | `htmlbuilder-bars.js` |
| 12 | Save a Form with Ctrl+S | `actions-save-shortcut.js` |
| 12 | List the Page's Keyboard Shortcuts | `actions-shortcut-help.js` |
| 13 | Validate a Rule Across Two Columns | `model-validate-cells.js` |
| 13 | Make Cells Read-Only in Some Rows | `model-readonly-cells.js` |
| 14 | Get the Selected Rows | `ig-selected-rows.js` |
| 14 | Send the Selected Rows to the Server | `ig-send-selected.js` |
| 14 | Add a Toolbar Button That Works on the Selected Rows | `ig-toolbar-button.js` |
| 14 | Add a Delete Button with a Confirmation | `ig-delete-selected.js` |
| 14 | Add an Entry to the Row Actions Menu | `ig-row-menu.js` |
| 14 | Keep an Order Total Up to Date as the Lines Change | `ig-line-totals.js` |
| 15 | Color Rows by Their Values | `grid-highlight-rows.js` |
| 15 | Show Fewer Columns on a Phone | `grid-narrow-columns.js` |
| 16 | Search a Tree | `tree-search.js` |
| 16 | Keep a Tree's Expanded Nodes Between Visits | `tree-remember-expansion.js` |

## PL/SQL Examples by Chapter

| Chapter | Title | Folders in `examples` |
|---|---|---|
| 17 | Application, Session, and Page Context | `plsql/apex_session`, `plsql/apex_session_state`, `plsql/apex_application`, `plsql/apex_page`, `plsql/apex_region`, `plsql/apex_app_setting`, `plsql/apex_theme` |
| 18 | APEX_UTIL | `plsql/apex_util` |
| 19 | Strings, Escaping, and Markup | `plsql/apex_string`, `plsql/apex_string_util`, `plsql/apex_escape`, `plsql/apex_markdown`, `plsql/apex_javascript`, `plsql/apex_t_javascript_object` |
| 20 | JSON, Parsing, and ZIP Files | `plsql/apex_json`, `plsql/apex_data_parser`, `plsql/apex_zip` |
| 21 | Collections | `plsql/apex_collection` |
| 22 | Data Access and Export: APEX_EXEC | `plsql/apex_exec`, `plsql/apex_data_export`, `plsql/apex_data_loading`, `plsql/apex_rest_source_sync` |
| 23 | Web Services, Credentials, and Tokens | `plsql/apex_web_service`, `plsql/apex_credential`, `plsql/apex_jwt`, `plsql/apex_http` |
| 24 | Authentication, Authorization, and Access Control | `plsql/apex_authentication`, `plsql/apex_authorization`, `plsql/apex_acl`, `plsql/apex_custom_auth` |
| 25 | E-mail, Printing, and Barcodes | `plsql/apex_mail`, `plsql/apex_print`, `plsql/apex_barcode` |
| 26 | Errors, Debugging, and Translation | `plsql/apex_error`, `plsql/apex_debug`, `plsql/apex_lang` |
| 27 | Interactive Reports and Grids | `plsql/apex_ir`, `plsql/apex_ig` |
| 28 | Tasks, Workflows, Automations, and Background Processes | `plsql/apex_human_task`, `plsql/apex_workflow`, `plsql/apex_automation`, `plsql/apex_background_process` |
| 29 | Generative AI, Search, Maps, and PWA | `plsql/apex_ai`, `plsql/apex_search`, `plsql/apex_spatial`, `plsql/apex_pwa` |
| 30 | Plug-ins | `plsql/apex_plugin`, `plsql/apex_plugin_util` |
| 31 | Application Lifecycle: Install, Export, and Dependencies | `plsql/apex_export`, `plsql/apex_application_install`, `plsql/apex_app_object_dependency` |
| 32 | Instance and Workspace Administration | `plsql/apex_instance_admin`, `plsql/apex_instance_debug`, `plsql/apex_application_admin`, `plsql/apex_ui_default_update`, `plsql/apex_db_dictionary`, `plsql/apex_dg_data_gen` |

## Corrections

If you find an error in the book or the code, please open an issue in this repository or write through [vinish.dev](https://vinish.dev).
