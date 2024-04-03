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
    const userID = parseInt(req.params.userID);
    const name = req.params.name;

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
  },

  editMealPlanName: async (req: Request, res: Response): Promise<void> => {
    const mealPlanID = parseInt(req.params.id);
    const newName = req.params.name;

    if (!mealPlanID || !newName) {
        res.status(400).json({ error: 'Missing mealPlanID or newName' });
        return;
    }

    try {
        await mealPlanService.editMealPlanName(mealPlanID, newName);
        res.status(200).json({ message: 'Meal plan name updated successfully' });
    } catch (error: any) {
        res.status(500).json({ error: error.message });
    }
},
addRecipe: async (req: Request, res: Response): Promise<void> => {
  const mealPlanID = parseInt(req.params.mealPlanID);
  const recipeID = parseInt(req.params.recipeID);

  if (!mealPlanID || !recipeID) {
      res.status(400).json({ error: 'Missing mealPlanID or recipeID' });
      return;
  }

  try {
      await mealPlanService.addRecipe(mealPlanID, recipeID);
      res.status(200).json({ message: 'Recipe added to meal plan successfully' });
  } catch (error: any) {
      res.status(500).json({ error: error.message });
  }
},
deleteRecipe: async (req: Request, res: Response): Promise<void> => {
  const mealPlanID = parseInt(req.params.mealPlanID);
  const recipeID = parseInt(req.params.recipeID);

  try {
      await mealPlanService.deleteRecipe(mealPlanID, recipeID);
      res.status(200).json({ message: 'Recipe deleted from meal plan successfully' });
  } catch (error: any) {
      res.status(500).json({ error: error.message });
  }
},
getRecipe: async (req: Request, res: Response): Promise<void> => {
  const mealPlanID = parseInt(req.params.id);

  try {
      const recipes = await mealPlanService.getRecipe(mealPlanID);
      res.status(200).json(recipes);
  } catch (error: any) {
      res.status(500).json({ error: error.message });
  }
}

}
export default controller;