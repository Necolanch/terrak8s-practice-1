const express = require("express");
const cors = require("cors");
require("dotenv").config();
const appinsights = require("applicationinsights");

appinsights.setup().start();
const appInsightsClient = appinsights.defaultClient;

const app = express();
const PORT = process.env.PORT || 4000;

app.use(cors());

app.get("/", (req, res) => {
  appInsightsClient.trackEvent({ name: "RootEndpointHit", properties:{message: "Root endpoint was hit"} });
  res.send("Hello, world");
});

app.listen(PORT, () => {
  console.log(`Express server running on http://localhost:${PORT}`);
});