import express, { Router } from 'express';
import mealplanController from '../controllers/mealplan.controller';

const mealPlanRouter: Router = express.Router();

mealPlanRouter.get('/:id', mealplanController.getMealPlansByUser);
mealPlanRouter.post('/create/:userID/:name', mealplanController.createMealPlanForUser);
mealPlanRouter.delete('/:mealPlanID', mealplanController.deleteMealPlan);
mealPlanRouter.put('/:id/:name', mealplanController.editMealPlanName);
mealPlanRouter.post('/addrecipe/:mealPlanID/:recipeID', mealplanController.addRecipe);
mealPlanRouter.delete('/deleterecipe/:mealPlanID/:recipeID', mealplanController.deleteRecipe);


export default mealPlanRouter;
