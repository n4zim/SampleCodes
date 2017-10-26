
function* fibonacci() {
	let x1 = 0;
 	let x2 = 1;
 	while (true) {  
    	let current = x1;
		x1 = x2;
    	x2 = current + x1;
    	let reset = yield current;
    	if(reset) {
        	x1 = 0;
        	x2 = 1;
    	}
	}
}

let iterator = fibonacci();
console.log("Initial iterator :", iterator);

for(var i = 0; i < 10; i++) {
	console.log("Iteration " + i + " :", iterator.next());
}

console.log(iterator.next(null));
