export default {

    phone: (phone) => {
        let phoneAll, phoneExtra;

        phone = phone.replace(/[^0-9]/g, '');

        if (phone.length < 10) {
            return phone;
        }

        if (phone.length == 10) {
            phoneAll = phone;
            phoneExtra = '';
        }

        if (phone.length > 10) {
            phoneAll = phone.slice(-10);
            phoneExtra = phone.slice(0, -10);
            phoneExtra += (phoneExtra.length > 0) ? '-' : '';
        }

        return phoneExtra + phoneAll.replace(/(\d{3})(\d{3})(\d{4})/, '($1) $2-$3');
    },

    numberFormat: function (number) {
        return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    },

    round: function(number, places, allowNull = false)
    {
        if (number == undefined && allowNull) {
            return '';
        }

        if (number == undefined && !allowNull) {
            return 0;
        }

        return Number(Math.round(number+'e'+places)+'e-'+places);
    },

    date: function(dateTime, format='YYYY-MM-DD HH:mm:ss+00:00')
    {
        return Moment.utc(dateTime).local().format(format);
    },

    dateToLocal: function(dateTime, format='YYYY-MM-DD HH:mm:ss+00:00')
    {
        return Moment.utc(dateTime).local().format(format);
    },

    dateToUtc: function(dateTime, format='YYYY-MM-DD HH:mm:ss+00:00')
    {
        return Moment(dateTime).utc().format(format);
    },
}
