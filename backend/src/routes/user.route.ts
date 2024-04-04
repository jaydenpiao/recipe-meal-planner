import express, { Router } from 'express';
import userController from '../controllers/user.controller';

const userRouter: Router = express.Router();

userRouter.get('/', userController.getAllUsers);
userRouter.get('/verifiedreviewers', userController.verifiedReviewers);

export default userRouter;