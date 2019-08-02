<style lang="sass" scoped>
@import '../../sass/_variables.scss';

</style>
<template>
    <ul class="nav nav-sidebar">
        <sidebar-element
            v-permission="'SideBarProjects'"
            path="/projects"
            title="Projects"
            icon="fa fa-2x fa-folder-open"
            image="images/projects.svg">
        </sidebar-element>
        <sidebar-element
            path="/reports"
            v-permission="'SideBarReports'"
            title="Reports"
            icon="fa fa-2x fa-th-list"
            image="images/reports.svg">
        </sidebar-element>
        <sidebar-element
            path="/client"
            v-permission="'SideBarOrganization'"
            title="Organization"
            icon="fa fa-2x fa-cogs"
            image="images/organization.svg">
        </sidebar-element>
    </ul>
</template>
<script>

</script>
