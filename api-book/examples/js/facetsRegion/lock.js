// @page products
const search = apex.region("product_search");
const locked = () => search.widget().hasClass("is-disabled");
search.lock();
console.log("locked:  ", locked());
search.lock();                                            // locks are counted
search.unlock();
console.log("unlock 1:", locked());
search.unlock();
console.log("unlock 2:", locked());
