import { Request, Response } from "express";
import { EntityRepository, getCustomRepository, Repository } from "typeorm";
import { UserRepository } from "../../user/repository/user.repository";
import { FollowEntity } from "../entity/follower.entity";

@EntityRepository(FollowEntity)
export class FollowRepository extends Repository<FollowEntity> {

  //! follow people
  async addFollowing(req: Request, res: Response) {
    let userEmail = req.params.userEmail;
    let followingId = req.params.followingId;

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
    let userEmail = req.params.userEmail;
    let followingId = req.params.followingId;

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
        unFollowed: true,
        data: deletedData,
      });
    } catch (error) {
      return res.send({
        unFollowed: false,
        message: "Something went wrong",
        data: "Error",
      });
    }
  }

  //! checking if a user follows another user or not
  async isFollowingUser(req: Request, res: Response) {
    let userEmail = req.params.userEmail;
    let followingId = req.params.followingId;

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

  async getFollowingCount(req: Request, res: Response) {
    let userEmail = req.params.userEmail;
    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({ userEmail: userEmail });
    try {
      let followingCount =
        (await this.createQueryBuilder("follow")
          .where("follow.userId=:id", { id: user?.id })
          .getCount());
      return res.send({
        data: followingCount,
        received: true,
      });
    } catch (error) {
      return res.send({
        data: "Something went wrong",
        received: false,
      });
    }
  }

  async getFollowersCount(req: Request, res: Response) {
    let userEmail = req.params.userEmail;
    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({ userEmail: userEmail });
    try {
      let followersCount =
        (await this.createQueryBuilder("follow")
          .where("follow.followerId=:followingId", {
            followingId: user?.id,
          })
          .getCount());
      return res.send({
        data: followersCount,
        received: true,
      });
    } catch (error) {
      return res.send({
        data: "Something went wrong",
        received: false,
      });
    }
  }

  //!fetch info of followers

  async getFollowersInfo(req: Request, res: Response) {
    let { userEmail } = req.params;
    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({ userEmail: userEmail });

    try {
      let followersData = await this.createQueryBuilder("ScFollow")
        .select("*")
        .leftJoin("ScFollow.user", "user")
        .leftJoin("user.info", "info")
        .where("ScFollow.followerId=:followingId", {
          followingId: user?.id,
        })
        .getRawMany();
      if (followersData !== undefined) {
        return res.send({
          data: followersData,
          received: true,
        });
      } else {
        return res.send({
          data: "Fill some info",
          received: false,
        });
      }
    } catch (error) {
      return res.send({
        data: "Something went wrong",
        filled: false,
      });
    }
  }

  //!fetch info of followers

  async getFollowingInfo(req: Request, res: Response) {
    let { userEmail } = req.params;
    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({ userEmail: userEmail });

    try {
      let subQuery = this
        .createQueryBuilder("ScFollow")
        .select("ScFollow.followerId")
        .where("ScFollow.userId = :id", { id: user?.id });
      
      let followingData = await userRepo.createQueryBuilder("scUsers")
      .select("*")
      .leftJoin("scUsers.info","info")
      .where("scUsers.id IN (" + subQuery.getQuery() + ")")
      .setParameters(subQuery.getParameters())
      .getRawMany();
      if (followingData !== undefined) {
        return res.send({
          data: followingData,
          received: true,
        });
      } else {
        return res.send({
          data: "Fill some info",
          received: false,
        });
      }
    } catch (error) {
      return res.send({
        data: "Something went wrong",
        received: false,
      });
    }
  }
}
