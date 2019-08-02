<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    div {

    }
      thead tr {
          background-color: $theme-gold;
      }
      tr {
          padding: 5px;
          padding-bottom: 20px;
      }

      td {
          vertical-align: center;
          text-align: center;
          &:first-child {
              text-align: left;
          }
      }

      tbody tr {
          &:nth-child(odd) {
              background-color: lighten($theme-gold, 25%);
          }
      }

      tr.sort td:hover {
          cursor: pointer;
          background: $laravel-border-color;
      }
</style>
<template>
    <div v-if="rows && cols">
        <table class="table table-striped" style="border-radius: 15px;">
            <thead>
                <tr class="sort">
                    <td v-for="(col, index) in cols" @click="sortRows(index)" v-if="col!='ID'">
                        <i class="fa fa-sort"></i> {{ col }}
                         <!-- v-if="col!='Detail' || col!='List Employees'" -->
                    </td>
               </tr>
            </thead>
            <tbody>
                <tr v-for="row in computedRows">
                    <td v-for="(td, index) in row" v-html="td" v-if="validate(index)"></td>
               </tr>
            </tbody>
        </table>
    </div>
</template>
<script>

    export default {
        name: 'simple-table',
        data () {
            return {
                Perm: Perm,
                loading: true,
                orderDir: ['asc'],
                orderBy : [0]

            }
        },
        created () {
        },
        props: {
            rows: {
                type: Array,
                default: null
            },
            cols: {
                type: Array,
                default: null
            },
        },
        computed: {

          computedRows : function(){
            var list = [];
            for (var i = 0; i < this.rows.length; i++) {
              var rowData = this.rows[i];
              var obj = {};
              for (var j = 0; j < rowData.length; j++) {
                obj[j] = rowData[j];
              }
              list.push(obj);
            }

            list = _.orderBy(list, this.orderBy, this.orderDir)

            var orderedData = [];
            for (var i = 0; i < list.length; i++) {
              var data = [];
              var obj = list[i];
              for (var p in obj) {
                if( obj.hasOwnProperty(p) ) {
                  data.push(obj[p]);
                }
              }
              orderedData.push(data);
            }
            this.row = orderedData;

            return this.row;
          }
        },
        components: {
        },
        methods: {
          validate : function(index){
            var idIndex = this.cols.indexOf('ID');
            return !(idIndex == index);
          },
          sortRows: function(orderBy)
          {
              this.orderBy = [orderBy]
              this.orderDir = (this.orderDir.indexOf('desc') > -1) ? ['asc'] : ['desc'];
          },
        }
    }
</script>
