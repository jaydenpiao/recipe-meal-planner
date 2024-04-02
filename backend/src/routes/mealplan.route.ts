import express, { Router } from 'express';
import mealplanController from '../controllers/mealplan.controller';

const recipeRouter: Router = express.Router();

recipeRouter.get('/id/:id', mealplanController.getMealPlansByUser);

export default recipeRouter;