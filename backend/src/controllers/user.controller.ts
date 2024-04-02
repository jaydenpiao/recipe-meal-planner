import { Request, Response } from 'express';
import userService from '../services/user.service';

const controller = {
  getAllUsers: async (req: Request, res: Response): Promise<void> => {
    try {
      const user = await userService.getAllUsers();
      res.json(user);
    } catch (error: any) {
      res.status(500).json({ error: error.message });
    }
  }
}
export default controller;