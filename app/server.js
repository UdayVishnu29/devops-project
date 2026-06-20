const express = require("express");

const app = express();

const PORT = 3000;

const products = [
  {
    id: 1,
    name: "Laptop",
    price: 1200,
  },
  {
    id: 2,
    name: "Phone",
    price: 800,
  },
];

app.get("/", (req, res) => {
  res.json({
    status: "running",
    version: "1.0",
  });
});

app.get("/products", (req, res) => {
  res.json(products);
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
