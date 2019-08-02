export default function(caller, endpoint, key, refresh = false) {
    return new Promise((resolve, reject) => {
        let data = null; //caller.retrieve(key);

        if (refresh || data === null) {
            caller.fetch(endpoint).then((data) => {
                //caller.store(key, data);
                resolve(data);
            }).catch((data) => {
                reject(data);
            });
        } else {
            resolve(data);
        }
    });
}
