export default {
    key: function (src)
    {
        return 'buster:' + btoa(src)
    },
    put: function (src)
    {
        let key = this.key(src)
        let buster = Math.random().toString(36).replace(/[^a-z]+/g, '').substr(0, 5)
        localStorage.setItem(key, buster)
    },
    get: function (src)
    {
        let key = this.key(src)
        return localStorage.getItem(key)
    },
    bust: function (src)
    {
        return src + '?cb=' + this.get(src)

    },
    getImageData: function(imgData)
    {
        let imgSplit = imgData.split(',', 2)
        return imgSplit[1];
    },
    saveProjectLogo: function (imgInfo, imgData, project) {
        let data   = {"image": this.getImageData(imgData), "project_uniq_id": project.uniq_id}
        let routes = Api.getRoutes('webapp-projects');

        return routes.logo.put(data).then((response) => {
            this.put(project.logo)
        }).catch(response => {
        });
    },
    saveClientLogo: function (imgInfo, imgData, client) {
        let data   = {"image": this.getImageData(imgData), "uniq_id": client.uniq_id}
        let routes = Api.getRoutes('webapp-client');

        return routes.logo.put(data).then((response) => {
            this.put(client.logo)
        }).catch(response => {
        });
    },
    saveUserAvatar: function (imgInfo, imgData, user) {
        let data   = {"image": this.getImageData(imgData), "uniq_id": user.uniq_id}
        let routes = Api.getRoutes('webapp-user');

        return routes.avatar.put(data).then((response) => {
            this.put(user.avatar)
        }).catch(response => {
        });
    },

}
