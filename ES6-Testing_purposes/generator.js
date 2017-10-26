
function* id() {
  let index = 0;
  while(true) yield index++;
}

ids = id();
console.log("Initial ids :", ids);

console.log(ids.next()); // 0
console.log(ids.next()); // 1
console.log(ids.next()); // 2
console.log(ids.next()); // 3
