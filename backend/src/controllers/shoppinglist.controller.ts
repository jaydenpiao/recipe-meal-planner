import { Request, Response } from 'express';
import shoppinglistService from '../services/shoppinglist.service';

const controller = {
    getingredients: async (req: Request, res: Response): Promise<void> => {
        const id = parseInt(req.params.id);

        if (isNaN(id)) {
            res.status(400).json({ error: 'Invalid ID' });
            return;
        }

        try {
            const recipe = await shoppinglistService.getingredients(id);
            if (!recipe) {
                res.status(404).json({ error: 'ingredients not found' });
                return;
            }
            res.json(recipe);
        } catch (error: any) {
            res.status(500).json({ error: error.message });
        }
    }
}
export default controller;