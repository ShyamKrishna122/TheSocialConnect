import { Request, Response } from "express";
import { getManager } from "typeorm";
import { PostRepository } from "../database/posts/repository/post.repository";

export class PostController {
  static async addPost(req: Request, res: Response) {
    let connectionmanager = getManager().getCustomRepository(PostRepository);
    await connectionmanager.addPost(req, res);
  }

  static async getPosts(req: Request, res: Response) {
    let connectionmanager = getManager().getCustomRepository(PostRepository);
    await connectionmanager.getPosts(req, res);
  }

  static async showUserPosts(req: Request, res: Response) {
    let connectionmanager = getManager().getCustomRepository(PostRepository);
    await connectionmanager.fetchUserPosts(req, res);
  }

  static async getPostCount(req: Request, res: Response) {
    let connectionmanager = getManager().getCustomRepository(PostRepository);
    await connectionmanager.getPostCount(req,res);
  }

  static async deleteUserPost(req: Request, res: Response) {
    let connectionmanager = getManager().getCustomRepository(PostRepository);
    await connectionmanager.deleteUserPost(req,res);
  }
}
