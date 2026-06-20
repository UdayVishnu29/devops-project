const express = require("express");
const app = express();

const VERSION = "v3";

app.get("/", (req, res) => {
  res.send(`
        <h1>Fake E-Commerce API</h1>
        <h2>${VERSION}</h2>
        <p>Running on Kubernetes + Jenkins + ECR + EKS</p>
    `);
});

// CPU load endpoint
app.get("/load", (req, res) => {
  let total = 0;

  for (let i = 0; i < 500000000; i++) {
    total += Math.sqrt(i);
  }

  res.send(`Load Test Complete ${total}`);
});

app.listen(3000, () => {
  console.log(`Server running on port 3000 - ${VERSION}`);
});
