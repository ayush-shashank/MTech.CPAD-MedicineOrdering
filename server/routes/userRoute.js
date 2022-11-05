const express = require("express");
const customerModel = require("../model/customerModel");
const orderModel = require("../model/orderModel");
const productModel = require("../model/productModel");

const user = express.Router();

// Login User
user.post("/login", async (req, res) => {
    console.log("body", req.body);
    try {
        let customer = await customerModel.findOne({ ...req.body });
        if (!customer) {
            res.json({ error: "Invalid Credentials!" });
        } else {
            res.json(customer);
        }
    }
    catch (err) {
        console.error(err)
        res.status(400).send(err);
    }
});

// Book Doctor
user.get('/:id/bookDoctor', (req, res) => {
    res.sendStatus(404);
});
// Book Test
user.get('/:id/bookLab', (req, res) => {
    res.sendStatus(404);
});

// GET Active transactions
user.get('/:id/activeTransactions', async (req, res) => {
    let id = req.params.id;
    const filter = { customerId: id, 'isActive': true };
    let result = await orderModel.find(filter).sort({ 'updatedAt': -1 });
    res.json(result);
});

// GET last 3 transactions
user.get('/:id/latestTransactions', async (req, res) => {
    let id = req.params.id;
    const filter = { customerId: id };
    let result = await orderModel.find(filter).sort({ 'updatedAt': -1 }).limit(3);
    res.json(result);
});

// POST Order Medicine
user.post('/:id/orderMedicine', async (req, res) => {
    let order = { ...req.body, isActive: true };
    let condition = { _id: order.productId, quantityAvailable: { $gte: order.quantity } };
    let update = { $inc: { quantityAvailable: -order.quantity } };
    let options = { returnDocument: 'after' };
    try {
        let productDoc = await productModel.findOneAndUpdate(condition, update, options);
        if (productDoc) {
            try {
                let orderDoc = await new orderModel({
                    customerId: req.params.id,
                    productId: productDoc._id,
                    productName: productDoc.name,
                    productImageURL: productDoc.productImageURL,
                    orderAmount: (productDoc.price * order.quantity),
                    ...order
                }).save();
                await customerModel.findByIdAndUpdate(req.params.id, { $push: { orders: orderDoc._id } }, options)
                res.json(orderDoc);
            } catch (err) {
                console.error(err)
                res.send("Something Went Wrong")
            };
        } else {
            res.send("Stock unavailable!")
        }
    } catch (err) {
        console.error(err);
        res.send("Something Went Wrong");
    };
});

// GET User Orders
user.get('/:id/orders', async (req, res) => {
    let id = req.params.id;
    let result = await orderModel.find({ customerId: id },);
    res.json(result);
});

module.exports = user;
