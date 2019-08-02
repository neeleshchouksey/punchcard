import store from './stores/index';

export default {
    setRole: function (role)
    {
        this.role = role
    },

    has: function (where)
    {
        if (typeof this[where] === 'undefined') {
            return false
        }

        return this[where]()
    },

    isA: function(level)
    {
        return level == this.role
    },

    isAtLeast: function(level)
    {
        let atLeast = this.getRoles()

        if (typeof atLeast.at_least[level] === 'undefined') {
            return false
        }

        let accessLevels = atLeast.at_least[level]

        return accessLevels.indexOf(this.role) > -1
    },

    getRoles: function()
    {
        return {
            'all': [
                'user',
                'superuser',
                'admin',
                'clientadmin',
                'superadmin'
            ],

            'at_least': {
                'user': [
                    'user', 'superuser', 'admin', 'clientadmin', 'superadmin'
                ],
                'superuser': [
                    'superuser', 'admin', 'clientadmin', 'superadmin'
                ],
                'admin': [
                    'admin', 'superadmin', 'clientadmin'
                ],
                'clientadmin': [
                    'superadmin', 'clientadmin'
                ],
                'superadmin': [
                    'superadmin'
                ],
            },
        }
    },

    ProjectsView: function ()
    {
        return this.isAtLeast('superuser') && this.role != 'superadmin';
    },

    ProfileAlter: function ()
    {
        return this.isAtLeast('superuser') && this.role != 'superadmin';
    },

    DataImport: function ()
    {
        return this.isAtLeast('admin');
    },

    DataImportClients: function ()
    {
        return this.isAtLeast('clientadmin');
    },

    DataImportUsers: function ()
    {
        return this.isAtLeast('admin');
    },

    DataImportProjects: function ()
    {
        return this.isAtLeast('admin');
    },

    DataImportChecks: function ()
    {
        return this.isAtLeast('admin');
    },
    //
    // Encompasses add, delete, edit
    // 6.2.2, 7.2.2, 8.2.2
    //
    ProjectsAlter: function ()
    {
        return this.role == 'clientadmin'
    },

    Impersonate: function ()
    {
        return this.role == 'superadmin'
    },

    ProjectsUsers: function ()
    {
        return this.role == 'clientadmin' || this.role == 'admin'
    },

    //
    // 6.2.4, 7.2.4, 8.2.4
    //
    OrganizationChildCompanies: function()
    {
        return this.role == 'clientadmin';
    },

    OrganizationParentCompanies: function()
    {
        return this.role == 'superadmin';
    },

    OrganizationOwnContactInfo: function()
    {
        return this.role == 'clientadmin' || this.role == 'admin';
    },

    OrganizationOwnEmployees: function()
    {
        return this.role == 'clientadmin' || this.role == 'admin';
    },

    OrganizationImportData: function()
    {
        return this.role == 'clientadmin' || this.role == 'admin';
    },

    ClientSubdomain: function()
    {
        return this.isAtLeast('superadmin');
    },

    ParentAdd: function()
    {
        return this.isAtLeast('superadmin');
    },

    ClientAdd: function()
    {
        return this.isAtLeast('clientadmin');
    },

    SideBarOrganization: function()
    {
        return this.isAtLeast('admin');
    },

    SideBarProjects: function()
    {
        return this.isAtLeast('superuser') && this.role != 'superadmin'
    },

    SideBarReports: function()
    {
        return this.isAtLeast('superuser')
    },

    showClientStatusField: function ()
    {
        return this.role == 'clientadmin' || this.role == 'superadmin'
    },

    ShowReportsBulkExport: function ()
    {
        return this.isAtLeast('admin');
    },
}
