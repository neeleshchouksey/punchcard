export default {
    getFormData: function (target)
    {
        return new Promise((resolve, reject) => {
            let formData = new FormData(target);

            let fdEntries = formData.entries();
            let keyVal;
            let pile = {}

            while (keyVal = fdEntries.next()) {
                if (keyVal.done) {
                    break;
                }

                let [key,val] = keyVal.value;

                let spl = key.split('.');

                if (! spl) {
                    pile[key] = val;
                    continue;
                }

                // a dot -> SIC!!
                let Obj = {}

                // jdoc.emerContact.phoneNumber = val
                if (spl.length == 3) {
                    if (pile[  spl[0]  ] == undefined) {
                        pile[  spl[0]  ] = {};
                    }

                    if (pile[  spl[0]  ][  spl[1]  ] == undefined) {
                        pile[  spl[0]  ][  spl[1]  ] = {};
                    }

                    if (pile[  spl[0]  ][  spl[1]  ][  spl[2]  ] == undefined) {
                        pile[  spl[0]  ][  spl[1]  ][  spl[2]  ] = {};
                    }

                    pile[  spl[0]  ][  spl[1]  ][ spl[2] ] = val;

                // jdoc.phoneNumber = val
                } else if (spl.length == 2) {

                    if (pile[  spl[0]  ] == undefined) {
                        pile[  spl[0]  ] = {};
                    }

                    if (pile[  spl[0]  ][  spl[1]  ] == undefined) {
                        pile[  spl[0]  ][  spl[1]  ] = {};
                    }

                    pile[  spl[0]  ][  spl[1]  ]= val;

                } else if (spl.length == 1) {
                    pile[spl[0]] = val;
                }
            }

            resolve(pile);
        });
    }
}
