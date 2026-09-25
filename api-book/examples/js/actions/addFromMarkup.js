// Actions from list markup: li[data-id] is the name, the link text the label.
apex.actions.addFromMarkup(apex.jQuery(`<div><ul>
  <li data-id="orbit-docs" data-shortcut="Alt+D"><a href="https://docs.oracle.com/en/database/oracle/apex/26.1/" target="_blank">APEX Documentation</a></li>
  <li data-id="orbit-orders" data-icon="fa fa-list"><a href="f?p=&amp;APP_ID.:orders">Orders</a></li>
  <li data-id="orbit-hidden" data-hide="true"><span title="Not shown">Hidden Action</span></li>
</ul></div>`));
for (const name of ["orbit-docs", "orbit-orders", "orbit-hidden"]) {
    const { label, shortcut, target, icon, hide } = apex.actions.lookup(name);
    console.log(name, { label, shortcut, target, icon, hide });
}
