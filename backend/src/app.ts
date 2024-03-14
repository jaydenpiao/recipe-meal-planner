import express from 'express';

const app = express();

import { Request, Response } from 'express';

app.get('/', (req: Request, res: Response) => {
  res.send('TEST MESSAGE');
});


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
