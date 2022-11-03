const express = require("express");
const multer = require("multer");
const customerModel = require('../model/customerModel');
const productModel = require("../model/productModel");

const admin = express.Router();

// GET All customers
admin.get("/customer", async (req, res) => {
    try {
        let customers = await customerModel.find({});
        res.json(customers);
    }
    catch (err) {
        res.status(400).send("Error fetching customers!");
    }
});

// Add a customer
admin.post("/customer", async (req, res) => {
    let customer = new customerModel({ ...req.body });
    try {
        await customer.save();
        res.json(customer);
    }
    catch (err) {
        console.error(err)
        res.status(400).send(err);
    }
});

// GET Customer by ID
admin.get("/customer/:id", async (req, res) => {
    try {
        let customer = await customerModel.findById(req.params.id);
        res.json(customer);
    }
    catch (err) {
        res.status(400).send("Error fetching listings!");
    }
});

// Add product
admin.post("/product", async (req, res) => {
    let product = new productModel({ ...req.body });
    try {
        await product.save();
        res.json(product);
    }
    catch (err) {
        console.error(err)
        res.status(400).send(err);
    }
});

// Modify Product Quantity
admin.patch("/product/:id", async (req, res) => {
    try {
        let product = await productModel.findByIdAndUpdate(req.params.id, { ...req.body }, { returnDocument: 'after' });
        res.json(product);
    }
    catch (err) {
        console.error(err)
        res.status(400).send(err);
    }
});


// Add Product Image
const storage = multer.diskStorage({
    destination: 'public/assets/img/',
    filename: function (req, file, cb) {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        cb(null, file.fieldname + '-' + uniqueSuffix)
    }
});
const upload = multer({ storage: storage });
admin.patch("/product/:id/img", upload.single('image'), async (req, res) => {
    req.file.filename = req.params.id;
    console.log(req.file.path);
    try {
        let product = await productModel.findByIdAndUpdate(req.params.id, { productImageURL: req.file.path }, { returnDocument: 'after' });
        res.json(product);
    }
    catch (err) {
        console.error(err)
        res.status(400).send(err);
    }
});



module.exports = admin;