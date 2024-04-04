import express, { Router } from 'express';
import shoppinglistController from '../controllers/shoppinglist.controller';

const shoppinglistRouter: Router = express.Router();

shoppinglistRouter.get('/:id', shoppinglistController.getingredients);

export default shoppinglistRouter;