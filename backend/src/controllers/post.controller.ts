import { Request, Response } from "express";
import { getManager } from "typeorm";
import { PostRepository } from "../database/posts/repository/post.repository";

export class PostController {
  static async addPost(req: Request, res: Response) {
    let connectionmanager = getManager().getCustomRepository(PostRepository);
    await connectionmanager.addPost(req, res);
  }

}
