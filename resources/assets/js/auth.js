export default {

  // User object will let us check authentication status
  user: {
    authenticated: false
  },

  // login(context, creds, redirect) {
  //   context.$http.post(API_URL + '/user', creds, (data) => {
  //     localStorage.setItem('authen', data.id_token)
  
  //     this.user.authenticated = true
  //     router.push(home)
  
  //   }).error((err) => {
  //     context.error = err
  //   })
  // },
  
  // // To log out, we just need to remove the token
  // logout() {
  //   localStorage.removeItem('authentication')
  //   this.user.authenticated = false
  // },

  // The object to be passed as a header for authenticated requests
  // getAuthHeader() {
  //   return {
  //     'Authorization': 'Bearer ' + localStorage.getItem('authentication')
  //   }
  // },

}
