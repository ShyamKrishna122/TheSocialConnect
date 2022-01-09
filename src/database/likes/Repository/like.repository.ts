import { Request, Response } from "express";
import { EntityRepository, getCustomRepository, Repository } from "typeorm";
import { PostRepository } from "../../posts/repository/post.repository";
import { UserRepository } from "../../user/repository/user.repository";
import { LikeEntity } from "../entity/like.entity";

@EntityRepository(LikeEntity)
export class LikeRepository extends Repository<LikeEntity> {
  //! adding like to a post
  async addLike(req: Request, res: Response) {
    let postId = req.params.postId;
    let userEmail = req.params.userEmail;

    let postRepo = getCustomRepository(PostRepository);
    let post = await postRepo.findOne({ postId: postId });

    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({ userEmail: userEmail });

    try {
      let like = new LikeEntity();
      like.post = post!;
      like.user = user!;
      await like.save();
      return res.send({
        message: "like added",
        liked: true,
      });
    } catch (error) {
      return res.send({
        message: "Something went wrong",
        liked: false,
      });
    }
  }

  //! removing like of post

  async removeLike(req: Request, res: Response) {
    let postId = req.params.postId;
    let userEmail = req.params.userEmail;

    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({ userEmail: userEmail });

    try {
      await this.createQueryBuilder("like")
        .delete()
        .from(LikeEntity)
        .where("postPostId=:postId", { postId: postId })
        .andWhere("userId=:userId", { userId: user?.id })
        .execute()
        .then((data: any) => {
          return res.send({
            message: "Like removed",
            unliked: true,
          });
        });
    } catch (error) {
      return res.send({
        message: "Something went wrong",
        unliked: false,
      });
    }
  }

  //! checking if post is liked by the logged in user

  async isLikedByUser(req: Request, res: Response) {
    let postId = req.params.postId;
    let userEmail = req.params.userEmail;
    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({ userEmail: userEmail });

    try {
      let isLiked =
        (await this.createQueryBuilder("like")
          .where("like.postPostId = :postId", {
            postId: postId,
          })
          .andWhere("like.userId = :id", { id: user?.id })
          .getCount()) >= 1;
      if (isLiked) {
        return res.send({
          message: "yes",
          isliked: true,
        });
      } else {
        return res.send({
          message: "no",
          isliked: false,
        });
      }
    } catch (error) {
      console.log(error);
      return res.send({
        message: "Something went wrong",
        isliked: false,
      });
    }
  }

  //! get the total number of likes of a post

  async getPostLikesCount(req: Request, res: Response) {
    let { postId } = req.params;

    try {
      let likeCount = await this.createQueryBuilder("like")
        .where("like.postPostId=:id", { id: postId })
        .getCount();
      return res.send({
        data: likeCount,
        received: true,
      });
    } catch (error) {
      return res.send({
        data: "Something went wrong",
        received: false,
      });
    }
  }

  //!get list of persons who liked the post..

  async getPersonList(req: Request, res: Response) {
    let postId = req.params.postId;
    try {
      let likeData = await this.createQueryBuilder("like")
        .leftJoinAndSelect("like.user", "user")
        .leftJoinAndSelect("user.info","info")
        .where("like.postPostId = :id", { id: postId })
        .getMany();
      if (likeData !== undefined) {
        return res.send({
          data: likeData,
          received: true,
        });
      } else {
        return res.send({
          data: "Fill some info",
          received: true,
        });
      }
    }
    catch (error) {
      return res.send({
        data: "Something went wrong",
        received: false,
      });
    }
  }
}
