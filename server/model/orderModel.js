const { Schema, SchemaTypes, default: mongoose } = require("mongoose");

const orderSchema = new Schema({
    customerId: {
        type: SchemaTypes.ObjectId,
        required: true
    },
    productId: {
        type: SchemaTypes.ObjectId,
        required: true
    },
    qty: {
        type: Number,
        required: true,
        min: 0
    },
    prescription: [{ data: Buffer, contentType: String }],
    isActive: {
        type: Boolean,
        default: true
    }
}, { timestamps: true });

const orderModel = mongoose.model("Order", orderSchema);

module.exports = orderModel;
