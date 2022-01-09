import { Request, Response } from "express";
import { getManager } from "typeorm";
import { FollowRepository } from "../database/followers/repository/follow.repository";

export class FollowController {
  static async addFollowing(req: Request, res: Response) {
    let connectionmanager = getManager().getCustomRepository(FollowRepository);
    await connectionmanager.addFollowing(req, res);
  }

  static async removeFollowing(req: Request, res: Response) {
    let connectionmanager = getManager().getCustomRepository(FollowRepository);
    await connectionmanager.removeFollowing(req, res);
  }

  static async isFollowingUser(req: Request, res: Response) {
    let connectionmanager = getManager().getCustomRepository(FollowRepository);
    await connectionmanager.isFollowingUser(req, res);
  }

  static async getFollowingCount(req: Request, res: Response) {
    let connectionmanager = getManager().getCustomRepository(FollowRepository);
    await connectionmanager.getFollowingCount(req,res);
  }

  static async getFollowersCount(req: Request, res: Response) {
    let connectionmanager = getManager().getCustomRepository(FollowRepository);
    await connectionmanager.getFollowersCount(req,res);
  }
}
