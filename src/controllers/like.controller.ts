import { Request, Response } from "express";
import { getManager } from "typeorm";
import { LikeRepository } from "../database/likes/Repository/like.repository";


export class LikeController {
  static async addLike(req: Request, res: Response) {
    let connectionmanager = getManager().getCustomRepository(LikeRepository);
    await connectionmanager.addLike(req, res);
  }

  static async removeLike(req: Request, res: Response) {
    let connectionmanager = getManager().getCustomRepository(LikeRepository);
    await connectionmanager.removeLike(req, res);
  }

  static async isLikedByUser(req: Request, res: Response) {
    let connectionmanager = getManager().getCustomRepository(LikeRepository);
    await connectionmanager.isLikedByUser(req, res);
  }

  static async getPostLikesCount(req: Request, res: Response) {
    let connectionmanager = getManager().getCustomRepository(LikeRepository);
    await connectionmanager.getPostLikesCount(req, res);
  }

  static async getPersonList(req: Request, res: Response) {
    let connectionmanager = getManager().getCustomRepository(LikeRepository);
    await connectionmanager.getPersonList(req,res);
  }
}
