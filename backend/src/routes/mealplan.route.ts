import express, { Router } from 'express';
import mealplanController from '../controllers/mealplan.controller';

const mealPlanRouter: Router = express.Router();

mealPlanRouter.get('/id/:id', mealplanController.getMealPlansByUser);
mealPlanRouter.post('/add', mealplanController.createMealPlanForUser);
mealPlanRouter.delete('/:mealPlanID', mealplanController.deleteMealPlan);
export default mealPlanRouter;
