// @page stores
const ids = apex.model.list();
ids.forEach((id) => apex.model.get(id).clearData(false));
await apex.model.multipleFetch(null, null, ids);           // one request for all of them
console.log(ids.map((id) => `${id}: ${apex.model.get(id).getTotalRecords(true)} records`));
apex.model.setMaxCachedModels(20);
console.log("max cached:", apex.model.getMaxCachedModels());
