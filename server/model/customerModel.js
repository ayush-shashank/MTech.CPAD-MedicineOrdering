const { Schema, default: mongoose, SchemaTypes } = require("mongoose");

const customerSchema = new Schema({
    name: {
        type: String,
        required: [true, "Name is required!"],
        trim: true,
    },
    email: {
        type: String,
        required: [true, "Email ID is required!"],
        lowercase: true,
        trim: true,
        unique: [true, "Email ID already exists!"],
        match: [/\S+@\S+\.\S+/, "Email ID is invalid!"]
    },
    phno: {
        type: Number,
        validate: {
            validator: val => val.toString().length === 10,
            message: "Phone number is invalid!"
        }
    },
    password: {
        type: String,
        required: true
    },
    orders: [SchemaTypes.ObjectId]
});

const customerModel = mongoose.model("Customer", customerSchema);

module.exports = customerModel;
