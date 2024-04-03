import { Request, Response } from 'express';
import mealPlanService from '../services/mealplan.service';

const controller = {
  getMealPlansByUser: async (req: Request, res: Response): Promise<void> => {
    const userID = parseInt(req.params.id);

    if (isNaN(userID)) {
      res.status(400).json({ error: 'Invalid ID' });
      return;
    }

    try {
      const recipe = await mealPlanService.getMealPlansByUser(userID);
      if (!recipe) {
        res.status(404).json({ error: 'Recipe not found' });
        return;
      }
      res.json(recipe);
    } catch (error: any) {
      res.status(500).json({ error: error.message });
    }
  },
  
  createMealPlanForUser: async (req: Request, res: Response): Promise<void> => {
    const userID = parseInt(req.body.userID);
    const name = req.body.name;

    // Check if userID or name is missing
    if (!userID || !name) {
      res.status(400).json({ error: 'Missing userID or name' });
      return;
    }

    try {
      const mealPlan = await mealPlanService.createMealPlanForUser(userID, name);
      res.status(201).json(mealPlan); 
    } catch (error: any) {
      res.status(500).json({ error: error.message });
    }
  },

  deleteMealPlan: async (req: Request, res: Response): Promise<void> => {
    try {
      const mealPlanID: number = parseInt(req.params.mealPlanID);

      await mealPlanService.deleteMealPlan(mealPlanID);
      res.status(200).json({ message: 'Meal plan deleted successfully' });
    } catch (error: any) {
      res.status(500).json({ error: error.message });
    }
  }

}
export default controller;