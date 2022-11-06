const express = require("express");
const productModel = require('../model/productModel');

const product = express.Router();

// GET All products
product.get("/", async (req, res) => {
    try {
        let products = await productModel.find({}).limit(50)
        res.json(products);
    }
    catch (err) {
        res.status(400).send("Error fetching listings!");
    }
});

// Search Medicine by Name
product.get('/search', async (req, res) => {
    let productName = req.query.productName.trim();
    try {
        let result = await productModel.find({ $text: { $search: productName, $caseSensitive: false } });
        res.json(result);
    } catch (err) {
        res.status(400).send("Error fetching product!");
    }
});

// GET product by ID
product.get("/:id", async (req, res) => {
    try {
        let product = await productModel.findById(req.params.id);
        res.json(product);
    }
    catch (err) {
        res.status(400).send("Error fetching product!");
    }
});

module.exports = product;