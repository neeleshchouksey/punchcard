let formatHelper = require ('./format.js').default

export default {

    formatDates: (projects) => {
        let ret = [];

        for (let i = 0; i < projects.length; i++) {
            let project = projects[i];
            // These are DATES so we won't convert them or else they show the day before...
            // project.startDateFormatted = formatHelper.date(project.startDate, 'MMMM YYYY');
            // project.endDateFormatted = formatHelper.date(project.endDate, 'MMMM YYYY');
            if (project.startDate) {
                project.startDateFormatted = Moment(project.startDate).format('MMMM YYYY');
            }

            if (project.endDate) {
                project.endDateFormatted = Moment(project.endDate).format('MMMM YYYY');
            }

            ret.push(project);
        }

        return ret;
    }

}
