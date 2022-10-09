const express = require("express");
const productModel = require('../model/productModel');

const product = express.Router();

// GET All products
product.get("/product", async (req, res) => {
    try {
        let products = await productModel.find({}).limit(50)
        res.json(products);
    }
    catch (err) {
        res.status(400).send("Error fetching listings!");
    }
});

// GET product by ID
product.get("/product/:id", async (req, res) => {
    try {
        let product = await productModel.findById(req.params.id);
        res.json(product);
    }
    catch (err) {
        res.status(400).send("Error fetching product!");
    }
});

module.exports = product;