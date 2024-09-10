local = {
    get: async function (storage, key) {
        return await localGet(storage, key);
    }, set: async function (storage, key, val) {
        await localSet(storage, key, val);
    },
};