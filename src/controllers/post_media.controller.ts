import { Request, Response } from "express";
import { getManager } from "typeorm";
import { PostMediaRepository } from "../database/posts/repository/post_media.repository";

export class PostMediaController {
    static async addPostMedia(req: Request, res: Response) {
        let connectionmanager = getManager().getCustomRepository(PostMediaRepository);
        await connectionmanager.addPostMedia(req, res)
    }
}