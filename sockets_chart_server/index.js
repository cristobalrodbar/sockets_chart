const express = require('express');
const app = express();


app.listen(3000, (err) => {
    if (err) throw new Error(err);
    console.log('servidor corriendo en puerto', 3000);
});