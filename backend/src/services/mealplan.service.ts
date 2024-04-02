import connection from '../db';
import { RowDataPacket, FieldPacket } from 'mysql2';

interface MealPlan {
    mealPlanID: number;
    name: string;
    date: Date;
    userID: number;
  }
  
const mealPlanService = {};

export default mealPlanService;