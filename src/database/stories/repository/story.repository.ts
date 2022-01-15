import { Request, Response } from "express";
import { EntityRepository, getCustomRepository, Repository } from "typeorm";
import { FollowRepository } from "../../followers/repository/follow.repository";
import { UserRepository } from "../../user/repository/user.repository";
import { StoryEntity } from "../entity/stories.entity";

@EntityRepository(StoryEntity)
export class StoryRepository extends Repository<StoryEntity> {
  //! add story function
  async addStory(req: Request, res: Response) {
    let { userEmail } = req.params;

    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({
      userEmail: userEmail,
    });

    try {
      let story = new StoryEntity();
      story.user = user!;
      await story.save();
      return res.send({
        data: "Story Added",
        added: true,
      });
    } catch (error) {
      return res.send({
        added: false,
        data: "Something went wrong",
      });
    }
  }

  async fetchStory(req: Request, res: Response) {
    let { userEmail } = req.params;
    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({
      userEmail: userEmail,
    });

    let followRepo = getCustomRepository(FollowRepository);
    try {
      let subQuery = followRepo
        .createQueryBuilder("ScFollow")
        .select("ScFollow.followerId", "fId")
        .where("ScFollow.userId = :id", { id: user?.id });
      let storyData = await this.createQueryBuilder("ScStories")
        .select("*")
        .innerJoin("ScStories.user", "user")
        .innerJoin("user.info", "info")
        .innerJoin("ScStories.storyMedia", "storyMedia")
        .innerJoin("storyMedia.story", "story")
        .where("ScStories.userId IN (" + subQuery.getQuery() + ")")
        .orWhere("ScStories.userId = :id", { id: user?.id })
        .orderBy("storyMedia.storyTime", "DESC")
        .setParameters(subQuery.getParameters())
        .getRawMany();
      let stories = storyData.map((s: any) => {
        const story: any = {
          storyId: s.storyId,
          storyTime: s.storyTime,
          storyMediaId: s.storyMediaId,
          storyMediaUrl: s.mediaUrl,
          storyMediaType: s.mediaType,
          userId: s.userId,
          userEmail: s.userEmail,
          userName: s.userName,
          userDp: s.userDp,
        };
        return story;
      });

      return res.send({
        data: stories,
        received: true,
      });
    } catch (error) {
      return res.send({
        received: false,
        data: "Something Went Wrong",
      });
    }
  }

  async fetchStoryByUser(req: Request, res: Response) {
    let { userEmail } = req.params;
    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({ userEmail: userEmail });
    try {
      let storyData = await this.createQueryBuilder("story")
        .select("*")
        .leftJoin("story.user", "user")
        .leftJoin("user.info", "info")
        .leftJoin("story.storyMedia", "storyMedia")
        .where("story.userId = :id", { id: user?.id })
        .orderBy("storyMedia.storyTime", "DESC")
        .getRawMany();
      let stories = storyData.map((s: any) => {
        const story: any = {
          storyId: s.storyId,
          storyTime: s.storyTime,
          storyMediaId: s.storyMediaId,
          storyMediaUrl: s.mediaUrl,
          storyMediaType: s.mediaType,
          userId: s.userId,
          userEmail: s.userEmail,
          userName: s.userName,
          userDp: s.userDp,
        };
        return story;
      });
      return res.send({
        data: stories,
        received: true,
      });
    } catch (error) {
      return res.send({
        received: false,
        data: "Something Went Wrong",
      });
    }
  }

  //! remove story...
  async removeStory(req: Request, res: Response) {
    let storyId = req.params.storyId;
    let userEmail = req.params.userEmail;
    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({ userEmail: userEmail });

    try {
      await this.createQueryBuilder("ScStories")
        .delete()
        .from(StoryEntity)
        .where("storyId=:storyId", { storyId: storyId })
        .andWhere("userId=:userId", { userId: user?.id })
        .execute()
        .then((data: any) => {
          return res.send({
            message: "Story removed",
            deleted: true,
          });
        });
    } catch (error) {
      return res.send({
        message: "Something went wrong",
        deleted: false,
      });
    }
  }
}
