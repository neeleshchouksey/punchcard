export default {

    setTarget: function(event)  {
        this.target  = event.target
        return this
    },

    removePlus: function()  {
        $(this.target).removeClass('pointer fa-plus-circle')
        return this
    },

    removeTimes: function()  {
        $(this.target).removeClass('pointer fa-times')
        return this
    },

    addTimes: function()  {
        $(this.target).addClass('pointer fa-times')
        return this
    },

    replaceWithNonSpin: function() {
        $(this.target).html(this.saved);
        return this;
    },

    replaceWithSpin: function(text = '')  {
        this.saved = $(this.target).html();
        $(this.target).html('<div class="fa fa-circle-o-notch fa-spin"></div> ' + text);
        return this;

    },

    removeSpin: function() {
        $(this.target).removeClass('fa-circle-o-notch fa-spin')
        return this
    },

    addSpin: function()  {
        $(this.target).addClass('fa-circle-o-notch fa-spin')
        return this
    },

    addId: function(id)  {
        $(this.target).addClass(id)
        return this
    },

    addCheck: function()  {
        $(this.target).addClass('fa-check')
        return this
    },

    addBan: function()  {
        $(this.target).addClass('fa-ban')
        return this
    },

    addClicked: function()  {
        $(this.target).addClass('clicked')
        return this
    },

    removeClicked: function()  {
        $(this.target).removeClass('clicked')
        return this
    },

    alreadyClicked: function(event)  {
        return $(event.target).hasClass('clicked')
    },

}
