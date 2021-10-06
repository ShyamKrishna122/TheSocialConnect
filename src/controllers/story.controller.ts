import { Request, Response } from "express";
import { getManager } from "typeorm";
import { StoryRepository } from "../database/stories/repository/story.repository";

export class StoryController {
  static async addStory(req: Request, res: Response) {
    let connectionmanager = getManager().getCustomRepository(StoryRepository);
    await connectionmanager.addStory(req, res);
  }

  static async fetchStory(req: Request, res: Response) {
    let connectionmanager = getManager().getCustomRepository(StoryRepository);
    await connectionmanager.fetchStory(req, res);
  }

  static async fetchStoryByUser(req: Request, res: Response) {
    let connectionmanager = getManager().getCustomRepository(StoryRepository);
    await connectionmanager.fetchStoryByUser(req, res);
  }

  static async fetchStoryOfOtherUsers(req: Request, res: Response) {
    let connectionmanager = getManager().getCustomRepository(StoryRepository);
    await connectionmanager.fetchStoryOfOtherUsers(req, res);
  }

  static async deleteStory(req: Request, res: Response) {
    let connectionmanager = getManager().getCustomRepository(StoryRepository);
    await connectionmanager.removeStory(req, res);
  }
}
