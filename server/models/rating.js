import { Schema } from "mongoose";

const ratingSchema = Schema({
  userId: {
    type: String,
    required: true,
  },
  rating: {
    type: Number,
    required: true,
  },
});

export default ratingSchema;