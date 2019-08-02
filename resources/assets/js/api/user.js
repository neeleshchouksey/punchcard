export default {

    auth() {
        // let unparsedData = localStorage.getItem('profile')
        //
        // if (unparsedData == null || unparsedData == 'undefined') {
        //     return false;
        // }
        //
        // let profile = JSON.parse(unparsedData)
        //
        // if (profile == null) {
        //     return false;
        // }
        //
        // return profile.role || profile.role != 'user';

        let profile = this.profile()

        if (typeof profile === 'undefined') {
            return false;
        }

        if (profile == null) {
            return false;
        }

        return profile.role || profile.role != 'user';
    },

    setProfile(data = null)
    {
        if (data !== null) {
            this.profileData = data
            Perm.setRole(this.auth())
        }
    },

    profile()
    {
        // let unparsedData = localStorage.getItem('profile')
        //
        // if (unparsedData == null || unparsedData == 'undefined') {
        //     return false;
        // }
        //
        // let profile = JSON.parse(unparsedData)
        //
        // if (profile == null) {
        //     return false;
        // }
        // return profile;

        return this.profileData;
    },

    logout()
    {
        localStorage.clear();
        return;
    },

    authData() {
        let unparsedData = localStorage.getItem('auth')

        if (unparsedData == null) {
            return false;
        }

        let auth = JSON.parse(unparsedData)

        if (auth == null) {
            return false;
        }

        return auth;
    },

}
