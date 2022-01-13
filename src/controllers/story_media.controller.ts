import { Request, Response } from "express";
import { getManager } from "typeorm";
import { StoryMediaRepository } from "../database/stories/repository/story_media.repository";

export class StoryMediaController {
    static async addStoryMedia(req: Request, res: Response) {
        let connectionmanager = getManager().getCustomRepository(StoryMediaRepository);
        await connectionmanager.addStoryMedia(req, res)
    }
}