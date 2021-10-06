import { Request, Response } from "express";
import { EntityRepository, getCustomRepository, Repository } from "typeorm";
import { UserRepository } from "../../user/repository/user.repository";
import { StoryEntity } from "../entity/stories.entity";

@EntityRepository(StoryEntity)
export class StoryRepository extends Repository<StoryEntity> {
  //! add story function
  async addStory(req: Request, res: Response) {
    let { userEmail } = req.params;
    let { storyMedia } = req.body;

    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({
      userEmail: userEmail,
    });

    try {
      let story = new StoryEntity();
      story.storyMedia = storyMedia;
      story.user = user!;
      await story.save();
      return res.send({
        message: "Story Added",
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
    try {
      let stories = await this.createQueryBuilder("ScStories")
        .leftJoinAndSelect("ScStories.user", "user")
        .select()
        .getMany();
      if (stories !== undefined) {
        return res.send({
          data: stories,
          filled: true,
          received: true,
        });
      } else {
        return res.send({
          data: "Fill some info",
          filled: false,
          received: true,
        });
      }
    } catch (error) {
      return res.send({
        received: false,
        message: "Something Went Wrong",
      });
    }
  }

  async fetchStoryByUser(req: Request, res: Response) {
    let { userEmail } = req.params;
    try {
      let stories = await this.createQueryBuilder("ScStories")
        .leftJoinAndSelect("ScStories.user", "user")
        .select()
        .where("user.userEmail=:userEmail", { userEmail: userEmail })
        .getMany();
      if (stories !== undefined) {
        return res.send({
          data: stories,
          filled: true,
          received: true,
        });
      } else {
        return res.send({
          data: "Fill some info",
          filled: false,
          received: true,
        });
      }
    } catch (error) {
      return res.send({
        received: false,
        message: "Something Went Wrong",
      });
    }
  }

  async fetchStoryOfOtherUsers(req: Request, res: Response) {
    let { userEmail } = req.params;
    try {
      let stories = await this.createQueryBuilder("ScStories")
        .leftJoinAndSelect("ScStories.user", "user")
        .select()
        .where("user.userEmail!=:userEmail", { userEmail: userEmail })
        .getMany();
      if (stories !== undefined) {
        return res.send({
          data: stories,
          filled: true,
          received: true,
        });
      } else {
        return res.send({
          data: "Fill some info",
          filled: false,
          received: true,
        });
      }
    } catch (error) {
      return res.send({
        received: false,
        message: "Something Went Wrong",
      });
    }
  }

  //! remove story...
  async removeStory(req: Request, res: Response) {
    let { storyId } = req.params;

    try {
      await this.createQueryBuilder("ScStories")
        .delete()
        .from(StoryEntity)
        .where("storyId=:storyId", { storyId: storyId })
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
