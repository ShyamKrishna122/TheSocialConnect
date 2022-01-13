import { Request, Response } from "express";
import { EntityRepository, getCustomRepository, Repository } from "typeorm";
import { UserRepository } from "../../user/repository/user.repository";
import { StoryViewEntity } from "../entity/story_views.entity";
import { StoryRepository } from "./story.repository";

@EntityRepository(StoryViewEntity)
export class StoryViewRepository extends Repository<StoryViewEntity> {
    //! add story view
    async addStoryView(req: Request, res: Response) {
        let storyId = req.params.storyId;
        let userEmail = req.params.userEmail;

        let storyRepo = getCustomRepository(StoryRepository);
        let story = await storyRepo.findOne({ storyId: storyId });

        let userRepo = getCustomRepository(UserRepository);
        let user = await userRepo.findOne({ userEmail: userEmail });

        try {
            let view = new StoryViewEntity();
            view.story = story!;
            view.user = user!;
            await view.save();
            return res.send({
                message: "like added",
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
        let storyId = req.params.storyId;
        let userEmail = req.params.userEmail;
        let userRepo = getCustomRepository(UserRepository);
        let user = await userRepo.findOne({ userEmail: userEmail });

        try {
            let isViewed =
                (await this.createQueryBuilder("view")
                    .where("view.storyStoryId = :storyId", {
                        storyId: storyId,
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
        let { storyId } = req.params;

        try {
            let viewCount = await this.createQueryBuilder("view")
                .where("view.storyStoryId=:id", { id: storyId })
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