const express = require('express');
const app = express();
const port = 80;

app.get('/', (req, res) => {
  res.json({
    message: 'Hello from ECS Fargate!',
    version: process.env.BUILD_ID || 'unknown',
    environment: process.env.ENVIRONMENT || 'dev'
  });
});

app.get('/health', (req, res) => {
  res.status(200).json({ status: 'healthy' });
});

app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});
