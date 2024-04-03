import express, { Router } from 'express';
import mealplanController from '../controllers/mealplan.controller';

const mealPlanRouter: Router = express.Router();

mealPlanRouter.get('/id/:id', mealplanController.getMealPlansByUser);
mealPlanRouter.post('/', mealplanController.createMealPlanForUser);

export default mealPlanRouter;
