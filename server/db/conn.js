const { default: mongoose } = require("mongoose");

const connUri = process.env.DB_CONN_URI;

let connectToServer = async () => {
    try {
        await mongoose.connect(connUri, { useNewUrlParser: true, useUnifiedTopology: true });
        console.log("Successfully connected to MongoDB.");
    } catch (err) {
        console.error(err);
        return err;
    };
};

module.exports = { connectToServer };
