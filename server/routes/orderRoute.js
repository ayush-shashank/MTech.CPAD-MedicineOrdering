const express = require("express");
const orderModel = require("../model/orderModel");

const order = express.Router();

// Get Order
order.get('/order/:id', async (req, res) => {
    let result = await orderModel.findById(req.params.id);
    res.json(result);
});

// Update Order
order.patch('/order/:id', async (req, res) => {
    let orderId = req.params.id;
    let update = { $set: { isActive: false } };
    let result = await orderModel.findByIdAndUpdate(orderId, update, { returnDocument: 'after' });
    if (result) res.json(result);
    else res.send("error");
});

module.exports = order;