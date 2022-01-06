const express = require('express');
const app = express();
const port = 8047;
const {time} = require('@/utils');

time();

app.get('/', (req, res) => {
    res.send('Hello World!');
});

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`);
});
