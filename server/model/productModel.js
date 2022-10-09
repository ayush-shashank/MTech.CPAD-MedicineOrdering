const { Schema, default: mongoose, SchemaTypes } = require("mongoose");

const productSchema = new Schema({
    name: {
        type: String,
        required: true
    },
    weightInGrams: {
        type: SchemaTypes.Decimal128,
        min: 0

    },
    price: {
        type: SchemaTypes.Decimal128,
        required: true,
        min: 0
    },
    qtyAvailable: {
        type: Number,
        required: true,
        min: 0
    },
    doesPrescription: {
        type: Boolean,
        default: false
    }
}, { timestamps: true })

const productModel = mongoose.model("Product", productSchema);

module.exports = productModel;
