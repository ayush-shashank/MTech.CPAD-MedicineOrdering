require('dotenv').config({ path: './config.env' });
const express = require('express');
const db = require('./db/conn');

const HOST = process.env.HOST || 'localhost';
const PORT = process.env.PORT || 3000;

const app = express();

app.use(express.json({ urlencoded: true }));
app.use(require('./routes/adminRoute'));
app.use(require('./routes/productRoute'));
app.use(require('./routes/userRoute'));
app.use(require('./routes/orderRoute'));

app.get('/', (req, res) => res.send('Online Medicine Order App'));

app.listen(PORT, HOST, () => {
    db.connectToServer()
        .then(() => {
            console.log(`Server is running on http://${HOST === '0.0.0.0' ? 'localhost' : HOST}:${PORT}`);
        })
        .catch((err) => {
            console.error(err);
            process.exit();
        });
});
