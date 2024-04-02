import express, { Router } from 'express';
import userController from '../controllers/user.controller';

const userRouter: Router = express.Router();

userRouter.get('/', userController.getAllUsers);

export default userRouter;