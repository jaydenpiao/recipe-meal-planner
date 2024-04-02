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
      }
}
export default controller;