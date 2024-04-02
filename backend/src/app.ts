import express from 'express';
import recipeRoutes from './routes/recipe.route';
import userRouter from './routes/user.route';
import mealplanRouter from './routes/mealplan.route';
const app = express();

app.use(express.json());
app.use('/api/recipes', recipeRoutes);
app.use('/api/users', userRouter);
app.use('/api/mealplan', mealplanRouter);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
