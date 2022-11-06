const { Schema, default: mongoose } = require("mongoose");

const productSchema = new Schema({
    name: {
        type: String,
        required: true
    },
    weightInGrams: {
        type: Number,
        min: 0
    },
    price: {
        type: Number,
        required: true,
        min: 0
    },
    discount: {
        type: Number,
        default: 0
    },
    quantityAvailable: {
        type: Number,
        required: true,
        min: 0
    },
    productImageURL: {
        type: String,
        default: ''
    },
    doesRequirePrescription: {
        type: Boolean,
        default: false
    }
}, { timestamps: true })

const productModel = mongoose.model("Product", productSchema);

module.exports = productModel;
