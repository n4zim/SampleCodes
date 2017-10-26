
let array = [];

const values = "abcdefghijklmopqrstuvwxyz";

for(let i = 0; i < values.length; i++) {
	array.push(values[Math.floor(Math.random() * values.length)]);
}

console.log("Array :", JSON.stringify(array));

// -------------------

function* gen() { yield* array; }

let generation = gen();

console.log("Initial gen() :", gen());

for(let i = 0; i < values.length + 1; i++) {
	console.log(generation.next());
}
