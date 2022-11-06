require('dotenv').config({ path: './config.env' });
const express = require('express');
const cors = require('cors');
const path = require('path');
const db = require('./db/conn');

const HOST = process.env.HOST || 'localhost';
const PORT = process.env.PORT || 3000;

const app = express();

const requestLogger = (req, res, next) => {
    console.log(`=> ${req.method}  \t${req.path}`);
    next();
}
app.use('/public', express.static('public'))
app.use(cors());
app.use(express.json({ urlencoded: true }));
app.use(requestLogger);

app.use(require('./routes/adminRoute'));
app.use('/product', require('./routes/productRoute'));
app.use('/user', require('./routes/userRoute'));
app.use('/order', require('./routes/orderRoute'));

app.get('/', (req, res) => res.send('Online Medicine Order App'));

app.listen(PORT, HOST, async () => {
    console.log("Starting Server...");
    try {
        await db.connectToServer();
        console.log(`Server is running on http://${HOST === '0.0.0.0' ? 'localhost' : HOST}:${PORT}`);
    } catch (error) {
        console.error(error);
        process.exit();
    };
});
