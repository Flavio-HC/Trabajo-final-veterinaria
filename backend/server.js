const express = require('express');

const app = express();

app.use(express.json());

const reportes = require('./routes/reportes');
const crud = require('./routes/crud');

app.use('/reportes', reportes);
app.use('/crud', crud);

const PORT = 3000;

app.listen(PORT, () => {
    console.log(`Servidor ejecutándose en puerto ${PORT}`);
});
