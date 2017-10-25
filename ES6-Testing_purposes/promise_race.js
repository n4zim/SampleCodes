
const setPromise = (name, action, time) => {
	console.log("=> " + name + " is called");
	setTimeout(action, time, name + " - timeout " + time);
}

// -------------------

var p1 = new Promise((resolve, reject) => setPromise("p1", resolve, 400)); 
var p2 = new Promise((resolve, reject) => setPromise("p2", resolve, 200));

var p3 = new Promise((resolve, reject) => setPromise("p3", resolve, 300));
var p4 = new Promise((resolve, reject) => setPromise("p4", reject,  500));

var p5 = new Promise((resolve, reject) => setPromise("p5", resolve, 350));
var p6 = new Promise((resolve, reject) => setPromise("p6", reject,  150));

// -------------------

const ok = arg => console.log("Resolved promise :", arg);
const nok = arg => console.log("Rejected promise :", arg);
const handle = promise => promise.then(ok).catch(nok);

// -------------------

handle(Promise.race([ p1, p2 ]));
handle(Promise.race([ p3, p4 ]));
handle(Promise.race([ p5, p6 ]));
