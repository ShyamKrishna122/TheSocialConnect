import { Request, Response } from "express";
import { EntityRepository, getCustomRepository, Repository } from "typeorm";
import { StoryMediaEntity } from "../entity/stories_media.entity";
import { StoryRepository } from "./story.repository";

@EntityRepository(StoryMediaEntity)
export class StoryMediaRepository extends Repository<StoryMediaEntity> {
    async addStoryMedia(req: Request, res: Response) {
        let { storyId } = req.params;
        let { mediaType, mediaUrl } = req.body;

        let storyRepo = getCustomRepository(StoryRepository);
        let story = await storyRepo.findOne({
            storyId: storyId,
        });

        try {
            let storyMedia = new StoryMediaEntity();
            storyMedia.mediaType = mediaType;
            storyMedia.mediaUrl = mediaUrl;
            storyMedia.story = story!;
            await storyMedia.save();
            return res.send({
                message: "story Media Added",
                added: true,
            });
        }
        catch (error) {
            return res.send({
                added: false,
                data: "Something went wrong",
            });
        }
    }
}