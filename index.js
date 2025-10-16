const express = require("express");
const cors = require("cors");
require("dotenv").config();

const app = express();
const PORT = process.env.PORT || 4000;

app.use(cors());

app.get("/", (req, res) => {
  res.send("Hello, world");
});

app.listen(PORT, () => {
  console.log(`Express server running on http://localhost:${PORT}`);
});