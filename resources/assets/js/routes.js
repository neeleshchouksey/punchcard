require('./bootstrap');

import VueRouter from 'vue-router';
Vue.use(VueRouter)


//
// Global components, non-page-ish
//
Vue.component('loader', require('./components/Loader.vue'))
Vue.component('sidebar', require('./pages/Sidebar.vue'));
Vue.component('sidebar-element', require('./components/SidebarElement.vue'));
Vue.component('app-alert', require('./components/AppAlert.vue'));

//
// Global page-ish components
//
import Home from './pages/Home.vue';
import Sidebar from './pages/Sidebar.vue';
import Settings from './pages/Settings.vue';
//import Help from './pages/Help.vue';
import Logout from './pages/Logout.vue';
import Problem from './pages/Problem.vue';
import Profile from './pages/Profile.vue';

import Organization from './pages/Organization.vue';
import ClientMain from './pages/Clients/Client.vue';
import ClientNew from './pages/Clients/ClientNew.vue';
import ClientChildren from './pages/Clients/Children.vue';
import ClientEmployees from './pages/Clients/Employees.vue';
import ClientsUserAdd from './pages/Clients/UserAdd.vue';

import ChildMain from './pages/Clients/Child/Child.vue';
import ChildSummary from './pages/Clients/Child/Summary.vue';
import ChildEmployees from './pages/Clients/Child/Employees.vue';
import ChildsUserAdd from './pages/Clients/Child/UserAdd.vue';
import ChildProjects from './pages/Clients/Child/Projects.vue';

import ParentsMain from './pages/Clients/Parents/Main.vue';
import ParentsNew from './pages/Clients/Parents/New.vue';

import DataImportMain from './pages/DataImport/Main.vue';


import Users from './pages/Users/Users.vue';
import UserMain from './pages/Users/User.vue';
import UserDetails from './pages/Users/Details.vue';
import UserProjects from './pages/Users/Projects.vue';
import UserBadges from './pages/Users/Badges.vue';
import UserTimesheets from './pages/Users/Timesheets.vue';
import UserReports from './pages/Users/Reports.vue';
import UserDelete from './pages/Users/Delete.vue';
import UserPasswordReset from './pages/Users/PasswordReset.vue';

import Projects from './pages/Projects.vue';
import Project from './pages/Project.vue';
import ProjectSummary from './pages/ProjectSummary.vue';
import ProjectUsers from './pages/ProjectUsers.vue';
import ProjectClients from './pages/Projects/Clients.vue';
import ProjectEmployeesOnsite from './pages/Projects/employeesOnsite.vue';
import ProjectCompanyOnsite from './pages/Projects/companyOnsite.vue';
import ProjectVirtualGate from './pages/ProjectVirtualGate.vue';
import ProjectEdit from './pages/ProjectEdit.vue';
import ProjectAdd from './pages/Projects/Add.vue';
import ProjectAddUser from './pages/Projects/AddUser.vue';
import ProjectAddClient from './pages/Projects/AddClient.vue';

import Reports from './pages/Reports/Reports.vue';
import Report from './pages/Reports/Report.vue';

import PaymentWarning from './pages/Payment/PaymentWarning.vue';
import Payment from './pages/Payment/Payment.vue';
import UpdatePlan from './pages/Payment/updateplan.vue';
import PaymentUser from './pages/Payment/Payment-user.vue';
import Checkout from './pages/Payment/checkout.vue';
import UpdateCardDetails from './pages/Payment/update-card/update-card.vue';
import TransactionHistory from './pages/Payment/transaction-history.vue';
import ManageAdminUser from './pages/manageuser/manageuser.vue';
import ManageAdminUserEmployees from './pages/manageuser/manageuseremployees.vue';
import ManageAdminUserAdd from './pages/manageuser/manageuseradd.vue';
import ManageAdminUserDetails from './pages/manageuser/manageuserdetails.vue';
import ManageAdminDetails from './pages/manageuser/Details.vue';

export const router = new VueRouter({
    routes: [
        { path: '/', component: Home, name: 'home',  meta: { publicAccess: true }},
        { path: '/logout', component: Logout, name: 'logout', meta: { publicAccess: true}},
        //{ path: '/help', component: Help, name: 'help', meta: { publicAccess: true}},

        // needed?
        { path: '/problem/:problem', component: Problem, meta: { publicAccess: true}},
        { path: '/settings', component: Settings, name: 'settings', meta: { publicAccess: true}},

        { path: '/profile',name:'profile', component: Profile },

        { path: '/users', component: Users },
        { path: '/user/:user_id', component: UserMain,
          children: [
            {
              path: 'details',
              name: 'user-details',
              component: UserDetails
            },
            {
              path: 'projects',
              name: 'user-projects',
              component: UserProjects
            },
            {
              path: 'badges',
              name: 'user-badges',
              component: UserBadges
            },
            {
              path: 'timesheets',
              name: 'user-timesheets',
              component: UserTimesheets
            },
            {
              path: 'reports',
              name: 'user-reports',
              component: UserReports
            },
            {
              path: 'delete',
              name: 'user-delete',
              component: UserDelete
            },
            {
              path: 'password-reset',
              name: 'user-password-reset',
              component: UserPasswordReset
            }
          ]
        },

        { path: '/projects', name: 'projects', component: Projects },
        { path: '/project/:project_id/edit', name: 'project-edit', component: ProjectEdit },
        { path: '/project-new', name: 'project-new', component: ProjectAdd},
        { path: '/projectEmployeesOnsite/:projectId/:clientId', name: 'employees-on-site', component: ProjectEmployeesOnsite},
        { path: '/projectCompanyOnsite/:projectId', name: 'company-on-site', component: ProjectCompanyOnsite},
        { path: '/project/:project_id', component: Project,
          children: [
            {
              path: 'summary',
              name: 'project-summary',
              component: ProjectSummary
            },
            {
              path: 'users',
              name: 'project-users',
              component: ProjectUsers
            },
            {
              path: 'virtual-gate',
              name: 'project-virtual-gate',
              component: ProjectVirtualGate
            },
            {
              path: 'clients',
              name: 'project-clients',
              component: ProjectClients
            },
            {
              path: 'add-client',
              name: 'project-add-client',
              component: ProjectAddClient
            },
            {
              path: 'add-user',
              name: 'project-add-user',
              component: ProjectAddUser
            },
          ],
        },
        { path: '/paymentwarning', name: 'PaymentWarning', component: PaymentWarning},
        { path: '/payment', name: 'payment', component: Payment},
        { path: '/updateplan/:currentplan', name: 'updateplan', component: UpdatePlan},
        { path: '/paymentrequired', name: 'paymentrequired', component: PaymentUser},
        { path: '/checkout/:plan', name: 'checkout', component: Checkout},
        { path: '/updatecarddetails', name: 'updatecard', component: UpdateCardDetails},
        { path: '/transaction-history', name: 'transaction-history', component: TransactionHistory},
        { path: '/reports', name: 'reports', component: Reports},
        { path: '/report/:uniq_id', name: 'reports-main', component: Report},
        { path: '/client/', name: 'organization', component: Organization},
        { path: '/client/:uniq_id?', name: 'client-main', component: ClientMain},
        { path: '/client/:uniq_id?/children', name: 'client-children', component: ClientChildren},
        { path: '/client/:uniq_id?/employees', name: 'client-employees', component: ClientEmployees},
        { path: '/client-new/:uniq_id?', name: 'client-new', component: ClientNew},
        { path: '/client/:uniq_id?/user-add', name: 'client-user-add', component: ClientsUserAdd},

        { path: '/child/:uniq_id', component: ChildMain,
          children: [
            { path: 'summary', name: 'child-summary', component: ChildSummary},
            { path: 'child-projects', name: 'child-projects', component: ChildProjects},
            { path: 'employees', name: 'child-employees', component: ChildEmployees},
            { path: 'user-add', name: 'child-user-add', component: ChildsUserAdd}
          ],
        },

        { path: '/parents', name: 'parents-main', component: ParentsMain},
        { path: '/parents-new', name: 'parents-new', component: ParentsNew},

        { path: '/data-import/:uniq_id?', name: 'data-import', component: DataImportMain},
        { path: '/manage-admin-user/:uniq_id', name: 'manage-admin-user', component: ManageAdminUser,
          children: [
            { path: 'manageuser-employees', name: 'manageuser-employees', component: ManageAdminUserEmployees},
            { path: 'manage-admin-user-add', name: 'manage-admin-user-add', component: ManageAdminUserAdd}
          ]
        },
        { path: '/manage-admin-userdetails/:user_id', component: ManageAdminUserDetails,
          children: [
            {
              path: 'details',
              name: 'admin-user-details',
              component: ManageAdminDetails
            },
            {
              path: 'delete',
              name: 'admin-user-delete',
              component: UserDelete
            },
            {
              path: 'password-reset',
              name: 'admin-password-reset',
              component: UserPasswordReset
            }
          ]
        },
        //
        // Default if no routes are matched
        //
        { path: '*', component: Projects}
    ],

    mode: DevConfig.mode,
    scrollBehavior (to, from, savedPosition) {
        if (savedPosition) {
            return savedPosition
        } else {
            return { x: 0, y: 0 }
        }

    }
})
