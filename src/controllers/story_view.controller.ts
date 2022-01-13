import { Request, Response } from "express";
import { getManager } from "typeorm";
import { StoryViewRepository } from "../database/stories/repository/story_view.repository";


export class StoryViewController {
    static async addStoryView(req: Request, res: Response) {
        let connectionmanager = getManager().getCustomRepository(StoryViewRepository);
        await connectionmanager.addStoryView(req, res);
    }

    static async isViewedByUser(req: Request, res: Response) {
        let connectionmanager = getManager().getCustomRepository(StoryViewRepository);
        await connectionmanager.isViewedByUser(req, res);
    }

    static async getStoryViewCount(req: Request, res: Response) {
        let connectionmanager = getManager().getCustomRepository(StoryViewRepository);
        await connectionmanager.getStoryViewCount(req, res);
    }
}
