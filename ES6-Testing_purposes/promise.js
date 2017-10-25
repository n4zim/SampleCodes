
const ok = arg => console.log("Success : ", arg);
const nok = arg => console.log("Error : ", arg);

// -------------------

const promise = success => new Promise((resolve, reject) => {
	if(success) {
		resolve("It's OK");
	} else {
		reject("It's not OK");
	}
});

// -------------------

// Success
promise(true).then(ok).catch(nok);

// Error
promise(false).then(ok).catch(nok);

// -------------------

const handle = promise => promise.then(ok).catch(nok);

// Success
handle(promise(true));

// Error
handle(promise(false));
