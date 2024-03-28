import express, { Router } from 'express';
import recipeController from '../controllers/recipeController';

const recipeRouter: Router = express.Router();

recipeRouter.get('/recipes', recipeController.getAllRecipes);

export default recipeRouter;