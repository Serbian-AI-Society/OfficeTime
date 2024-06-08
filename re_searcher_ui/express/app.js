const express = require('express')
const axios = require('axios');

const app = express()
const port = 3000

app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Methods", "GET,PUT,PATCH,POST,DELETE");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});

app.get('*', (_, res) => { 
  res.sendFile('web/index.html', {root: __dirname }) 
}); 

app.use(express.static(__dirname + '/web'))

app.use((req, res) => {
  res.redirect('/')
})

app.listen(port, () => {
  console.log(`app listening at http://localhost:${port}`)
})
