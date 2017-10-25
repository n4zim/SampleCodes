
var p1ok = new Promise((resolve, reject) => { setTimeout(resolve, 200, 'OK 1'); }); 
var p2ok = new Promise((resolve, reject) => { setTimeout(resolve, 400, 'OK 2'); });
var p3ok = new Promise((resolve, reject) => { setTimeout(resolve, 600, 'OK 3'); });

Promise.all([ p1ok, p2ok, p3ok ]).then(values => { 
  console.log(values);
}).catch(reason => {
  console.log(reason);
});

// -------------------

var p1nok = new Promise((resolve, reject) => { setTimeout(resolve, 200, 'NOK 1'); }); 
var p2nok = new Promise((resolve, reject) => { setTimeout(resolve, 400, 'NOK 2'); });
var p3nok = new Promise((resolve, reject) => { reject('NOK 3 (rejected)'); });

Promise.all([ p1nok, p2nok, p3nok ]).then(values => { 
  console.log(values);
}).catch(reason => {
  console.log(reason);
});
