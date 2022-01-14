import { Request, Response } from "express";
import { EntityRepository, getCustomRepository, Repository } from "typeorm";
import { UserRepository } from "../../user/repository/user.repository";
import { StoryViewEntity } from "../entity/story_views.entity";
import { StoryRepository } from "./story.repository";
import { StoryMediaRepository } from "./story_media.repository";

@EntityRepository(StoryViewEntity)
export class StoryViewRepository extends Repository<StoryViewEntity> {
    //! add story view
    async addStoryView(req: Request, res: Response) {
        let storyMediaId = req.params.storyMediaId;
        let userEmail = req.params.userEmail;

        let storyMediaRepo = getCustomRepository(StoryMediaRepository);
        let storyMedia = await storyMediaRepo.findOne({ storyMediaId: storyMediaId });

        let userRepo = getCustomRepository(UserRepository);
        let user = await userRepo.findOne({ userEmail: userEmail });

        try {
            let view = new StoryViewEntity();
            view.storyMedia = storyMedia!;
            view.user = user!;
            await view.save();
            return res.send({
                message: "view added",
                viewed: true,
            });
        } catch (error) {
            return res.send({
                message: "Something went wrong",
                viewed: false,
            });
        }
    }


    //! checking if a user follows another user or not
    async isViewedByUser(req: Request, res: Response) {
        let storyMediaId = req.params.storyMediaId;
        let userEmail = req.params.userEmail;
        let userRepo = getCustomRepository(UserRepository);
        let user = await userRepo.findOne({ userEmail: userEmail });

        try {
            let isViewed =
                (await this.createQueryBuilder("view")
                    .where("view.storyMediaStoryMediaId = :storyMediaId", {
                        storyMediaId: storyMediaId,
                    })
                    .andWhere("view.userId = :id", { id: user?.id })
                    .getCount()) >= 1;
            if (isViewed) {
                return res.send({
                    message: "yes",
                    isviewed: true,
                });
            } else {
                return res.send({
                    message: "no",
                    isviewed: false,
                });
            }
        } catch (error) {
            console.log(error);
            return res.send({
                message: "Something went wrong",
                isViewed: false,
            });
        }
    }

    //! get the total number of views of a story
    async getStoryViewCount(req: Request, res: Response) {
        let { storyMediaId } = req.params;

        try {
            let viewCount = await this.createQueryBuilder("view")
                .where("view.storyMediaStoryMediaId=:id", { id: storyMediaId })
                .getCount();
            return res.send({
                data: viewCount,
                received: true,
            });
        } catch (error) {
            return res.send({
                data: "Something went wrong",
                received: false,
            });
        }
    }
}