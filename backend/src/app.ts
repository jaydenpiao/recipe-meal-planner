import express from 'express';
import connection from './db';
import recipeRoutes from './routes/recipe.route';
import userRouter from './routes/user.route';

const cors = require('cors');

const app = express();

app.use(express.json());
app.use(cors());
app.use('/api/recipes', recipeRoutes);
app.use('/api/users', userRouter);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
