import { Request, Response } from 'express';
import recipeService from '../services/recipeService';

const controller = {
  getAllRecipes: async (req: Request, res: Response): Promise<void> => {
    try {
      const users = await recipeService.getAllRecipes();
      res.json(users);
    } catch (error: any) {
      res.status(500).json({ error: error.message });
    }
  },

  // Implement other controller methods similarly
};

export default controller;