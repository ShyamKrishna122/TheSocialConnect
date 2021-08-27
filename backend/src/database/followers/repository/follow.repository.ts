import { Request, Response } from "express";
import { EntityRepository, getCustomRepository, Repository } from "typeorm";
import { UserRepository } from "../../user/repository/user.repository";
import { FollowEntity } from "../entity/follower.entity";

@EntityRepository(FollowEntity)
export class FollowRepository extends Repository<FollowEntity> {

  //! follow people
  async addFollowing(req: Request, res: Response) {
    let { followingId } = req.params;
    let { userEmail } = req.body;

    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({ userEmail: userEmail });

    try {
      let following = new FollowEntity();
      following.followerId = followingId;
      following.user = user!;
      await following.save();
      return res.send({
        message: "You are following",
        following: true,
      });
    } catch (error) {
      return res.send({
        following: false,
        message: "Something went wrong",
      });
    }
  }

  //! unfollow people

  async removeFollowing(req: Request, res: Response) {
    let { followingId } = req.params;
    let { userEmail } = req.body;

    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({ userEmail: userEmail });
    try {
      let deletedData = await this.createQueryBuilder("follow")
        .delete()
        .from(FollowEntity)
        .where("userId=:id", { id: user?.id })
        .andWhere("followerId=:followingId", {
          followingId: followingId,
        })
        .execute();

      return res.send({
        message: "You have unfollowed",
        following: false,
        data: deletedData,
      });
    } catch (error) {
      return res.send({
        following: false,
        message: "Something went wrong",
        data: "Error",
      });
    }
  }

  //! checking if a user follows another user or not
  async isFollowingUser(req: Request, res: Response) {
    let { followingId } = req.params;
    let { userEmail } = req.body;

    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({ userEmail: userEmail });
    try {
      let isFollowing =
        (await this.createQueryBuilder("follow")
          .where("follow.userId=:id", { id: user?.id })
          .andWhere("follow.followerId=:followingId", {
            followingId: followingId,
          })
          .getCount()) >= 1;

      if (isFollowing) {
        return res.send({
          following: true,
          message: "You are already following",
        });
      } else {
        return res.send({
          following: false,
          message: "Follow Now",
        });
      }
    } catch (error) {
      console.log(error)
      return res.send({
        following: false,
        message: "Something went wrong",
        data: "Error",
      });
    }
  }
}
