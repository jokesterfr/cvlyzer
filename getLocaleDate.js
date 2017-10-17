#!/usr/bin/env node
const moment = require('moment')()
moment.locale(process.argv[2])
console.log(moment.format('LL'))
