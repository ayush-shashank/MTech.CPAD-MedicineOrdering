const express = require("express");
const customerModel = require("../model/customerModel");
const orderModel = require("../model/orderModel");
const productModel = require("../model/productModel");

const user = express.Router();

// Login User
user.post("user/login", async (req, res) => {
    try {
        let customer = await customerModel.findOne({ ...req.body });
        if (!customer)
            res.send("Invalid Credentials!");
        else
            res.json(customer._id);
    }
    catch (err) {
        console.error(err)
        res.status(400).send(err);
    }
});

// Book Doctor
user.get('/user/:id/bookDoctor', (req, res) => {
    res.sendStatus(404);
});
// Book Test
user.get('/user/:id/bookLab', (req, res) => {
    res.sendStatus(404);
});

// GET Active transactions
user.get('/user/:id/activeTransactions', async (req, res) => {
    let id = req.params.id;
    const filter = { customerId: id, 'isActive': true };
    let result = await orderModel.find(filter).sort({ 'updatedAt': -1 });
    res.json(result);
});

// Search Medicine by Name
user.get('/product/search', async (req, res) => {
    let productName = req.query.productName.trim();
    let result = await productModel.find({ $text: { $search: productName, $caseSensitive: false } });
    res.json(result);
});

// GET last 3 transactions
user.get('/user/:id/latestTransactions', async (req, res) => {
    let id = req.params.id;
    const filter = { customerId: id };
    let result = await orderModel.find(filter).sort({ 'updatedAt': -1 }).limit(3);
    res.json(result);
});

// POST Order Medicine
user.post('/user/:id/orderMedicine', async (req, res) => {
    let order = { ...req.body };
    let condition = { _id: order.productId, qtyAvailable: { $gte: order.qty } };
    let update = { $inc: { qtyAvailable: -order.qty } };
    let options = { returnDocument: 'after' };
    try {
        let productDoc = await productModel.findOneAndUpdate(condition, update, options);
        if (productDoc) {
            try {
                let orderDoc = await new orderModel({ productId: productDoc._id, customerId: req.params.id, ...order }).save();
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
user.get('/user/:id/orders', async (req, res) => {
    let id = req.params.id;
    let result = await orderModel.find({ customerId: id },);
    res.json(result);
});

module.exports = user;
