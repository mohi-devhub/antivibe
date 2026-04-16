import { Request, Response } from 'express';
import { UserService } from './user.service';

export interface UserDTO {
  id: string;
  name: string;
  email: string;
}

export type UserRole = 'admin' | 'user' | 'guest';

export class UserController {
  constructor(private userService: UserService) {}

  async getUser(req: Request, res: Response): Promise<void> {
    const user = await this.userService.findById(req.params.id);
    res.json(user);
  }

  async createUser(req: Request, res: Response): Promise<void> {
    const user = await this.userService.create(req.body);
    res.status(201).json(user);
  }
}

export function validateEmail(email: string): boolean {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

const formatUser = (user: UserDTO): string => {
  return `${user.name} <${user.email}>`;
};

export default UserController;
