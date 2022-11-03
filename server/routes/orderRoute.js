const express = require("express");
const orderModel = require("../model/orderModel");
const multer = require('multer')
const order = express.Router();

let getOrder = async (req, res) => {
    let result = await orderModel.findById(req.params.id);
    res.json(result);
}

let updateOrderState = async (req, res) => {
    let orderId = req.params.id;
    let update = { $set: { isActive: false } };
    let result = await orderModel.findByIdAndUpdate(orderId, update, { returnDocument: 'after' });
    if (result) res.json(result);
    else res.send("error");
}

order.route('/:id')
    .get(getOrder)
    .patch(updateOrderState);

const storage = multer.diskStorage({
    destination: 'public/data/uploads/',
    filename: function (req, file, cb) {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        cb(null, file.fieldname + '-' + uniqueSuffix)
    }
});
const upload = multer({ storage: storage });

order.post('/uploadPrescription', upload.single('image'), async (req, res) => {
    res.send(req.file.path);
})
module.exports = order;