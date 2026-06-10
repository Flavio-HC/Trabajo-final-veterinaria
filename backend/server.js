const express = require('express');

const app = express();

app.use(express.json());

const reportes = require('./routes/reportes');

app.use('/reportes', reportes);

const PORT = 3000;

app.listen(PORT, () => {
    console.log(`Servidor ejecutándose en puerto ${PORT}`);
});
