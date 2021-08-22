import { Request, Response } from "express";
import { getManager } from "typeorm";
import { CommentRepository } from "../database/comments/repository/comment.repository";

export class CommentController {
  static async addComment(req: Request, res: Response) {
    let connectionmanager = getManager().getCustomRepository(CommentRepository);
    await connectionmanager.addComment(req, res);
  }

  static async getPostComments(req: Request, res: Response) {
    let connectionmanager = getManager().getCustomRepository(CommentRepository);
    await connectionmanager.getPostComments(req, res);
  }
}
